--Функции
-- I
SELECT check_password_security('Password123!');
SELECT check_password_security('password123');
SELECT check_password_security('Password');
SELECT check_password_security('123456');
SELECT check_password_security('Pass12');

-- II
SELECT add_tags_to_video(1, ARRAY['tag1', 'tag2', 'tag3']);


--Процедуры
--I

CALL create_dynamic_table(
        'test_table',
        'id SERIAL PRIMARY KEY, ' ||
        'name VARCHAR(100), ' ||
        'created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP'
    );

--II
CALL list_users();
