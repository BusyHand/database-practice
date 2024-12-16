Давайте разберем синтаксис **PL/pgSQL** (процедурный язык PostgreSQL) на примере трех функций: **`check_password_security`**, **`check_user_age`** и **`check_email_format`**.

---

## I. Проверка безопасности пароля

```sql
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
    has_uppercase := password ~ '[A-Z]';
    has_lowercase := password ~ '[a-z]';
    has_digit := password ~ '[0-9]';
    has_special := password ~ '[!@#$%^&*(),.?":{}|<>]';
    -- проверки пароля...
    RETURN TRIM(TRAILING '; ' FROM result);
END;
$$ LANGUAGE plpgsql;
```

### 1. **Объявление функции**

```sql
CREATE OR REPLACE FUNCTION check_password_security(password TEXT)
    RETURNS TEXT AS
$$
```

- **`CREATE OR REPLACE FUNCTION`**: Создает новую функцию или заменяет существующую с тем же именем.
- **`RETURNS TEXT`**: Указывает, что функция возвращает результат типа `TEXT` — строку с описанием проблем с паролем.
- **`password TEXT`**: Параметр функции, который принимает строку (пароль), тип данных — `TEXT`.

---

### 2. **Блок объявления переменных**

```sql
DECLARE
    has_uppercase BOOLEAN;
    has_lowercase BOOLEAN;
    has_digit     BOOLEAN;
    has_special   BOOLEAN;
    result        TEXT := 'Проблемы с паролем: ';
```

- **`DECLARE`**: Блок для объявления локальных переменных, которые будут использоваться в теле функции.
    - **`has_uppercase`**: Переменная типа `BOOLEAN`, проверяет наличие заглавных букв в пароле.
    - **`has_lowercase`**: Переменная типа `BOOLEAN`, проверяет наличие строчных букв в пароле.
    - **`has_digit`**: Переменная типа `BOOLEAN`, проверяет наличие цифр в пароле.
    - **`has_special`**: Переменная типа `BOOLEAN`, проверяет наличие специальных символов.
    - **`result`**: Переменная типа `TEXT`, которая хранит строку с проблемами пароля.

---

### 3. **Основной блок**

```sql
BEGIN
    has_uppercase := password ~ '[A-Z]';
    has_lowercase := password ~ '[a-z]';
    has_digit := password ~ '[0-9]';
    has_special := password ~ '[!@#$%^&*(),.?":{}|<>]';
    -- дополнительные проверки
    RETURN TRIM(TRAILING '; ' FROM result);
END;
```

- **`BEGIN ... END;`**: Начало и конец основного блока выполнения функции.
- **`password ~ '[A-Z]'`**: Регулярное выражение для проверки наличия хотя бы одной заглавной буквы в пароле.
- **`RETURN TRIM(TRAILING '; ' FROM result);`**: Возвращает строку с проблемами пароля, удаляя лишние символы в конце строки.

---

## II. Проверка возраста пользователя

```sql
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
```

### 1. **Объявление функции**

```sql
CREATE OR REPLACE FUNCTION check_user_age(birth_date DATE, min_age INT DEFAULT 18)
    RETURNS TEXT AS
$$
```

- **`CREATE OR REPLACE FUNCTION`**: Создает новую функцию или заменяет существующую с тем же именем.
- **`RETURNS TEXT`**: Функция возвращает строку (тип данных `TEXT`).
- **`birth_date DATE`**: Параметр типа `DATE`, который указывает дату рождения пользователя.
- **`min_age INT DEFAULT 18`**: Параметр типа `INT` с значением по умолчанию 18 — минимальный возраст пользователя.

---

### 2. **Блок объявления переменных**

```sql
DECLARE
    age INT;
```

- **`DECLARE`**: Объявление локальной переменной `age` типа `INT`, которая будет использоваться для вычисления возраста.

---

### 3. **Основной блок**

```sql
BEGIN
    age := DATE_PART('year', AGE(CURRENT_DATE, birth_date));
    IF age >= min_age THEN
        RETURN 'Возраст подходит.';
    ELSE
        RETURN 'Пользователь слишком молод.';
    END IF;
END;
```

- **`AGE(CURRENT_DATE, birth_date)`**: Функция `AGE` вычисляет разницу между текущей датой и датой рождения пользователя.
- **`DATE_PART('year', ...)`**: Извлекает количество полных лет из вычисленной разницы.
- **`IF ... ELSE`**: Условная логика для проверки, соответствует ли возраст минимальному значению.

---

## III. Проверка формата электронной почты

```sql
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
```

### 1. **Объявление функции**

```sql
CREATE OR REPLACE FUNCTION check_email_format(email TEXT)
    RETURNS TEXT AS
$$
```

- **`CREATE OR REPLACE FUNCTION`**: Создает или заменяет функцию.
- **`RETURNS TEXT`**: Указывает, что функция возвращает строку (тип данных `TEXT`).
- **`email TEXT`**: Параметр функции типа `TEXT`, который принимает адрес электронной почты.

