DROP VIEW IF EXISTS user_channels CASCADE;
DROP VIEW IF EXISTS video_details CASCADE;
DROP VIEW IF EXISTS user_subscriptions CASCADE;
DROP VIEW IF EXISTS video_categories_view CASCADE;
DROP VIEW IF EXISTS comment_stats CASCADE;

CREATE VIEW user_channels AS
SELECT u.id AS user_id,
       u.username,
       u.email,
       c.channel_id,
       c.channel_name
FROM users u
         LEFT JOIN
     channels c ON u.id = c.user_id;

CREATE VIEW video_details AS
SELECT v.video_id,
       v.title,
       v.description,
       v.duration,
       v.published_at,
       v.views_count,
       v.likes_count,
       v.dislikes_count,
       c.channel_name,
       u.username AS uploaded_by
FROM videos v
         JOIN
     channels c ON v.channel_id = c.channel_id
         JOIN
     users u ON c.user_id = u.id;

CREATE VIEW user_subscriptions AS
SELECT u.id AS user_id,
       u.username,
       c.channel_id,
       c.channel_name,
       s.subscribed_at
FROM subscriptions s
         JOIN
     users u ON s.user_id = u.id
         JOIN
     channels c ON s.channel_id = c.channel_id;

CREATE VIEW video_categories_view AS
SELECT v.video_id,
       v.title,
       STRING_AGG(c.name, ', ') AS categories
FROM videos v
         JOIN
     video_categories vc ON v.video_id = vc.video_id
         JOIN
     categories c ON vc.category_id = c.category_id
GROUP BY v.video_id, v.title;

CREATE VIEW comment_stats AS
SELECT v.video_id,
       v.title,
       COUNT(c.comment_id)   AS total_comments,
       SUM(c.likes_count)    AS total_likes,
       SUM(c.dislikes_count) AS total_dislikes
FROM videos v
         LEFT JOIN
     comments c ON v.video_id = c.video_id
GROUP BY v.video_id, v.title;