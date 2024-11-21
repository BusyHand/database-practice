DROP INDEX IF EXISTS idx_username;
DROP INDEX IF EXISTS idx_email;
DROP INDEX IF EXISTS idx_channel_name;
DROP INDEX IF EXISTS idx_video_title;
DROP INDEX IF EXISTS idx_video_published;
DROP INDEX IF EXISTS idx_comments_video;
DROP INDEX IF EXISTS idx_comments_user;
DROP INDEX IF EXISTS idx_subscriptions_user;
DROP INDEX IF EXISTS idx_subscriptions_channel;

CREATE INDEX idx_username ON users (username);
CREATE INDEX idx_email ON users (email);
CREATE INDEX idx_channel_name ON channels (channel_name);
CREATE INDEX idx_video_title ON videos (title);
CREATE INDEX idx_video_published ON videos (published_at);
CREATE INDEX idx_comments_video ON comments (video_id);
CREATE INDEX idx_comments_user ON comments (user_id);
CREATE INDEX idx_subscriptions_user ON subscriptions (user_id);
CREATE INDEX idx_subscriptions_channel ON subscriptions (channel_id);