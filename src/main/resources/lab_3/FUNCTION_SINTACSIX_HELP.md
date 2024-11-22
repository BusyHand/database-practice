Давайте разберем синтаксис **PL/pgSQL** (процедурный язык PostgreSQL) на примере первой функции **`generate_user_notifications`**. Эта функция создает уведомления для пользователей на основе их последней активности.

---

### 1. **Объявление функции**

```sql
CREATE OR REPLACE FUNCTION generate_user_notifications()
    RETURNS TABLE
            (
                user_id           INT,
                notification_text TEXT
            )
```

- **`CREATE OR REPLACE FUNCTION`**: Создает функцию или заменяет ее, если она уже существует.
- **`RETURNS TABLE`**: Указывает, что функция возвращает таблицу с колонками `user_id` (тип INT) и `notification_text` (тип TEXT).

---

### 2. **Блок кода функции**

```sql
AS
$$
DECLARE
    last_action RECORD;
BEGIN
    ...
END;
$$ LANGUAGE plpgsql;
```

- **`AS $$ ... $$`**: Начало и конец тела функции.
- **`DECLARE`**: Блок для объявления переменных. Здесь `last_action` используется для хранения строк из цикла.
- **`BEGIN ... END;`**: Основной блок выполнения функции.
- **`LANGUAGE plpgsql`**: Указывает, что используется процедурный язык PL/pgSQL.

---

### 3. **Цикл для формирования уведомлений**

```sql
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
```

- **`FOR ... IN`**: Цикл, который перебирает результат SQL-запроса построчно.
- **`SELECT ... CASE`**: Основной запрос:
    - **`CASE`**: Логика выбора текста уведомления:
        - Если максимальная активность — просмотр видео, возвращается текст с названием видео.
        - Если комментарий — возвращается текст с содержанием комментария.
        - Если лайк — фиксированный текст.
        - Если активности нет — возвращается "No recent activity".
    - **`MAX(vh.created_at)`**: Используется для определения самой поздней активности.
    - **`LEFT JOIN`**: Присоединяет данные о просмотрах, комментариях и лайках.
    - **`GROUP BY u.id`**: Группировка по пользователю, чтобы выбрать последнюю активность.
- **`RETURN NEXT`**: Добавляет строку к результату функции.

---

### Ключевые особенности

1. **Динамическая логика в SQL:** Использование `CASE` внутри SQL для определения типа активности.
2. **Работа с несколькими таблицами:** `LEFT JOIN` объединяет данные пользователей, просмотров, комментариев и лайков.
3. **Процедурный стиль:** Логика не могла быть реализована в оконных функциях, так как здесь генерируется текст на основе сложной комбинации данных.

---

### Аналогичная структура в других функциях

#### 2. `assign_ad_to_popular_video`

- **`DECLARE`**: Переменная `target_video_id` используется для хранения подходящего видео.
- **`IF target_video_id IS NULL THEN ... END IF;`**: Проверяет, найдено ли подходящее видео.
- **`RAISE EXCEPTION`**: Генерирует ошибку, если видео не найдено.
- **`UPDATE`**: Назначает рекламу выбранному видео.

#### 3. `update_channel_statistics`

- **`SELECT INTO`**: Используется для сохранения результата запроса в переменные `total_views` и `subscriber_count`.
- **`COALESCE`**: Подставляет значение `0`, если данных нет.

#### 4. `get_top_active_user_by_month`

- **`WHILE`**: Итерация по каждому месяцу за последний год.
- **`RETURN QUERY`**: Добавляет строку к возвращаемому результату в каждой итерации.

Если есть вопросы по отдельным частям синтаксиса, дайте знать!