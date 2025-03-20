```


DROP TABLE IF EXISTS Exams CASCADE;
DROP TABLE IF EXISTS Courses CASCADE;
DROP TABLE IF EXISTS Students CASCADE;	

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

INSERT INTO Courses (title, hours) VALUES 
('Математика', 100),
('Физика', 100),
('Информатика', 100);

CREATE TABLE Exams (
    s_id INT REFERENCES Students(s_id) ON DELETE CASCADE,
    c_no INT REFERENCES Courses(c_no) ON DELETE CASCADE,
    score INT,
    PRIMARY KEY (s_id, c_no)
);

-- несдавшие
SELECT s_id, name 
FROM Students 
WHERE s_id NOT IN (SELECT s_id FROM Exams);

-- количество для тех, кто сдал
SELECT s_id, name, COUNT(*) AS exam_count 
FROM Students 
JOIN Exams USING (s_id) 
GROUP BY s_id, name;

'''
