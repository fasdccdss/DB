-- delete tables
DROP TABLE IF EXISTS "category", "article", "revision", "user", "source";
-- table creation
CREATE TABLE category (
    name TEXT PRIMARY KEY,
);

CREATE TABLE article (
    topic TEXT PRIMARY KEY,
    language TEXT NOT NULL
);

CREATE TABLE revision (
    article TEXT REFERENCES article(topic),
    date DATE NOT NULL,
    user_id INTEGER REFERENCES user(id),
    content TEXT NOT NULL
    PRIMARY KEY (article_topic, date)
);

CREATE TABLE user (
    id SERIAL PRIMARY KEY,
    name TEXT UNIQUE NOT NULL
);

CREATE TABLE source (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    url TEXT UNIQUE NOT NULL
);