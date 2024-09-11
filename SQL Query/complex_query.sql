WITH customer_segments AS (
    SELECT 
        c.customer_id,
        c.name,
        c.email,
        COUNT(DISTINCT o.order_id) AS total_orders,
        SUM(o.total_amount) AS total_spent,
        AVG(o.total_amount) AS avg_order_value,
        MAX(o.order_date) AS last_order_date,
        DATEDIFF(CURRENT_DATE, MAX(o.order_date)) AS days_since_last_order,
        CASE 
            WHEN COUNT(DISTINCT o.order_id) > 10 AND SUM(o.total_amount) > 1000 THEN 'VIP'
            WHEN COUNT(DISTINCT o.order_id) > 5 AND SUM(o.total_amount) > 500 THEN 'Regular'
            ELSE 'Occasional'
        END AS customer_segment
    FROM 
        customers c
    LEFT JOIN 
        orders o ON c.customer_id = o.customer_id
    GROUP BY 
        c.customer_id, c.name, c.email
),
product_performance AS (
    SELECT 
        p.product_id,
        p.name AS product_name,
        c.category_name,
        s.supplier_name,
        COUNT(DISTINCT oi.order_id) AS total_orders,
        SUM(oi.quantity) AS total_quantity_sold,
        SUM(oi.quantity * oi.price_per_unit) AS total_revenue,
        AVG(cr.rating) AS avg_rating,
        COUNT(cr.review_id) AS review_count
    FROM 
        products p
    JOIN 
        categories c ON p.category_id = c.category_id
    JOIN 
        suppliers s ON p.supplier_id = s.supplier_id
    LEFT JOIN 
        order_items oi ON p.product_id = oi.product_id
    LEFT JOIN 
        customer_reviews cr ON p.product_id = cr.product_id
    GROUP BY 
        p.product_id, p.name, c.category_name, s.supplier_name
),
inventory_status AS (
    SELECT 
        i.product_id,
        i.quantity_in_stock,
        i.reorder_level,
        i.last_restock_date,
        DATEDIFF(CURRENT_DATE, i.last_restock_date) AS days_since_last_restock,
        CASE 
            WHEN i.quantity_in_stock <= i.reorder_level THEN 'Reorder'
            WHEN i.quantity_in_stock <= i.reorder_level * 2 THEN 'Low Stock'
            ELSE 'Adequate'
        END AS stock_status
    FROM 
        inventory i
),
promotion_effectiveness AS (
    SELECT 
        p.promotion_id,
        p.promotion_name,
        p.start_date,
        p.end_date,
        COUNT(DISTINCT o.order_id) AS orders_with_promotion,
        SUM(o.total_amount) AS total_revenue_with_promotion,
        AVG(o.total_amount) AS avg_order_value_with_promotion
    FROM 
        promotions p
    LEFT JOIN 
        orders o ON o.order_date BETWEEN p.start_date AND p.end_date
                 AND o.promotion_id = p.promotion_id
    GROUP BY 
        p.promotion_id, p.promotion_name, p.start_date, p.end_date
)
SELECT 
    cs.customer_segment,
    COUNT(DISTINCT cs.customer_id) AS customer_count,
    AVG(cs.total_spent) AS avg_customer_lifetime_value,
    pp.category_name,
    pp.product_name,
    pp.total_revenue AS product_revenue,
    pp.total_quantity_sold,
    pp.avg_rating,
    is.stock_status,
    is.quantity_in_stock,
    pe.promotion_name,
    pe.orders_with_promotion,
    pe.total_revenue_with_promotion,
    DENSE_RANK() OVER (PARTITION BY cs.customer_segment ORDER BY pp.total_revenue DESC) AS product_rank_in_segment
FROM 
    customer_segments cs
CROSS JOIN 
    product_performance pp
JOIN 
    inventory_status is ON pp.product_id = is.product_id
LEFT JOIN 
    promotion_effectiveness pe ON pe.start_date <= CURRENT_DATE AND pe.end_date >= CURRENT_DATE
WHERE 
    cs.days_since_last_order <= 365  -- Active customers in the last year
    AND pp.total_quantity_sold > 0   -- Products that have been sold
GROUP BY 
    cs.customer_segment,
    pp.category_name,
    pp.product_name,
    pp.total_revenue,
    pp.total_quantity_sold,
    pp.avg_rating,
    is.stock_status,
    is.quantity_in_stock,
    pe.promotion_name,
    pe.orders_with_promotion,
    pe.total_revenue_with_promotion
HAVING 
    COUNT(DISTINCT cs.customer_id) > 10  -- Segments with more than 10 customers
ORDER BY 
    cs.customer_segment,
    product_rank_in_segment
LIMIT 1000;
