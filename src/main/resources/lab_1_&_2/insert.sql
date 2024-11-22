-- Users Table
INSERT INTO users (username, email, password, role)
VALUES ('john_doe', 'john@example.com', 'hashed_password_1', 'user'),
       ('jane_smith', 'jane@example.com', 'hashed_password_2', 'admin'),
       ('mike_jones', 'mike@example.com', 'hashed_password_3', 'user'),
       ('linda_brown', 'linda@example.com', 'hashed_password_4', 'user');

-- Channels Table
INSERT INTO channels (user_id, channel_name, description)
VALUES (1, 'Tech Tutorials', 'Узнайте новейшие технологии'),
       (2, 'Foodie Corner', 'Исследуйте вкусные рецепты'),
       (3, 'Travel Vlogs', 'Приключения по всему миру'),
       (4, 'Gaming Arena', 'Давайте играть и делать обзоры игр');

-- Videos Table
INSERT INTO videos (channel_id, title, description, duration, views_count, likes_count, dislikes_count)
VALUES (1, 'Intro to Python', 'Учебное пособие для начинающих по Python.', '1970-01-01 00:10:00', 1000, 100, 5),
       (2, 'Pasta Carbonara', 'Классическое итальянское блюдо!', '1970-01-01 00:05:30', 800, 150, 2),
       (3, 'Visit Paris', 'Исследуя достопримечательности Парижа.', '1970-01-01 00:15:00', 2000, 200, 10),
       (4, 'Top 10 Video Games', 'Обзор лучших игр этого года.', '1970-01-01 00:20:00', 500, 75, 1);

-- Comments Table
INSERT INTO comments (video_id, user_id, content)
VALUES (1, 2, 'Отличный учебник! Очень полезно.'),
       (1, 3, 'С нетерпением жду нового контента.'),
       (2, 1, 'Этот рецепт замечательный, спасибо!'),
       (4, 4, 'Совершенно согласен с вашим мнением!');

-- Video Likes Table
INSERT INTO video_likes (user_id, video_id, is_like)
VALUES (1, 1, TRUE),
       (2, 4, TRUE),
       (3, 3, TRUE),
       (4, 2, FALSE);

-- Subscriptions Table
INSERT INTO subscriptions (user_id, channel_id)
VALUES (1, 1),
       (2, 2),
       (3, 3),
       (4, 4);

-- Playlists Table
INSERT INTO playlists (user_id, playlist_name)
VALUES (1, 'Кодирование 101'),
       (2, 'Итальянские блюда'),
       (3, 'Обязательные места для путешествий'),
       (4, 'Лучшие обзоры игр');

-- Playlist Videos Table
INSERT INTO playlist_videos (playlist_id, video_id)
VALUES (1, 1),
       (2, 2),
       (3, 3),
       (4, 4);

-- Categories Table
INSERT INTO categories (name, description)
VALUES ('Образование', 'Образовательный контент'),
       ('Кулинария', 'Кулинарные уроки и рецепты'),
       ('Путешествия', 'Путеводители и влоги о путешествиях'),
       ('Игры', 'Игровые видео и обзоры');

-- Video Categories Table
INSERT INTO video_categories (video_id, category_id)
VALUES (1, 1),
       (2, 2),
       (3, 3),
       (4, 4);

-- Notifications Table
INSERT INTO notifications (user_id, type, content)
VALUES (1, 'subscription', 'У вас новый подписчик!'),
       (2, 'comment', 'Кто-то прокомментировал ваше видео.'),
       (3, 'like', 'Ваше видео только что понравилось!'),
       (4, 'message', 'Вы получили новое сообщение.');

-- Reports Table
INSERT INTO reports (user_id, video_id, reason)
VALUES (1, 4, 'Неприемлемый контент'),
       (2, 1, 'Спам'),
       (3, 3, 'Мошеннический заголовок'),
       (4, 2, 'Нарушение правил сообщества');

-- Ads Table
INSERT INTO ads (title, content, duration, target_audience, video_id)
VALUES ('Learn to Code', 'Присоединяйтесь к нашему курсу программирования.', INTERVAL '60 seconds', 'Студенты', 1),
       ('Cook Like a Pro', 'Подпишитесь на эксклюзивные рецепты.', INTERVAL '30 seconds', 'Любители еды', 2),
       ('Travel More', 'Посмотрите наш сайт путеводителей.', INTERVAL '45 seconds', 'Авантюристы', 3),
       ('Game On!', 'Присоединяйтесь к нашему игровому сообществу сегодня!', INTERVAL '90 seconds', 'Геймеры', 4);

-- User History Table
INSERT INTO user_history (video_id, user_id, watch_time)
VALUES (1, 1, 600),
       (2, 2, 300),
       (3, 3, 900),
       (4, 4, 1200);

-- Tags Table
INSERT INTO tags (name, video_id)
VALUES ('Python', 1),
       ('Паста', 2),
       ('Париж', 3),
       ('Игры', 4);
