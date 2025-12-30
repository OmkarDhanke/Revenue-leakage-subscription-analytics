SELECT 
    lr.leakage_date,
    lr.leakage_category,
    lr.leakage_amount,
    p.plan_name,
    c.region
FROM leakage_report lr
LEFT JOIN invoices i 
ON lr.source_type = 'Invoice' 
AND lr.source_id = i.invoice_id
LEFT JOIN subscriptions s1 
ON i.sub_id = s1.sub_id
LEFT JOIN subscriptions s2 
ON lr.source_type = 'Subscription' 
AND lr.source_id = s2.sub_id
LEFT JOIN subscriptions s 
ON s.sub_id = COALESCE(s1.sub_id, s2.sub_id)
LEFT JOIN plans p 
ON s.plan_id = p.plan_id
LEFT JOIN customers c 
ON s.customer_id = c.customer_id;