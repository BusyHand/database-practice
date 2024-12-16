--I. Проверка безопасности пароля
CREATE OR REPLACE FUNCTION check_password_security(password TEXT)
    RETURNS TEXT AS
$$
DECLARE
    has_uppercase BOOLEAN;
    has_lowercase BOOLEAN;
    has_digit     BOOLEAN;
    has_special   BOOLEAN;
    result        TEXT := 'Проблемы с паролем: ';
BEGIN

    IF LENGTH(password) < 8 THEN
        result := result || 'слишком короткий (минимум 8 символов); ';
    END IF;

    has_uppercase := password ~ '[A-Z]';
    IF NOT has_uppercase THEN
        result := result || 'нет заглавных букв; ';
    END IF;

    has_lowercase := password ~ '[a-z]';
    IF NOT has_lowercase THEN
        result := result || 'нет строчных букв; ';
    END IF;

    has_digit := password ~ '[0-9]';
    IF NOT has_digit THEN
        result := result || 'нет цифр; ';
    END IF;

    has_special := password ~ '[!@#$%^&*(),.?":{}|<>]';
    IF NOT has_special THEN
        result := result || 'нет специальных символов; ';
    END IF;

    IF result = 'Проблемы с паролем: ' THEN
        RETURN 'Пароль безопасен.';
    END IF;

    RETURN TRIM(TRAILING '; ' FROM result);
END;
$$ LANGUAGE plpgsql;

--II. добавиться все теги к одному видео
CREATE OR REPLACE FUNCTION add_tags_to_video(
    input_video_id INT,
    input_tags TEXT[]
)
    RETURNS BOOLEAN AS
$$
DECLARE
    tag TEXT;
BEGIN
    FOREACH tag IN ARRAY input_tags
        LOOP
            INSERT INTO tags (name, video_id)
            VALUES (tag, input_video_id);
        END LOOP;
    return true;
END;
$$ LANGUAGE plpgsql;