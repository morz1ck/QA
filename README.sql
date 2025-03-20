-- Задание 1.

CREATE DATABASE university
    WITH
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'ru'
    LC_CTYPE = 'ru'
    LOCALE_PROVIDER = 'libc'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1
    IS_TEMPLATE = False;

DROP TABLE IF EXISTS Exams CASCADE;
DROP TABLE IF EXISTS Courses CASCADE;
DROP TABLE IF EXISTS Students CASCADE;	

--Задание 2.

CREATE TABLE Students (
    s_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    start_year INT
);

CREATE TABLE Courses (
    c_no SERIAL PRIMARY KEY,
    title VARCHAR(100) NOT NULL UNIQUE,
    hours INT
);

CREATE TABLE Exams (
    s_id INT REFERENCES Students(s_id) ON DELETE CASCADE,
    c_no INT REFERENCES Courses(c_no) ON DELETE CASCADE,
    score INT,
    PRIMARY KEY (s_id, c_no)
);

-- Задание 3. 
INSERT INTO Students (name, start_year) VALUES 
('Иван Иванов', 2021),
('Мария Петрова', 2020),
('Алексей Сидоров', 2019),
('Сергей Кузнецов', 2022),
('Ольга Смирнова', 2023);

INSERT INTO Courses (title, hours) VALUES 
('Математика', 120),
('Физика', 100),
('Информатика', 100);


INSERT INTO Exams (s_id, c_no, score) VALUES 
(1, 1, 85),
(1, 2, 90),
(2, 1, 78),
(3, 3, 88), 
(3, 2, 75);  



-- Задание 4. Несдавшие.
SELECT s_id, name 
FROM Students 
WHERE s_id NOT IN (SELECT s_id FROM Exams);

-- Задание 5. Сдавшие
SELECT s_id, name, COUNT(*) AS exam_count 
FROM Students 
JOIN Exams USING (s_id) 
GROUP BY s_id, name;

--Задание 6. Средний балл по экзамену.
SELECT 
    c.title, 
    ROUND(AVG(e.score), 2) AS avg_score
FROM Courses c
JOIN Exams e ON c.c_no = e.c_no
GROUP BY c.title
ORDER BY avg_score DESC;
