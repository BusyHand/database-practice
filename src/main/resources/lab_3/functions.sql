-- 1. Генерация персонализированных уведомлений для пользователей
-- Функция создает текст уведомлений для пользователей, основанных на их последней активности
-- (последний просмотренный видео, комментарий или лайк).

--Почему сложно адаптировать:
-- Здесь мы комбинируем множество источников данных,
-- определяем последний вид активности и создаем текстовое сообщение.
-- Оконные функции затрудняются с динамической генерацией текста.
CREATE OR REPLACE FUNCTION generate_user_notifications()
    RETURNS TABLE
            (
                user_id           INT,
                notification_text TEXT
            )
AS
$$
DECLARE
    last_action RECORD;
BEGIN
    FOR last_action IN
        SELECT u.id    AS user_id,
               CASE
                   WHEN MAX(vh.created_at) > MAX(c.created_at) AND MAX(vh.created_at) > MAX(vl.created_at) THEN
                       CONCAT('You recently watched the video: ', v.title)
                   WHEN MAX(c.created_at) > MAX(vh.created_at) AND MAX(c.created_at) > MAX(vl.created_at) THEN
                       CONCAT('You recently commented: "', c.content, '"')
                   WHEN MAX(vl.created_at) > MAX(vh.created_at) AND MAX(vl.created_at) > MAX(c.created_at) THEN
                       'You recently liked a video'
                   ELSE
                       'No recent activity'
                   END AS notification_text
        FROM users u
                 LEFT JOIN
             user_history vh ON u.id = vh.user_id
                 LEFT JOIN
             comments c ON u.id = c.user_id
                 LEFT JOIN
             video_likes vl ON u.id = vl.user_id
        GROUP BY u.id
        LOOP
            RETURN NEXT last_action;
        END LOOP;
END;
$$ LANGUAGE plpgsql;

-- 2. Автоматическое распределение рекламы на основе популярных категорий
-- Функция назначает видео с популярной категорией для новой рекламы, при этом проверяет,
-- чтобы видео не имело активных рекламных записей.

-- Почему сложно адаптировать:
-- Процедура проверяет существование записей,
-- назначает видео и обрабатывает исключения — это не укладывается в возможности оконных функций.
CREATE OR REPLACE FUNCTION assign_ad_to_popular_video(ad_id INT)
    RETURNS VOID AS
$$
DECLARE
    target_video_id INT;
BEGIN
    SELECT v.video_id
    INTO
        target_video_id
    FROM videos v
             JOIN
         video_categories vc ON v.video_id = vc.video_id
             JOIN
         categories c ON vc.category_id = c.category_id
    WHERE NOT EXISTS(
            SELECT 1
            FROM ads a
            WHERE a.video_id = v.video_id
        )
    ORDER BY v.views_count DESC
    LIMIT 1;

    IF target_video_id IS NULL THEN
        RAISE EXCEPTION 'No suitable video found for ad assignment';
    END IF;

    UPDATE ads
    SET video_id = target_video_id
    WHERE ad_id = ad_id;
END;
$$ LANGUAGE plpgsql;

-- 3. Обновление статистики каналов на основе активности
-- Функция пересчитывает общие просмотры и количество подписчиков для канала, обновляя его записи.

--Почему сложно адаптировать:
-- Здесь используется процедурный подход с двумя разными запросами,
-- результатами которых обновляется таблица.
CREATE OR REPLACE FUNCTION update_channel_statistics(channelId INT)
    RETURNS VOID AS
$$
DECLARE
    total_views      BIGINT;
    subscriber_count INT;
BEGIN
    SELECT SUM(v.views_count)
    INTO
        total_views
    FROM videos v
    WHERE v.channel_id = channelId;

    SELECT COUNT(*)
    INTO
        subscriber_count
    FROM subscriptions s
    WHERE s.channel_id = channelId;

    UPDATE channels
    SET total_views       = COALESCE(total_views, 0),
        subscribers_count = COALESCE(subscriber_count, 0)
    WHERE channel_id = channelId;
END;
$$ LANGUAGE plpgsql;

-- 4. Определение пользователя с максимальной активностью по месяцам
-- Функция возвращает ID пользователя и количество его действий за каждый месяц.

-- Почему сложно адаптировать: Здесь используется цикл для работы с временными периодами,
-- а также динамическое добавление записей в результат.
CREATE OR REPLACE FUNCTION get_top_active_user_by_month()
    RETURNS TABLE
            (
                activity_month DATE,
                user_id        INT,
                action_count   INT
            )
AS
$$
DECLARE
    current_month DATE;
    max_user      RECORD;
BEGIN
    current_month := DATE_TRUNC('month', CURRENT_DATE);

    WHILE current_month >= (CURRENT_DATE - INTERVAL '1 year')
        LOOP
            SELECT uh.user_id,
                   COUNT(*) AS action_count
            INTO
                max_user
            FROM user_history uh
            WHERE DATE_TRUNC('month', uh.created_at) = current_month
            GROUP BY uh.user_id
            ORDER BY action_count DESC
            LIMIT 1;

            RETURN QUERY SELECT current_month, max_user.user_id, max_user.action_count;

            current_month := current_month - INTERVAL '1 month';
        END LOOP;
END;
$$ LANGUAGE plpgsql;
