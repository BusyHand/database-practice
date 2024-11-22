-- 1. Обновить роль пользователя
UPDATE users
SET role = 'admin'
WHERE username = 'john_doe';

-- 2. Увеличить количество подписчиков на канале
UPDATE channels
SET subscribers_count = subscribers_count + 1
WHERE channel_name = 'Tech Tutorials';

-- 3. Обновить описание видео
UPDATE videos
SET description = 'Обновленное пособие по Python для начинающих.'
WHERE title = 'Intro to Python';

-- 4. Изменить количество лайков на видео
UPDATE videos
SET likes_count = likes_count + 10
WHERE video_id = 1;

-- 5. Обновить количество просмотров на канале
UPDATE channels
SET total_views = total_views + 100
WHERE channel_id = 1;
