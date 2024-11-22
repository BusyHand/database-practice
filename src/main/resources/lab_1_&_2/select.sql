-- 1. Выбор всех пользователей с их ролями
SELECT username, role
FROM users;

-- 2. Выбор всех видео, у которых количество просмотров больше 1000
SELECT title, views_count
FROM videos
WHERE views_count > 1000;

-- 3. Выбор всех каналов с количеством подписчиков больше 10
SELECT channel_name, subscribers_count
FROM channels
WHERE subscribers_count > 10;

-- 4. Выбор видео по конкретному пользователю (подзапрос с IN)
SELECT title
FROM videos
WHERE channel_id IN (SELECT channel_id
                     FROM channels
                     WHERE user_id = 1 -- Подставьте нужный ID пользователя
);

-- 5. Выбор видео с определенным количеством просмотров (подзапрос с =)
SELECT title, views_count
FROM videos
WHERE views_count = (SELECT MAX(views_count)
                     FROM videos);

-- 6. Выбор всех комментариев, где количество лайков больше 10 (с HAVING)
SELECT video_id, COUNT(*) AS comment_count
FROM comments
GROUP BY video_id
HAVING COUNT(*) > 10;

-- 7. Выбор всех видео с их длительностью, где длительность больше 10 минут (используя HAVING)
SELECT title, duration
FROM videos
GROUP BY title, duration
HAVING duration > '00:10:00'::INTERVAL;

-- 8. Выбор всех пользователей, которые подписаны на более чем 2 канала (с использованием COUNT)
SELECT user_id, COUNT(channel_id) AS number_of_subscriptions
FROM subscriptions
GROUP BY user_id
HAVING COUNT(channel_id) > 2;

-- 9. Выбор всех видео, опубликованных за последние 30 дней (с использованием BETWEEN)
SELECT title, published_at
FROM videos
WHERE published_at BETWEEN NOW() - INTERVAL '30 days' AND NOW();

-- 10. Выбор категорий с использованием CASE WHEN
SELECT channel_name,
       CASE
           WHEN subscribers_count > 1000 THEN 'Popular'
           WHEN subscribers_count BETWEEN 500 AND 1000 THEN 'Moderate'
           ELSE 'Less Popular'
           END AS popularity
FROM channels;
