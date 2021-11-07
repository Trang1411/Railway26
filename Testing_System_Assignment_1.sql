CREATE DATABASE 	TestingSystem;
USE 				TestingSystem;

CREATE TABLE Department (
	Department_id		int,
	Department_name 	varchar(50)
);

CREATE TABLE  Position (
	 Position_id		int,
	 Position_name 		varchar(50)
);

CREATE TABLE  `Account` (
  Account_id		int,
  Email				varchar(30),
  UserName 			varchar(50),
  FullName 			varchar(50),
  Department_id		int,
  Position_id		int,
  CreateDate 		date
);

CREATE TABLE `Group`(
Group_id 			int,
GroupName			varchar(50),
Creator_id 			int,
CreateDate 			date
);

CREATE TABLE GroupAcount (
Group_id 			int,
Account_id			int,
JoinDate 			date
);

CREATE TABLE TypeQuestion (
Type_id 			int,
TypeName			varchar(50)
);

CREATE TABLE CategoryQuestion(
Category_id 		int,
CategoryName 		varchar(50)
);

CREATE TABLE Question (
Question_id 		int,
Content 			varchar(200),
Category_id 		int,
Type_id 			int,
Creator_id 			int,
CreateDate 			date
);

CREATE TABLE Answer(
Answer_id 			int,
Content 			varchar(50),
Question_id 		int,
isCorrect			varchar(10)
);

CREATE TABLE Exam (
Exam_id 			int,
`Code` 				int,
Title				varchar(50),
Category_id 		int,
Duration 			time,
Creator_id 			int,
CreateDate 			date
);

CREATE TABLE ExamQuestion(
Exam_id 			int,
Question_id 		int
);
