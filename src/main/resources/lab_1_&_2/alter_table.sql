-- Добавление нового столбца для хранения времени последнего входа пользователя
ALTER TABLE users
    ADD COLUMN last_login TIMESTAMP;

-- Удаление столбца описания канала
ALTER TABLE channels
    DROP COLUMN description;

-- Изменение типа данных столбца заголовка видео на TEXT
ALTER TABLE videos
    ALTER COLUMN title TYPE TEXT;

-- Переименование столбца контента комментариев в comment_text
ALTER TABLE comments
    RENAME COLUMN content TO comment_text;

-- Добавление уникального ограничения на имя пользователя
ALTER TABLE users
    ADD CONSTRAINT unique_username UNIQUE (username);

-- Установка ограничение NOT NULL на столбец username
ALTER TABLE users
    ALTER COLUMN username SET NOT NULL;

-- Установка ограничение NOT NULL на столбец имени канала
ALTER TABLE channels
    ALTER COLUMN channel_name SET NOT NULL;

-- Добавление внешнего ключа для ссылки на таблицу каналов
ALTER TABLE videos
    ADD CONSTRAINT fk_channel FOREIGN KEY (channel_id) REFERENCES channels (channel_id);

-- Изменение типа данных столбца продолжительности видео на INTERVAL с использованием явного преобразования
ALTER TABLE videos
    ALTER COLUMN duration TYPE INTERVAL USING duration - '1970-01-01'::timestamp;

-- Переименование таблицы user_history в watch_history
ALTER TABLE user_history
    RENAME TO watch_history;


-- Удаление значения по умолчанию для столбца privacy_status
ALTER TABLE playlists
    ALTER COLUMN privacy_status DROP DEFAULT;

-- Добавление столбца is_active с значением по умолчанию TRUE
ALTER TABLE videos
    ADD COLUMN is_active BOOLEAN DEFAULT TRUE;
