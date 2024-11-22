--1. Проверка функции generate_user_notifications
SELECT *
FROM generate_user_notifications();


--2. Проверка функции assign_ad_to_popular_video
-- Проверьте доступные видео
SELECT v.video_id, v.title, v.views_count
FROM videos v
         LEFT JOIN ads a ON v.video_id = a.video_id
WHERE a.video_id IS NULL
ORDER BY v.views_count DESC
LIMIT 1;

-- Назначьте рекламу с ID 5 (например, новый рекламный слот)
SELECT assign_ad_to_popular_video(5);

-- Проверьте, какое видео назначено
SELECT *
FROM ads
WHERE ad_id = 5;

--3. Проверка функции update_channel_statistics
-- Статистика до вызова функции
SELECT *
FROM channels
WHERE channel_id = 1;

-- Обновление статистики для канала
SELECT update_channel_statistics(1);

-- Проверьте обновленные данные
SELECT *
FROM channels
WHERE channel_id = 1;

--4. Проверка функции get_top_active_user_by_month
SELECT *
FROM get_top_active_user_by_month();

