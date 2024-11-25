-- I
SELECT check_password_security('Password123!');
SELECT check_password_security('password123');
SELECT check_password_security('Password');
SELECT check_password_security('123456');
SELECT check_password_security('Pass12');

-- II
SELECT check_email_format('example@domain.com');
SELECT check_email_format('invalid-email@domain');


-- III
SELECT check_user_age('2005-11-25');
SELECT check_user_age('1990-06-15');
