CREATE TABLE users (
    user_id INTEGER,
    user_name TEXT,
    country TEXT,
    signup_date TEXT
);

CREATE TABLE sessions (
    session_id INTEGER,
    user_id INTEGER,
    session_date TEXT,
    duration_minutes INTEGER
);

CREATE TABLE events (
    event_id INTEGER,
    user_id INTEGER,
    event_type TEXT,
    event_date TEXT
);

INSERT INTO users VALUES
(1, 'Alice', 'Ireland', '2024-01-01'),
(2, 'Ben', 'UK', '2024-01-03'),
(3, 'Clara', 'Ireland', '2024-01-05'),
(4, 'David', 'Germany', '2024-01-08'),
(5, 'Emma', 'France', '2024-01-10'),
(6, 'Finn', 'UK', '2024-01-12'),
(7, 'Grace', 'Ireland', '2024-01-15'),
(8, 'Hugo', 'Germany', '2024-01-18'),
(9, 'Isla', 'France', '2024-01-20'),
(10, 'Jack', 'UK', '2024-01-25'),
(11, 'Kate', 'Ireland', '2024-02-01'),
(12, 'Leo', 'Germany', '2024-02-05'),
(13, 'Mia', 'Ireland', '2024-02-08'),
(14, 'Noah', 'France', '2024-02-12'),
(15, 'Olivia', 'UK', '2024-02-15');

INSERT INTO sessions VALUES
(101, 1, '2024-02-20', 15),
(102, 1, '2024-02-22', 18),
(103, 2, '2024-02-20', 10),
(104, 2, '2024-02-23', 12),
(105, 3, '2024-02-21', 25),
(106, 3, '2024-02-24', 20),
(107, 4, '2024-02-21', 30),
(108, 4, '2024-02-25', 28),
(109, 5, '2024-02-22', 14),
(110, 5, '2024-02-24', 16),
(111, 6, '2024-02-22', 19),
(112, 6, '2024-02-26', 21),
(113, 7, '2024-02-23', 35),
(114, 7, '2024-02-27', 32),
(115, 8, '2024-02-23', 17),
(116, 8, '2024-02-28', 15),
(117, 9, '2024-02-24', 22),
(118, 9, '2024-02-28', 24),
(119, 10, '2024-02-24', 11),
(120, 10, '2024-02-29', 13),
(121, 11, '2024-02-25', 40),
(122, 11, '2024-03-01', 38),
(123, 12, '2024-02-25', 26),
(124, 12, '2024-03-02', 27),
(125, 13, '2024-02-26', 29),
(126, 13, '2024-03-03', 31),
(127, 14, '2024-02-27', 16),
(128, 14, '2024-03-03', 18),
(129, 15, '2024-02-28', 23),
(130, 15, '2024-03-04', 25);

INSERT INTO events VALUES
(201, 1, 'login', '2024-02-20'),
(202, 1, 'like', '2024-02-20'),
(203, 1, 'comment', '2024-02-22'),
(204, 2, 'login', '2024-02-20'),
(205, 2, 'view', '2024-02-23'),
(206, 3, 'login', '2024-02-21'),
(207, 3, 'share', '2024-02-24'),
(208, 4, 'login', '2024-02-21'),
(209, 4, 'like', '2024-02-25'),
(210, 5, 'login', '2024-02-22'),
(211, 5, 'comment', '2024-02-24'),
(212, 6, 'login', '2024-02-22'),
(213, 6, 'view', '2024-02-26'),
(214, 7, 'login', '2024-02-23'),
(215, 7, 'share', '2024-02-27'),
(216, 8, 'login', '2024-02-23'),
(217, 8, 'like', '2024-02-28'),
(218, 9, 'login', '2024-02-24'),
(219, 9, 'view', '2024-02-28'),
(220, 10, 'login', '2024-02-24'),
(221, 10, 'comment', '2024-02-29'),
(222, 11, 'login', '2024-02-25'),
(223, 11, 'share', '2024-03-01'),
(224, 12, 'login', '2024-02-25'),
(225, 12, 'view', '2024-03-02'),
(226, 13, 'login', '2024-02-26'),
(227, 13, 'like', '2024-03-03'),
(228, 14, 'login', '2024-02-27'),
(229, 14, 'comment', '2024-03-03'),
(230, 15, 'login', '2024-02-28'),
(231, 15, 'share', '2024-03-04'),
(232, 11, 'like', '2024-03-01'),
(233, 13, 'comment', '2024-03-03'),
(234, 7, 'view', '2024-02-27'),
(235, 3, 'like', '2024-02-24');

SELECT * FROM users;

SELECT * FROM sessions;

SELECT * FROM events;

SELECT
    country,
    COUNT(*) AS users_count
FROM users
GROUP BY country
ORDER BY users_count DESC;

SELECT
    signup_date,
    COUNT(*) AS users_per_day
FROM users
GROUP BY signup_date
ORDER BY signup_date;

SELECT
    signup_date,
    COUNT(*) AS users_per_day,
    SUM(COUNT(*)) OVER (ORDER BY signup_date) AS cumulative_users
FROM users
GROUP BY signup_date
ORDER BY signup_date;

SELECT
    u.country,
    COUNT(s.session_id) AS total_sessions
FROM users u
JOIN sessions s
    ON u.user_id = s.user_id
GROUP BY u.country
ORDER BY total_sessions DESC;

SELECT
    u.country,
    ROUND(AVG(s.duration_minutes), 2) AS avg_session_duration
FROM users u
JOIN sessions s
    ON u.user_id = s.user_id
GROUP BY u.country
ORDER BY avg_session_duration DESC;

SELECT
    u.user_name,
    u.country,
    COUNT(s.session_id) AS session_count,
    SUM(s.duration_minutes) AS total_minutes
FROM users u
JOIN sessions s
    ON u.user_id = s.user_id
GROUP BY u.user_id, u.user_name, u.country
ORDER BY total_minutes DESC;

SELECT
    event_type,
    COUNT(*) AS total_events
FROM events
GROUP BY event_type
ORDER BY total_events DESC;

SELECT
    u.country,
    e.event_type,
    COUNT(*) AS event_count
FROM users u
JOIN events e
    ON u.user_id = e.user_id
GROUP BY u.country, e.event_type
ORDER BY u.country, event_count DESC;

SELECT
    u.country,
    COUNT(DISTINCT u.user_id) AS unique_users,
    COUNT(e.event_id) AS total_events,
    ROUND(CAST(COUNT(e.event_id) AS REAL) / COUNT(DISTINCT u.user_id), 2) AS events_per_user
FROM users u
LEFT JOIN events e
    ON u.user_id = e.user_id
GROUP BY u.country
ORDER BY events_per_user DESC;
