-- delete tables
DROP TABLE IF EXISTS "revisions_table";
DROP TABLE IF EXISTS "articles_normalized", "article_categories",
"article_sources", "article_revisions";
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
CREATE TABLE sources (
    url varchar(1000) PRIMARY KEY
);
# прибрані атрибути "categories" - через порушення 1НФ 
# та "sources" через неправильну імлементацію
CREATE TABLE articles_normalized (
    topic varchar(100),
    language LanguageEnum NOT NULL,

    PRIMARY KEY (topic, language)
);
# нова таблиця сполучення статтею та категоріями
CREATE TABLE article_categories (
    topic varchar(100),
    language LanguageEnum,
    category CategoryEnum,
    PRIMARY KEY (topic, language, category),
    FOREIGN KEY (topic, language) REFERENCES articles_normalized(topic, language)
);
# нова таблиця сполучення між статтею та джерелами
CREATE TABLE article_sources (
    topic varchar(100),
    language LanguageEnum,
    source_url varchar(1000),
    PRIMARY KEY (topic, language, source_url),
    FOREIGN KEY (topic, language) REFERENCES articles_normalized(topic, language),
    FOREIGN KEY (source_url) REFERENCES sources(url)
);
# перероблена таблиця сполучення між статтею та ревізіями
# був доданий 'relative_index' який нумерує ревізії додані до унікальної статті,
# бо до цього користувача, додавшего дві ревізії до однієї статті у один день
# було неможоливо зареєструвати
CREATE TABLE article_revisions (
    relative_index SERIAL NOT NULL,
    topic varchar(100),
    language LanguageEnum,
    date DATE NOT NULL,
    user_id INT REFERENCES users(id),
    content TEXT NOT NULL,
    PRIMARY KEY (topic, language, relative_index),

    FOREIGN KEY (topic, language) REFERENCES articles_normalized(topic, language)
);