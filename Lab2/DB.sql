-- delete tables
DROP TABLE IF EXISTS "revisions_table";
DROP TABLE IF EXISTS "article";
DROP TABLE IF EXISTS "users";
DROP TABLE IF EXISTS "source";

DROP TYPE IF EXISTS CategoryEnum;
DROP TYPE IF EXISTS LanguageEnum;
-- table creation
CREATE TYPE CategoryEnum AS ENUM(
    'Science',
    'Politics',
    'Technology'
);
CREATE TYPE LanguageEnum AS ENUM(
    'Ukrainian',
    'English',
    'Chinese'
);
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    name varchar(100) UNIQUE NOT NULL
);
CREATE TABLE source (
    url varchar(1000) PRIMARY KEY
);
CREATE TABLE article (
    topic varchar(100) PRIMARY KEY,
    categories CategoryEnum[] NOT NULL,
    language LanguageEnum NOT NULL,
    sources varchar(1000) REFERENCES source(url),

    UNIQUE (topic, language)
);
CREATE TABLE revisions_table (
    revision_topic varchar(100),
    revision_language LanguageEnum,
    revision_date DATE NOT NULL,
    user_id INT REFERENCES users(id),
    content TEXT NOT NULL,

    PRIMARY KEY (revision_topic, revision_language, revision_date, user_id),

    FOREIGN KEY (revision_topic, revision_language) 
    REFERENCES article(topic, language)
);

-- inserts
INSERT INTO source(url)
VALUES
('http://ancienthistory.about.com/od/presocraticphiloso/p/Atomism.htm'),
('https://www.techradar.com/news/best-phone'),
('https://en.wikipedia.org/wiki/Politics#CITEREFHawkesworthKogan2013');

INSERT INTO users(id, name)
VALUES 
(1, 'asdf'),
(2, 'QWER'),
(3, 'TYUI');

INSERT INTO article(topic, categories, language)
VALUES 
('Physics', ARRAY['Science']::CategoryEnum[], 'Ukrainian'),
('Smart Phone', ARRAY['Technology']::CategoryEnum[], 'English'),
('Politics', ARRAY['Politics']::CategoryEnum[], 'Ukrainian');

INSERT INTO revisions_table(revision_topic, revision_language, revision_date, user_id, content)
VALUES 
('Physics', 'Ukrainian', '2012-11-03', 1, 'sdasdasdasd, asXCsdaX.'),
('Smart Phone', 'English', '2022-11-03', 2, 'DFCXVASD. SDvxcqacf'),
('Politics', 'Ukrainian', '2015-11-03', 3, 'Ye. SDfxcvsaa.r');