-- I. Динамическое создание таблицы
CREATE OR REPLACE PROCEDURE create_dynamic_table(
    input_table_name TEXT,
    input_columns_definition TEXT
)
    LANGUAGE plpgsql AS
$$
BEGIN
    EXECUTE format('CREATE TABLE %I (%s)', input_table_name, input_columns_definition);
END;
$$;

-- II. Курсор для списка ниндзя
CREATE OR REPLACE PROCEDURE list_ninjas()
    LANGUAGE plpgsql AS
$$
DECLARE
    ninja_record RECORD;
    ninja_cursor CURSOR FOR SELECT name
                            FROM ninjas;
BEGIN
    OPEN ninja_cursor;

    LOOP
        FETCH ninja_cursor INTO ninja_record;
        EXIT WHEN NOT FOUND;
        -- Выводим имя ниндзя
        RAISE NOTICE 'Ниндзя: %', ninja_record.name;
    END LOOP;

    CLOSE ninja_cursor;
END;
$$;

-- III. Динамическое изменение столбца таблицы
CREATE OR REPLACE PROCEDURE add_column_to_table(
    input_table_name TEXT,
    input_column_name TEXT,
    input_column_definition TEXT
)
    LANGUAGE plpgsql AS
$$
BEGIN
    EXECUTE format('ALTER TABLE %I ADD COLUMN %I %s', input_table_name, input_column_name, input_column_definition);
END;
$$;

-- Пример использования:
-- CALL add_column_to_table('village', 'village_size', 'INTEGER');

-- IV. Курсор для получения всех миссий
CREATE OR REPLACE PROCEDURE list_missions()
    LANGUAGE plpgsql AS
$$
DECLARE
    mission_record RECORD;
    mission_cursor CURSOR FOR SELECT m.status, p.name
                              FROM missions m
                                       JOIN places p ON m.place_id = p.id;
BEGIN
    OPEN mission_cursor;

    LOOP
        FETCH mission_cursor INTO mission_record;
        EXIT WHEN NOT FOUND;
        -- Выводим информацию о миссии
        RAISE NOTICE 'Статус: %, Место: %', mission_record.status, mission_record.name;
    END LOOP;

    CLOSE mission_cursor;
END;
$$;

-- V. Динамическое добавление данных в таблицу
CREATE OR REPLACE PROCEDURE insert_dynamic_data(
    input_table_name TEXT,
    input_columns TEXT,
    input_values TEXT
)
    LANGUAGE plpgsql AS
$$
BEGIN
    EXECUTE format('INSERT INTO %I (%s) VALUES (%s)', input_table_name, input_columns, input_values);
END;
$$;

-- VI. Курсор для вывода всех дуэлей
CREATE OR REPLACE PROCEDURE list_duels()
    LANGUAGE plpgsql AS
$$
DECLARE
    duel_record RECORD;
    duel_cursor CURSOR FOR SELECT n1.name AS opponent1, n2.name AS opponent2, d.result
                           FROM duels d
                                    JOIN ninjas n1 ON d.opponent1_id = n1.id
                                    JOIN ninjas n2 ON d.opponent2_id = n2.id;
BEGIN
    OPEN duel_cursor;

    LOOP
        FETCH duel_cursor INTO duel_record;
        EXIT WHEN NOT FOUND;
        -- Выводим информацию о дуэли
        RAISE NOTICE 'Оппонент 1: %, Оппонент 2: %, Результат: %', duel_record.opponent1, duel_record.opponent2, duel_record.result;
    END LOOP;

    CLOSE duel_cursor;
END;
$$;
