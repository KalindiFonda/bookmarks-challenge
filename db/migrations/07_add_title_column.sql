\c bookmark_manager
ALTER TABLE bookmarks ADD COLUMN title VARCHAR(60);
INSERT INTO bookmarks(title, url)
VALUES('KNOWLEDGE', 'http://wikipedia.org');
