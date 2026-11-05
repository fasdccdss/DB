SELECT topic, user_id, name
FROM article
JOIN revisions_table ON article.topic = revisions_table.revision_topic
JOIN users ON revisions_table.user_id = users.id
WHERE 'Science'::CategoryEnum = ANY(categories);

INSERT INTO revisions_table(revision_topic, revision_language, revision_date, user_id, content)
VALUES 
('Physics', 'Ukrainian', '2012-11-05', 3, 'ssssssssssssssssss'),
('Physics', 'Ukrainian', '2012-11-05', 2, 'fffffffffffffffff'),
('Physics', 'Ukrainian', '2015-11-01', 1, 'wwwwwwwwwwwwwww');

UPDATE users
SET name = 'MfD'
WHERE id = 1;

DELETE FROM revisions_table
WHERE revision_date = '2012-11-05' OR revision_date = '2015-11-01';