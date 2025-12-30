CREATE OR REPLACE VIEW view_dashboard_master AS
SELECT 
    i.invoice_date AS record_date,
    DATE_FORMAT(i.invoice_date, '%Y-%m') AS month_year,
    c.customer_id,
    c.Region AS region,   
    p.plan_name,
    s.Status AS subscription_status,

    i.amount AS invoiced_amount,
    COALESCE(pay.amount_paid, 0) AS paid_amount,

    CASE 
        WHEN lr.leakage_category = 'Unpaid Invoice' THEN 1 
        ELSE 0 
    END AS is_zombie_invoice,

    0 AS is_ghost_subscriber, 

    COALESCE(lr.leakage_amount, 0) AS leakage_amount,
    COALESCE(lr.leakage_category, 'Clean Transaction') AS status_label

FROM invoices i
LEFT JOIN subscriptions s ON i.Sub_id = s.Sub_id
LEFT JOIN customers c ON s.customer_id = c.customer_id
LEFT JOIN plans p ON s.Plan_id = p.plan_id
LEFT JOIN payments pay ON i.invoice_id = pay.invoice_id
LEFT JOIN leakage_report lr 
    ON i.invoice_id = lr.source_id 
   AND lr.source_type = 'Invoice'

UNION ALL
SELECT 
    lr.leakage_date AS record_date,
    DATE_FORMAT(lr.leakage_date, '%Y-%m') AS month_year,

    s.customer_id,
    c.Region AS region,
    pl.plan_name,
    s.Status AS subscription_status,

    0 AS invoiced_amount, 
    0 AS paid_amount,     

    0 AS is_zombie_invoice,
    1 AS is_ghost_subscriber, 

    lr.leakage_amount AS leakage_amount,
    'Missing Invoice' AS status_label

FROM leakage_report lr
JOIN subscriptions s ON lr.source_id = s.Sub_id
JOIN customers c ON s.customer_id = c.customer_id
JOIN plans pl ON s.Plan_id = pl.plan_id
WHERE lr.source_type = 'Subscription';

SELECT * FROM view_dashboard_master;