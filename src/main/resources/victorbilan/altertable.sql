-- Добавление нового столбца для хранения уровня опыта ниндзя
ALTER TABLE ninjas
    ADD COLUMN experience_level INTEGER;

-- Удаление столбца описания цели организации
ALTER TABLE organisations
    DROP COLUMN goal;

-- Изменение типа данных столбца описания арок на TEXT
ALTER TABLE arch
    ALTER COLUMN description TYPE TEXT;

-- Переименование столбца количества жителей деревни в population
ALTER TABLE village
    RENAME COLUMN residents_count TO population;

-- Добавление уникального ограничения на имя клана
ALTER TABLE clans
    ADD CONSTRAINT unique_clan_name UNIQUE (name);

-- Установка ограничения NOT NULL на столбец ранга ниндзя
ALTER TABLE ninjas
    ALTER COLUMN rank SET NOT NULL;

-- Добавление внешнего ключа для связи между командами и ниндзя (лидер)
ALTER TABLE teams
    ADD CONSTRAINT fk_leader FOREIGN KEY (leader_id) REFERENCES ninjas (id);

-- Изменение типа данных столбца длительности дуэли на INTERVAL
ALTER TABLE duels
    ALTER COLUMN duration_hours TYPE INTERVAL USING duration_hours * INTERVAL '1 hour';

-- Переименование таблицы tailed_beast в bijuu
ALTER TABLE tailed_beast
    RENAME TO bijuu;

-- Удаление значения по умолчанию для количества участников команды
ALTER TABLE teams
    ALTER COLUMN participants_count DROP DEFAULT;

-- Добавление столбца активности миссии с значением по умолчанию TRUE
ALTER TABLE missions
    ADD COLUMN is_active BOOLEAN DEFAULT TRUE;
