-- 1. Обновить ранг Наруто Узумаки на 'Джонин'
UPDATE ninjas
SET rank = 'Jonin'
WHERE name = 'Naruto Uzumaki';

-- 2. Увеличить количество ниндзя в деревне Скрытого Листа на 1
UPDATE village
SET ninja_count = ninja_count + 1
WHERE name = 'Hidden Leaf';

-- 3. Обновить описание арки Экзаменов Чунинов
UPDATE arch
SET description = 'Updated Chunin Exams arc with more details.'
WHERE description = 'Chunin Exams';

-- 4. Увеличить количество участников в Команде 7 на 1
UPDATE teams
SET participants_count = participants_count + 1
WHERE name = 'Team 7';

-- 5. Увеличить мощность Куремы на 100
-- Может не сработать если до вызова была изменена в alter_table.sql

UPDATE tailed_beast
SET power = power + 100
WHERE bigio = 'Kurama';

-- 6. Увеличить количество свитков Луны на 1
UPDATE artifact
SET count = count + 1
WHERE name = 'Moon Scroll';
