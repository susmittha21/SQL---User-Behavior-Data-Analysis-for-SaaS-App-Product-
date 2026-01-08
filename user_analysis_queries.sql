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

-- 4. ACTIVE USERS (LOGGED ATLEAST ONCE)
SELECT COUNT(DISTINCT user_id) AS active_users
FROM events
WHERE event_type = 'login';

-- 5. DROPOFF (SIGNED ,NOT LOGGED IN)
SELECT u.user_id
FROM users u
LEFT JOIN events e
ON u.user_id = e.user_id AND e.event_type = 'login'
WHERE e.user_id IS NULL;







