CREATE TABLE users
(
    id         SERIAL PRIMARY KEY,
    username   VARCHAR(255) NOT NULL,
    email      VARCHAR(255) NOT NULL UNIQUE,
    password   VARCHAR(255) NOT NULL,
    role       VARCHAR(50) DEFAULT 'user',
    created_at TIMESTAMP   DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE channels
(
    channel_id        SERIAL PRIMARY KEY,
    user_id           INT          NOT NULL,
    channel_name      VARCHAR(255) NOT NULL,
    description       TEXT,
    subscribers_count INT       DEFAULT 0,
    total_views       BIGINT    DEFAULT 0,
    created_at        TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users (id)
);

CREATE TABLE videos
(
    video_id       SERIAL PRIMARY KEY,
    channel_id     INT          NOT NULL,
    title          VARCHAR(255) NOT NULL,
    description    TEXT,
    duration       TIMESTAMP    NOT NULL,
    published_at   TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    views_count    BIGINT    DEFAULT 0,
    likes_count    INT       DEFAULT 0,
    dislikes_count INT       DEFAULT 0,
    FOREIGN KEY (channel_id) REFERENCES channels (channel_id)
);

CREATE TABLE comments
(
    comment_id     SERIAL PRIMARY KEY,
    video_id       INT  NOT NULL,
    user_id        INT  NOT NULL,
    content        TEXT NOT NULL,
    likes_count    INT       DEFAULT 0,
    dislikes_count INT       DEFAULT 0,
    created_at     TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (video_id) REFERENCES videos (video_id),
    FOREIGN KEY (user_id) REFERENCES users (id)
);

CREATE TABLE video_likes
(
    like_id  SERIAL PRIMARY KEY,
    user_id  INT     NOT NULL,
    video_id INT     NOT NULL,
    is_like  BOOLEAN NOT NULL,
    created_at     TIMESTAMP   DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users (id),
    FOREIGN KEY (video_id) REFERENCES videos (video_id)
);

CREATE TABLE subscriptions
(
    subscription_id SERIAL PRIMARY KEY,
    user_id         INT NOT NULL,
    channel_id      INT NOT NULL,
    subscribed_at   TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users (id),
    FOREIGN KEY (channel_id) REFERENCES channels (channel_id)
);

CREATE TABLE playlists
(
    playlist_id    SERIAL PRIMARY KEY,
    user_id        INT          NOT NULL,
    playlist_name  VARCHAR(255) NOT NULL,
    created_at     TIMESTAMP   DEFAULT CURRENT_TIMESTAMP,
    privacy_status VARCHAR(50) DEFAULT 'public',
    FOREIGN KEY (user_id) REFERENCES users (id)
);

CREATE TABLE playlist_videos
(
    playlist_video_id SERIAL PRIMARY KEY,
    playlist_id       INT NOT NULL,
    video_id          INT NOT NULL,
    added_at          TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (playlist_id) REFERENCES playlists (playlist_id),
    FOREIGN KEY (video_id) REFERENCES videos (video_id)
);

CREATE TABLE categories
(
    category_id SERIAL PRIMARY KEY,
    name        VARCHAR(255) NOT NULL,
    description TEXT
);

CREATE TABLE video_categories
(
    video_category_id SERIAL PRIMARY KEY,
    video_id          INT NOT NULL,
    category_id       INT NOT NULL,
    FOREIGN KEY (video_id) REFERENCES videos (video_id),
    FOREIGN KEY (category_id) REFERENCES categories (category_id)
);

CREATE TABLE notifications
(
    notification_id SERIAL PRIMARY KEY,
    user_id         INT         NOT NULL,
    type            VARCHAR(50) NOT NULL,
    content         TEXT,
    created_at      TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users (id)
);

CREATE TABLE reports
(
    report_id  SERIAL PRIMARY KEY,
    user_id    INT  NOT NULL,
    video_id   INT  NOT NULL,
    reason     TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users (id),
    FOREIGN KEY (video_id) REFERENCES videos (video_id)
);

CREATE TABLE ads
(
    ad_id           SERIAL PRIMARY KEY,
    title           VARCHAR(255) NOT NULL,
    content         TEXT         NOT NULL,
    duration        INTERVAL     NOT NULL,
    target_audience TEXT,
    video_id        INT          NOT NULL,
    FOREIGN KEY (video_id) REFERENCES videos (video_id)
);

CREATE TABLE user_history
(
    video_id   INT NOT NULL,
    user_id    INT NOT NULL,
    watch_time BIGINT    DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (video_id) REFERENCES videos (video_id),
    FOREIGN KEY (user_id) REFERENCES users (id)
);

CREATE TABLE tags
(
    tag_id   SERIAL PRIMARY KEY,
    name     VARCHAR(255) NOT NULL,
    video_id INT          NOT NULL,
    FOREIGN KEY (video_id) REFERENCES videos (video_id)
);
