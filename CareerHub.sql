create  database if not exists CareerHub;
use CareerHub;

drop table if exists Applications;
drop table if exists Jobs;
drop table if exists Applicants;
drop table if exists Companies;

create table Companies (
    CompanyID int primary key auto_increment,
    CompanyName varchar(255) not null,
    Location varchar(255) not null
);

create table Jobs (
    JobID int primary key auto_increment,
    CompanyID int,
    JobTitle varchar(255) not null,
    JobDescription text,
    JobLocation varchar(255),
    Salary decimal(10, 2),
    JobType varchar(100),
    PostedDate datetime,
    foreign key (CompanyID) references Companies(CompanyID)
);

create table Applicants (
    ApplicantID int primary key auto_increment,
    FirstName varchar(255) not null,
    LastName varchar(255) not null,
    Email varchar(255) unique not null,
    Phone varchar(20),
    City varchar(100),
    State varchar(100),
    ExperienceYears int,
    Res text
);

create table Applications (
    ApplicationID int primary key auto_increment,
    JobID int,
    ApplicantID int,
    ApplicationDate datetime,
    CoverLetter text,
    foreign key (JobID) references Jobs(JobID),
    foreign key (ApplicantID) references Applicants(ApplicantID)
);

insert into Companies (CompanyName, Location) values
('Hexaware', 'Chennai'),
('CodeForge', 'Bangalore'),
('InnoSoft', 'Hyderabad'),
('NextGen Solutions', 'Mumbai');

insert into Jobs (CompanyID, JobTitle, JobDescription, JobLocation, Salary, JobType, PostedDate) values
(1, 'Software Developer', 'Develop enterprise applications.', 'Chennai', 70000.00, 'Full-time', now()),
(1, 'QA Engineer', 'Test software systems.', 'Chennai', 60000.00, 'Full-time', now()),
(2, 'Backend Developer', 'API and service development.', 'Bangalore', 80000.00, 'Full-time', now()),
(3, 'DevOps Engineer', 'Manage CI/CD pipelines.', 'Hyderabad', 75000.00, 'Contract', now());

insert into Applicants (FirstName, LastName, Email, Phone, City, State, ExperienceYears, Res) values
('Anu', 'John', 'anujohn@gnail.com', '1234567890', 'Chennai', 'TN', 4, 'Experienced Java developer'),
('Neha', 'Sri', 'nehasri@gmail.com', '2345678901', 'Mumbai', 'MH', 2, 'Junior QA engineer'),
('Kavya', 'Shree', 'kavyashree@gmail.com.com', '3456789012', 'Chennai', 'TN', 3, 'Backend Node.js developer'),
('Danya', 'Krishna', 'danyakrishna@gmail.com', '4567890123', 'Bangalore', 'KA', 5, 'DevOps and Cloud engineer');


insert into Applications (JobID, ApplicantID, ApplicationDate, CoverLetter) values
(1, 1, now(), 'I am excited to apply for this role.');

insert into Applications (JobID, ApplicantID, ApplicationDate, CoverLetter) values
(3, 3, now(), 'Looking forward to contributing to your backend team.');

insert into Applications (JobID, ApplicantID, ApplicationDate, CoverLetter) values
(4, 4, now(), 'DevOps is my passion and expertise.');

select JobTitle ,count(ApplicationID) as ApplicationCount
from Jobs left join Applications using(JobID) group by JobID;

select JobTitle,CompanyName,Location,Salary from Companies
inner join Jobs using(CompanyID) where Salary between 60000.00 and 75000.00;

select JobTitle,CompanyName,ApplicationDate from Applications inner join 
Jobs using(JobID) inner join Companies using(CompanyID);

select avg(Salary) as AverageSalary
from Jobs where Salary > 0;

select CompanyName, count(JobID) as JobCount
from Companies c
inner join Jobs j using (CompanyID) group by CompanyID
having JobCount = (
    select max(JobCountSub) from (
        select count(*) as JobCountSub
        from Jobs
        group by CompanyID
    ) as sub
);


select distinct FirstName, LastName, ExperienceYears, Location
from Applicants inner join Applications app using(ApplicantID)
inner join Jobs using(JobID)
inner join Companies using(CompanyID)
where Location = 'Bangalore' and ExperienceYears >= 3;

select distinct JobTitle
from Jobs
where Salary between 60000 and 80000;

select JobTitle
from Jobs 
left join Applications using(JobID)
where ApplicationID is null;

select FirstName,LastName,CompanyName,JobTitle
from Applications inner join Applicants using(ApplicantID)
inner join Jobs using(JobID)
inner join Companies using(CompanyID);

select CompanyName,count(JobID) as JobCount
from Companies left join Jobs using(CompanyID) 
group by CompanyID;

select FirstName,LastName,CompanyName,JobTitle
from Applicants left join Applications using(ApplicantID)
left join Jobs using(JobID)
left join Companies using(CompanyID);

select distinct CompanyName from Companies 
inner join Jobs using(CompanyID)
where Salary > (
    select avg(Salary)
    from Jobs
    where Salary > 0
);

select FirstName,LastName,concat(City, ', ', State)
as Location from Applicants;

select JobTitle from Jobs
where JobTitle like '%Developer%' or JobTitle like '%Engineer%';

select FirstName,LastName,JobTitle from Applicants left join Applications
using(ApplicantID) left join Jobs using(JobID) 
union
select null as FirstName,null as LastName,JobTitle
from Jobs left join Applications using(JobID) 
where ApplicationID is null;

select FirstName,LastName,CompanyName
from Applicants cross join Companies 
where Location = 'Chennai'
and ExperienceYears > 2;
