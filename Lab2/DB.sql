-- delete tables
DROP TABLE IF EXISTS "article";
DROP TABLE IF EXISTS "user";
DROP TABLE IF EXISTS "source";
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
CREATE TYPE Revision AS (
    date DATE,
    user_name varchar(100),
    content TEXT
);
# ТИПИ не можуть мати атрибутів з умовами по типу "NOT NULL", але
# це можна обійти за допомогою створення "DOMAIN"
CREATE DOMAIN RevisionDomain AS Revision CHECK (
    (VALUE).date IS NOT NULL
    AND
    (VALUE).user_name IS NOT NULL
    AND
    (VALUE).content IS NOT NULL
);

CREATE TABLE article (
    topic varchar(100) PRIMARY KEY,
    categories CategoryEnum[] NOT NULL,
    language LanguageEnum NOT NULL,
    sources varchar(1000) REFERENCES source(url)
);
CREATE TABLE article_revision (
    
);

CREATE TABLE "user" (
    id SERIAL PRIMARY KEY,
    name varchar(100) UNIQUE NOT NULL
);

CREATE TABLE source (
    name varchar(100) NOT NULL,
    url varchar(1000) PRIMARY KEY
);

-- inserts
INSERT INTO article(topic, categories, language, )