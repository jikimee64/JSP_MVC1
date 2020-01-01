-- DB 생성
create database dontcallme;

-- 유저 테이블 
create table cctv(
	userID VARCHAR(64),
	userPassword VARCHAR(64),
	userName VARCHAR(20),
	userEmail VARCHAR(50),
	userEmailHash VARCHAR(64),
	userEmailChecked tinyint(1),
	userIP1 VARCHAR(30),
	userIP2 VARCHAR(30),
	userIP3 VARCHAR(30),
	userIP4 VARCHAR(30),
	PRIMARY KEY(userID)
);

-- 게시판 테이블
create table bbs(
	bbsID INT,
	bbsTitle VARCHAR(50),
	userID VARCHAR(20),
	bbsDate DATETIME,
	bbsContent VARCHAR(2048),
	fileName VARCHAR(200),
	bbsAvailable INT,
	likeCount int,
	PRIMARY KEY(bbsID)
);

-- 파일 업로드 테이블
 CREATE TABLE FILE(
	fileName VARCHAR(200),
	fileRealName VARCHAR(200)
);

-- 댓글 테이블
CREATE TABLE COMM(
	commID INT(11),
	userID VARCHAR(20),
	commDate DATETIME,
	commContent VARCHAR(2048),
	bbsID INT(11),
	PRIMARY KEY(commID)
);

-- 좋아요 테이블
CREATE TABLE LIKEY(
	userID varchar(20),
	bbsID int,
	userIP varchar(50)
);

