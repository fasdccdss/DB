SELECT topic, user_id
FROM article
JOIN revisions_table ON article.topic = revisions_table.revision_topic
WHERE 'Science'::CategoryEnum = ANY(categories);

INSERT INTO revisions_table(revision_topic, revision_language, revision_date, user_id, content)
VALUES 
('Physics', 'Ukrainian', '2012-11-04', 3, 'ssssssssssssssssss'),
('Physics', 'Ukrainian', '2012-11-04', 2, 'fffffffffffffffff'),
('Physics', 'Ukrainian', '2015-11-03', 1, 'wwwwwwwwwwwwwww');