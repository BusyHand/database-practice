-- 1 Добавить все джутсу к одному ниндзя
CREATE OR REPLACE FUNCTION add_jutsu_to_ninja(
    input_ninja_id INT,
    input_jutsu_ids INT[]
)
    RETURNS BOOLEAN AS
$$
DECLARE
    jutsu_id INT;
BEGIN
    FOREACH jutsu_id IN ARRAY input_jutsu_ids
        LOOP
            -- Вставка в таблицу jutsu_list, предполагая, что джутсу принадлежат конкретным ниндзя
            INSERT INTO jutsu_list (name, type, chakra_nature, owner_id, power, chakra_consumption)
            SELECT name, type, chakra_nature, input_ninja_id, power, chakra_consumption
            FROM jutsu_list
            WHERE id = jutsu_id;
        END LOOP;
    RETURN true;
END;
$$ LANGUAGE plpgsql;


-- 2 Проверка наличия клана у ниндзя
CREATE OR REPLACE FUNCTION check_ninja_clan(ninja_id INT)
    RETURNS TEXT AS
$$
DECLARE
    clan_name TEXT;
BEGIN
    SELECT clans.name
    INTO clan_name
    FROM ninjas
             JOIN clans ON ninjas.clan_id = clans.id
    WHERE ninjas.id = ninja_id;

    IF clan_name IS NULL THEN
        RETURN 'Ниндзя не принадлежит клану.';
    ELSE
        RETURN 'Ниндзя принадлежит клану: ' || clan_name;
    END IF;
END;
$$ LANGUAGE plpgsql;
