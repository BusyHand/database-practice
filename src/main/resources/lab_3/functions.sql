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



--II. Проверка возраста пользователя
CREATE OR REPLACE FUNCTION check_user_age(birth_date DATE, min_age INT DEFAULT 18)
    RETURNS TEXT AS
$$
DECLARE
    age INT;
BEGIN
    age := DATE_PART('year', AGE(CURRENT_DATE, birth_date));
    IF age >= min_age THEN
        RETURN 'Возраст подходит.';
    ELSE
        RETURN 'Пользователь слишком молод.';
    END IF;
END;
$$ LANGUAGE plpgsql;



--III. Проверка формата электронной почты
CREATE OR REPLACE FUNCTION check_email_format(email TEXT)
    RETURNS TEXT AS
$$
BEGIN
    IF email ~ '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$' THEN
        RETURN 'Электронная почта корректна.';
    ELSE
        RETURN 'Электронная почта некорректна.';
    END IF;
END;
$$ LANGUAGE plpgsql;
