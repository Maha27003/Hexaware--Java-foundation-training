create database SISDB;
use SISDB;
create table Students(
student_id int auto_increment Primary Key ,
first_name varchar(50),
last_name varchar(50),
dob date,
gender enum('male','female','other'),
email varchar(50) Unique,
phone_number varchar(15)
);
create table Teacher (
    teacher_id int auto_increment Primary Key,
    first_name varchar(50),
    last_name varchar(50),
    email varchar(100) Unique
);
create table Courses (
    course_id int auto_increment Primary Key,
    course_name varchar(100) not null,
    credits int,
    teacher_id int,
    Foreign Key(teacher_id) References Teacher(teacher_id)
);
create Table Enrollments (
    enrollment_id int auto_increment Primary Key,
    student_id int,
    course_id int,
    enrollment_date date,
    Foreign Key (student_id) References Students(student_id),
    Foreign Key (course_id) References Courses(course_id)
);
create table Payments (
    payment_id int auto_increment Primary Key,
    student_id int,
    amount decimal(10, 2),
    payment_date date,
    Foreign Key (student_id) References Students(student_id)
);
insert into Students (first_name, last_name, dob, gender, email, phone_number) values
('Alya', 'Kumar', '2002-04-10', 'female', 'alya.kumar@example.com', '9876543210'),
('Anu', 'Ravi', '2001-08-23', 'female', 'anu.ravi@example.com', '9876543211'),
('Vino', 'Das', '2000-12-05', 'male', 'vino.das@example.com', '9876543212'),
('Jo', 'Mathew', '2003-01-19', 'male', 'jo.mathew@example.com', '9876543213'),
('Nivi', 'Prem', '2002-06-15', 'female', 'nivi.prem@example.com', '9876543214'),
('Kirthi', 'Menon', '2001-11-30', 'female', 'kirthi.menon@example.com', '9876543215'),
('Rethi', 'Roy', '2000-07-27', 'female', 'rethi.roy@example.com', '9876543216'),
('Aila', 'Suresh', '2003-03-08', 'female', 'aila.suresh@example.com', '9876543217'),
('Sam', 'Vijay', '2002-09-22', 'male', 'sam.vijay@example.com', '9876543218'),
('Soni', 'Sri', '2001-05-13', 'female', 'soni.sri@example.com', '9876543219');
insert into Teacher (first_name, last_name, email) values
('Elan', 'Frost', 'elan.frost@eduportal.com'),
('Tara', 'Solis', 'tara.solis@eduportal.com'),
('Mira', 'Kane', 'mira.kane@eduportal.com'),
('Zion', 'Vale', 'zion.vale@eduportal.com'),
('Naya', 'Creed', 'naya.creed@eduportal.com'),
('Riven', 'Thorne', 'riven.thorne@eduportal.com'),
('Lira', 'Stone', 'lira.stone@eduportal.com'),
('Cael', 'River', 'cael.river@eduportal.com'),
('Vira', 'Skye', 'vira.skye@eduportal.com'),
('Dren', 'Blaze', 'dren.blaze@eduportal.com');
insert into Courses (course_name, credits, teacher_id) values
('Introduction to Computer Science', 4, 1),
('Database Management Systems', 3, 2),
('Web Development', 3, 3),
('Operating Systems', 4, 4),
('Artificial Intelligence', 3, 5),
('Data Structures', 4, 6),
('Software Engineering', 3, 7),
('Computer Networks', 3, 8),
('Machine Learning', 4, 9),
('Mobile App Development', 3, 10);

insert into Enrollments (student_id, course_id, enrollment_date) values
(1, 2, '2024-06-01'),
(2, 3, '2024-06-02'),
(3, 1, '2024-06-03'),
(4, 4, '2024-06-04'),
(5, 5, '2024-06-05'),
(6, 6, '2024-06-06'),
(7, 7, '2024-06-07'),
(8, 8, '2024-06-08'),
(9, 9, '2024-06-09'),
(10, 10, '2024-06-10');
insert into Payments (student_id, amount, payment_date) values
(1, 1500.00, '2025-01-15'),
(2, 1200.50, '2025-02-10'),
(3, 1800.00, '2025-03-05'),
(4, 1350.75, '2025-03-20'),
(5, 1600.00, '2025-04-01'),
(6, 1450.25, '2025-04-05'),
(7, 1500.00, '2025-04-15'),
(8, 1200.50, '2025-04-18'),
(9, 1800.00, '2025-04-20'),
(10, 1350.75, '2025-04-25');
alter table Enrollments change enrollment_date enrolled_date date;
select *from Enrollments;










