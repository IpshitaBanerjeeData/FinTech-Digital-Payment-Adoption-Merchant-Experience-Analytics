CREATE DATABASE fintech_db;
USE fintech_db;

SELECT * FROM fintech_db.cleaned_wallet_transactions;

-- 1. Core Executive KPIs (Single Source of Truth)
SELECT 
    COUNT(transaction_id) AS total_transactions,
    ROUND(SUM(CASE WHEN is_successful = 1 THEN product_amount ELSE 0 END), 2) AS total_payment_volume_tpv,
    ROUND(AVG(is_successful) * 100, 2) AS payment_success_rate_pct,
    ROUND(SUM(CASE WHEN is_successful = 1 THEN net_revenue ELSE 0 END), 2) AS total_net_revenue,
    ROUND(AVG(CASE WHEN is_successful = 1 AND product_amount > 0 THEN (net_revenue / product_amount) * 100 END), 2) AS avg_net_take_rate_pct
FROM cleaned_wallet_transactions;

-- 2. Payment Adoption & Friction by Payment Method & Device
SELECT 
    payment_method,
    device_type,
    COUNT(*) AS txn_attempts,
    ROUND(AVG(is_successful) * 100, 2) AS success_rate_pct,
    ROUND(SUM(CASE WHEN is_successful = 0 THEN product_amount ELSE 0 END), 2) AS failed_volume_at_risk
FROM cleaned_wallet_transactions
GROUP BY payment_method, device_type
ORDER BY success_rate_pct ASC;

-- 3. Merchant Partner Health & Concentration
SELECT 
    merchant_name,
    product_category,
    COUNT(*) AS total_txns,
    ROUND(SUM(CASE WHEN is_successful = 1 THEN product_amount ELSE 0 END), 2) AS successful_tpv,
    ROUND(AVG(is_successful) * 100, 2) AS partner_success_rate_pct
FROM cleaned_wallet_transactions
GROUP BY merchant_name, product_category
HAVING total_txns >= 20
ORDER BY successful_tpv DESC;

-- 4. Cashback & Loyalty Impact on Repeat Adoption
-- Note: Replace user_id with customer_id if your CSV uses customer_id
WITH user_adoption AS (
    SELECT 
        user_id,
        MAX(CASE WHEN cashback > 0 OR loyalty_points > 0 THEN 1 ELSE 0 END) AS got_incentive,
        COUNT(transaction_id) AS successful_txns
    FROM cleaned_wallet_transactions
    WHERE is_successful = 1
    GROUP BY user_id
)
SELECT 
    got_incentive,
    COUNT(user_id) AS active_users,
    ROUND(AVG(successful_txns), 2) AS avg_txns_per_user,
    ROUND(SUM(CASE WHEN successful_txns > 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(user_id), 2) AS repeat_adoption_rate_pct
FROM user_adoption
GROUP BY got_incentive;