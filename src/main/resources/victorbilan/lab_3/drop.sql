-- Дроп всех функций и процедур

-- Дроп функции add_jutsu_to_ninja
DROP FUNCTION IF EXISTS add_jutsu_to_ninja(INT, INT[]);

-- Дроп функции check_ninja_clan
DROP FUNCTION IF EXISTS check_ninja_clan(INT);

-- Дроп процедуры create_dynamic_table
DROP PROCEDURE IF EXISTS create_dynamic_table(TEXT, TEXT);

-- Дроп процедуры list_ninjas
DROP PROCEDURE IF EXISTS list_ninjas();

-- Дроп процедуры add_column_to_table
DROP PROCEDURE IF EXISTS add_column_to_table(TEXT, TEXT, TEXT);

-- Дроп процедуры list_missions
DROP PROCEDURE IF EXISTS list_missions();

-- Дроп процедуры insert_dynamic_data
DROP PROCEDURE IF EXISTS insert_dynamic_data(TEXT, TEXT, TEXT);

-- Дроп процедуры list_duels
DROP PROCEDURE IF EXISTS list_duels();