---

### 2. **Основной блок**

```sql
BEGIN
    IF email ~ '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$' THEN
        RETURN 'Электронная почта корректна.';
    ELSE
        RETURN 'Электронная почта некорректна.';
    END IF;
END;
```

- **`email ~ '...'`**: Оператор `~` используется для проверки строки с помощью регулярного выражения. В данном случае проверяется, соответствует ли адрес электронной почты стандартному формату.
- **`IF ... ELSE`**: Условие, проверяющее, прошел ли адрес почты проверку на соответствие регулярному выражению.
- **`RETURN`**: Возвращает строку с результатом проверки.

---

### Ключевые особенности синтаксиса:

1. **`CREATE OR REPLACE FUNCTION`**: Создание или замена функции в базе данных.
2. **`RETURNS`**: Указывает тип данных, который функция будет возвращать.
3. **`DECLARE`**: Блок для объявления локальных переменных, которые будут использоваться в теле функции.
4. **`BEGIN ... END;`**: Основной блок выполнения, где размещается логика функции.
5. **`IF ... ELSE`**: Условные операторы для принятия решений в зависимости от проверок.
6. **Регулярные выражения**: Используются для проверки строк, таких как пароли или адреса электронной почты.

--- 

Если нужно объяснение по какой-либо части синтаксиса, не стесняйтесь спрашивать!

Курсоры и записи (records) в PostgreSQL — это важные концепции, которые помогают управлять выборками данных и позволяют работать с ними более эффективно в PL/pgSQL.

### 1. Курсор

**Курсор** - это объект базы данных, который позволяет вам выполнять выборку строк из результата SQL-запроса и последовательно перебирать их. Курсоры особенно полезны, когда вам нужно обрабатывать строки по одной или выполнять сложные операции с каждой строкой.

#### Пример использования курсора

```sql
CREATE OR REPLACE PROCEDURE list_users()
LANGUAGE plpgsql AS
$$
DECLARE
    user_record RECORD;
    user_cursor CURSOR FOR SELECT username FROM users;
BEGIN
    OPEN user_cursor;  -- Открываем курсор

    LOOP
        FETCH user_cursor INTO user_record;  -- Извлекаем строку в переменную
        EXIT WHEN NOT FOUND;  -- Выход из цикла, если больше нет строк
        RAISE NOTICE 'User: %', user_record.username;  -- Выводим имя пользователя
    END LOOP;

    CLOSE user_cursor;  -- Закрываем курсор
END;
$$;
```

### 2. Запись (RECORD)

**Запись** в контексте PL/pgSQL — это переменная, которая может хранить строки с произвольной структурой. Она часто используется для извлечения данных из курсоров. Запись может содержать все столбцы из результата запроса.

#### Пример объявления и использования записи

```sql
DECLARE
    user_record RECORD;  -- Объявляем переменную типа RECORD
BEGIN
    SELECT * INTO user_record FROM users WHERE id = 1;  -- Извлекаем строку в запись
    RAISE NOTICE 'User: %', user_record.username;  -- Используем запись
END;
```

### 3. Пример выборки с использованием SELECT

Чтобы лучше понять, как работают курсоры и записи, вот несколько простых примеров SELECT:

#### Пример 1: Простая выборка

```sql
SELECT username FROM users;
```

Этот запрос выбирает все имена пользователей из таблицы `users`.

#### Пример 2: Выборка с условием

```sql
SELECT * FROM users WHERE id = 1;
```

Этот запрос выбирает все данные о пользователе с конкретным ID.

#### Пример 3: Использование нескольких столбцов

```sql
SELECT username, email FROM users;
```

Этот запрос выбирает имена пользователей и их электронные почты из таблицы `users`.

### 4. Полный пример с курсором и записью

Вот пример, в котором создается хранимая процедура для вывода всех пользователей с использованием курсора и записи:

```sql
CREATE OR REPLACE PROCEDURE list_users()
LANGUAGE plpgsql AS
$$
DECLARE
    user_record RECORD;  -- Описание структуры записи
    user_cursor CURSOR FOR SELECT username, email FROM users;  -- Курсор на выборку пользователей
BEGIN
    OPEN user_cursor;  -- Открываем курсор

    LOOP
        FETCH user_cursor INTO user_record;  -- Помещаем данные в запись
        EXIT WHEN NOT FOUND;  -- Выход из цикла, если данных больше нет

        -- Извлекаем значения из записи
        RAISE NOTICE 'Username: %, Email: %', user_record.username, user_record.email;
    END LOOP;

    CLOSE user_cursor;  -- Закрываем курсор
END;
$$;
```

### Заключение

- **Курсор** позволяет выполнять выборки данных итеративно и работать с ними по одной строке.
- **Запись (RECORD)** используется для хранения строк с произвольной структурой, и она удобна для работы с курсорами.
- Вы можете комбинировать эти концепции для создания более сложной логики обработки данных в базе данных PostgreSQL. 