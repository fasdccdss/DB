SELECT COUNT(*) AS total_users
FROM users;

SELECT AVG(LENGTH(content)) AS average_content_length
FROM revisions_table;

SELECT revision_topic, COUNT(*) AS revision_count
FROM revisions_table
GROUP BY revision_topic
ORDER BY revision_count DESC;

SELECT COUNT(*) AS article_count
FROM article;

SELECT name, revision_topic
FROM users
INNER JOIN revisions_table ON users.id = revisions_table.user_id
WHERE revision_topic = 'Physics';

SELECT categories, topic, revision_date
FROM article
FULL JOIN revisions_table ON article.topic = revisions_table.revision_topic
WHERE categories && ARRAY['Science', 'Politics']::CategoryEnum[];

SELECT article.topic, COUNT(DISTINCT revisions_table.user_id) AS unique_contributors
FROM article
JOIN revisions_table ON article.topic = revisions_table.revision_topic
GROUP BY topic;