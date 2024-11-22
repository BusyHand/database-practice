-- 1. Удалить пользователя по ID
DELETE FROM users
WHERE id = 4;

-- 2. Удалить канал по названию
DELETE FROM channels
WHERE channel_name = 'Foodie Corner';

-- 3. Удалить видео по ID
DELETE FROM videos
WHERE video_id = 2;

-- 4. Удалить комментарий по ID
DELETE FROM comments
WHERE comment_id = 3;

-- 5. Удалить подписку по пользовательскому ID и ID канала
DELETE FROM subscriptions
WHERE user_id = 1 AND channel_id = 1;

-- 6. Удалить запись видео-лайка по ID
DELETE FROM video_likes
WHERE like_id = 1;

-- 7. Удалить уведомления определенного типа
DELETE FROM notifications
WHERE type = 'like';
