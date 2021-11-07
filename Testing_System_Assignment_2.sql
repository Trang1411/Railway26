DROP DATABASE IF EXISTS TestingSystem2;
CREATE DATABASE 	TestingSystem2;
USE 				TestingSystem2;

CREATE TABLE Department (
	Department_id		tinyint unsigned,
	Department_name 	varchar(50)
);

CREATE TABLE  Position (
	 Position_id		tinyint unsigned,
	 Position_name 		varchar(50)
);

CREATE TABLE  `Account` (
  Account_id		tinyint unsigned,
  Email				varchar(30),
  UserName 			varchar(50),
  FullName 			varchar(50),
  Department_id		tinyint unsigned,
  Position_id		tinyint unsigned,
  CreateDate 		date
);

CREATE TABLE `Group`(
Group_id 			tinyint unsigned,
GroupName			varchar(50),
Creator_id 			tinyint unsigned,
CreateDate 			date
);

CREATE TABLE GroupAcount (
Group_id 			tinyint unsigned,
Account_id			tinyint unsigned,
JoinDate 			date
);

CREATE TABLE TypeQuestion (
Type_id 			tinyint unsigned,
TypeName			varchar(50)
);

CREATE TABLE CategoryQuestion(
Category_id 		tinyint unsigned,
CategoryName 		varchar(50)
);

CREATE TABLE Question (
Question_id 		tinyint unsigned,
Content 			varchar(200),
Category_id 		tinyint unsigned,
Type_id 			tinyint unsigned,
Creator_id 			tinyint unsigned,
CreateDate 			date
);

CREATE TABLE Answer(
Answer_id 			tinyint unsigned,
Content 			varchar(50),
Question_id 		tinyint unsigned,
isCorrect			varchar(10)
);

CREATE TABLE Exam (
Exam_id 			tinyint unsigned,
`Code` 				int,
Title				varchar(50),
Category_id 		tinyint unsigned,
Duration 			datetime,
Creator_id 			tinyint unsigned,
CreateDate 			date
);

CREATE TABLE ExamQuestion(
Exam_id 			tinyint unsigned,
Question_id 		tinyint unsigned
);
