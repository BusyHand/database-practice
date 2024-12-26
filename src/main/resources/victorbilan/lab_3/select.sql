-- Примеры с функциями

-- 2. Пример использования функции для добавления джутсу к ниндзя
SELECT add_jutsu_to_ninja(1, ARRAY [6,7,8]);

-- 3. Пример использования функции для проверки клана ниндзя
SELECT check_ninja_clan(1);

-- Примеры с процедурами
CALL create_dynamic_table('dynamic_village', 'name VARCHAR(255), country VARCHAR(255)');

CALL list_ninjas();

CALL list_missions();

CALL list_duels();