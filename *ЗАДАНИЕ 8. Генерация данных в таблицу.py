import psycopg2, random


# Подключение к базе данных
conn = psycopg2.connect(
    dbname="university",
    user="postgres",
    password="a14092006",
    host="localhost",
    port="1409"
)
cur = conn.cursor()
names = ['Джимми Ортега', 'Джеронимо Стилтон', 'Джеки Чан', 'Иван Мелентьев', 'Кириилл Осипов'
         'Антоша Гульнев', 'Никита Кузнецов', 'Андрей Латкин', 'Роман Баев', 'Оля Головина', 'Михаил Авдонин',
         'Глино Мес', 'Самос Вал']



for _ in range(len(names) - 1):
    name = random.choice(names)
    start_year = random.randint(2021, 2024)
    cur.execute("INSERT INTO Students (name, start_year) VALUES (%s, %s) RETURNING s_id", (name, start_year))


cur.execute("SELECT s_id FROM Students")
students = [row[0] for row in cur.fetchall()]


if not students:
    print("таблица students пуста")
    exit()

cur.execute("SELECT c_no FROM Courses")
courses = [row[0] for row in cur.fetchall()]


if not courses:
    print("таблица courses пуста")
    exit()

for _ in range(20):
    s_id = random.choice(students)
    c_no = random.choice(courses)
    score = random.randint(2, 5)

    cur.execute("""
        INSERT INTO Exams (s_id, c_no, score) 
        VALUES (%s, %s, %s) 
        ON CONFLICT (s_id, c_no) DO UPDATE 
        SET score = EXCLUDED.score
    """, (s_id, c_no, score))


conn.commit()
cur.close()
conn.close()

print("данные готовы")
