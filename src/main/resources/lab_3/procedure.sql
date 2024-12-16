--I динамически создавать
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

--II cursor
CREATE OR REPLACE PROCEDURE list_users()
    LANGUAGE plpgsql AS
$$
DECLARE
    user_record RECORD;
    user_cursor CURSOR FOR SELECT username
                           FROM users;
BEGIN
    OPEN user_cursor;

    LOOP
        FETCH user_cursor INTO user_record;
        EXIT WHEN NOT FOUND;
    END LOOP;

    CLOSE user_cursor;
END;
$$;

