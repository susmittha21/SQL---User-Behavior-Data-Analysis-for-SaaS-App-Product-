SHOW DATABASES;
USE user_behavior_analysis;

-- STARTING WITH A SAMPLE DATASET TO UNDERSTAND THE BUSINESS ANALYSIS

CREATE TABLE users (
    user_id INT PRIMARY KEY,
    signup_date DATE,
    source VARCHAR(20)
);

CREATE TABLE events(
    event_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    event_date DATE,
    event_type VARCHAR(30)
);

SHOW tables;

SELECT * from users;

SELECT * from events;


 -- 1. TO CHECK THROUGH WHICH SOURCE MORE USERS ARE REGISTERING 
SELECT source, COUNT(*) AS users_count
FROM users
GROUP BY source;

-- 2. SIGNUPS PER DAY (TRENDS)
SELECT signup_date, COUNT(*) AS signups
FROM users
GROUP BY signup_date
ORDER BY signup_date;

-- 3. COMMON USER ACTIONS
SELECT event_type, COUNT(*) AS event_count
FROM events
GROUP BY event_type
ORDER BY event_count DESC;

-- 4. ACTIVE USERS (LOGGED ATLEAST ONCE) - MEASURES ACTUAL PRODUCT USAGE
SELECT COUNT(DISTINCT user_id) AS active_users
FROM events
WHERE event_type = 'login';

-- 5. DROPOFF (SIGNED ,NOT LOGGED IN) - 30 USERS
SELECT u.user_id
FROM users u
LEFT JOIN events e
ON u.user_id = e.user_id AND e.event_type = 'login'
WHERE e.user_id IS NULL;


-- 6. FUNNEL ANALYSIS - USER DROPOFF AT EACH FUNNEL STAGE
SELECT
    SUM(event_type = 'signup') AS signups,
    SUM(event_type = 'login') AS logins,
    SUM(event_type = 'add_to_cart') AS add_to_cart,
    SUM(event_type = 'purchase') AS purchases
FROM events;

-- 7. CONVERSION RATE FROM SIGNUP TO PURCHASE 
SELECT
    COUNT(DISTINCT CASE WHEN event_type = 'purchase' THEN user_id END) * 100.0
    / COUNT(DISTINCT user_id) AS conversion_rate_percent
FROM events;

-- 8. PURCHASES GROUPED BY SINGLE SOURCE
SELECT u.source, COUNT(DISTINCT e.user_id) AS purchasers
FROM users u
JOIN events e
ON u.user_id = e.user_id
WHERE e.event_type = 'purchase'
GROUP BY u.source;

-- 9. DAYS TAKEN FROM SIGNUP TILL PURCHASE 
SELECT
    u.user_id,
    DATEDIFF(MIN(e.event_date), u.signup_date) AS days_to_purchase
FROM users u
JOIN events e
ON u.user_id = e.user_id
WHERE e.event_type = 'purchase'
GROUP BY u.user_id;

-- 10. SIGNUP TO PURCHASE RATE 
SELECT
    ROUND(
        COUNT(DISTINCT p.user_id) * 100.0 /
        COUNT(DISTINCT u.user_id),
        2
    ) AS signup_to_purchase_rate
FROM users u
LEFT JOIN events p
  ON u.user_id = p.user_id
  AND p.event_type = 'purchase';


-- 11. SIMPLE RETENTION - MEASURES SHORT TERM USER RETENTION
SELECT
    COUNT(DISTINCT u.user_id) AS retained_users
FROM users u
JOIN events e
  ON u.user_id = e.user_id
WHERE e.event_type = 'login'
  AND DATEDIFF(e.event_date, u.signup_date) BETWEEN 1 AND 7;

