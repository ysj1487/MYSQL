USE sqlDB;
CREATE TABLE stdTbl(stdName VARCHAR(10) NOT NULL PRIMARY KEY, addr CHAR(4) NOT NULL);
CREATE TABLE clubTbl(clubName VARCHAR(10) NOT NULL PRIMARY KEY,roomNo CHAR(4) NOT NULL);
CREATE TABLE stdclubTbl
(num int AUTO_INCREMENT NOT NULL PRIMARY KEY, stdName VARCHAR(10) NOT NULL,
clubName VARCHAR(10) NOT NULL, FOREIGN KEY(stdName) REFERENCES stdTbl(stdName),
FOREIGN KEY(clubName) REFERENCES clubTbl(clubName));

INSERT INTO stdTbl VALUES ('김범수','경남'), ('성시경','서울'), ('조용필','경기'), ('은지원','경북'),('바비 킴','서울');
INSERT INTO clubTbl VALUES ('수영','101호'), ('바둑','102호'), ('축구','103호'), ('봉사','104호');
INSERT INTO stdclubTbl VALUES (NULL, '김범수','바둑'), (NULL,'김범수','축구'), (NULL,'조용필','축구'), (NULL,'은지원','축구'), (NULL,'은지원','봉사'), (NULL,'바비킴','봉사');

select * from stdtbl;
select * from clubtbl;
select * from stdclubtbl;

SELECT S.stdName, S.addr, C.clubName, C.roomNo FROM stdTbl S
INNER JOIN stdclubTbl SC ON S.stdName = SC.stdName
INNER JOIN clubTbl C ON SC.clubName = C.clubName 
ORDER BY S.stdName;

SELECT C.clubName, C.roomNo, S.stdName, S.addr FROM stdTbl S
INNER JOIN stdclubTbl SC ON SC.stdName = S.stdName
INNER JOIN clubTbl C ON SC.clubName = C.clubName
ORDER BY C.clubName;

USE sqlDB;
SELECT U.userID, U.usename, B.prodName, U.addr, CONCAT(U.mobile1, U.mobile2) AS '연락처'
FROM userTbl U LEFT OUTER JOIN buyTbl B ON U.userID = B.userID ORDER BY U.userID;

SELECT U.userID, U.usename, B.prodName, U.addr, CONCAT(U.mobile1, U.mobile2) AS '연락처'
FROM buyTbl B RIGHT OUTER JOIN userTbl U ON U.userID = B.userID
ORDER BY U.userID;

SELECT U.userID, U.usename, B.prodName, U.addr, CONCAT(U.mobile1, U.mobile2) AS '연락처'
FROM userTbl U LEFT OUTER JOIN buyTbl B ON U.userID = B.userID WHERE B.prodName IS NULL
ORDER BY U.userID;


USE sqlDB;

SELECT S.stdName, S.addr, C.clubName, C.roomNo FROM stdTbl S
LEFT OUTER JOIN stdclubTbl SC ON S.stdName = SC.stdName
LEFT OUTER JOIN clubTbl C ON SC.clubName = C.clubName
ORDER BY S.stdName;

SELECT C.clubName, C.roomNo, S.stdName, S.addr FROM stdTbl S
LEFT OUTER JOIN stdclubTbl SC ON SC.stdName = S.stdName
RIGHT OUTER JOIN clubTbl C ON SC.clubName = C.clubName
ORDER BY C.clubName ;

SELECT S.stdName, S.addr, C.clubName, C.roomNo FROM stdTbl S
LEFT OUTER JOIN stdclubTbl SC ON S.stdName = SC.stdName
LEFT OUTER JOIN clubTbl C ON SC.clubName = C.clubName
UNION 
SELECT S.stdName, S.addr, C.clubName, C.roomNo FROM stdTbl S
LEFT OUTER JOIN stdclubTbl SC ON SC.stdName = S.stdName
RIGHT OUTER JOIN clubTbl C ON SC.clubName = C.clubName;

USE sqlDB;
-- 중복된 열 포함/ union - 중복된 열 제거
SELECT stdName, addr FROM stdTbl UNION ALL
SELECT clubName, roomNo FROM clubTbl;

-- 전화 없는 사람 제거
SELECT usename, CONCAT(mobile1, mobile2) AS '전화번호' FROM userTbl 
WHERE usename NOT IN (SELECT usename FROM userTbl WHERE mobile1 IS NULL) ;

-- 전화 없는 사람 조회
SELECT usename, CONCAT(mobile1, mobile2) AS '전화번호' FROM userTbl 
WHERE usename IN (SELECT usename FROM userTbl WHERE mobile1 IS NULL) ;

-- 기존에 만든적이 있다면 삭제
DROP PROCEDURE IF EXISTS ifProc; 
DELIMITER $$
CREATE PROCEDURE ifProc()
BEGIN

-- var1 변수선언
DECLARE var1 INT; 

-- 변수에 값 대입
SET var1 = 100; 

-- 만약 @var1이 100이라면,
IF var1 = 100 THEN 
SELECT '100입니다.';

ELSE
SELECT '100이 아닙니다.';

END IF;

END $$

DELIMITER ;
CALL ifProc();
DROP PROCEDURE IF EXISTS ifProc3;

DELIMITER $$

CREATE PROCEDURE ifProc3()
BEGIN
DECLARE point INT ;
DECLARE credit CHAR(1);
SET point = 77 ;
IF point >= 90 THEN
SET credit = 'A';
ELSEIF point >= 80 THEN
SET credit = 'B';
ELSEIF point >= 70 THEN
SET credit = 'C';
ELSEIF point >= 60 THEN
SET credit = 'D';

ELSE
SET credit = 'F';

END IF;

SELECT CONCAT('취득점수==>', point), CONCAT('학점==>', credit);

END $$

DELIMITER ;
CALL ifProc3();
DROP PROCEDURE IF EXISTS caseProc;

DELIMITER $$
CREATE PROCEDURE caseProc()

BEGIN
BEGIN
DECLARE point INT ;
DECLARE credit CHAR(1);
SET point = 77 ;

CASE
WHEN point >= 90 THEN
SET credit = 'A';
WHEN point >= 80 THEN
SET credit = 'B';
WHEN point >= 70 THEN
SET credit = 'C';
WHEN point >= 60 THEN
SET credit = 'D';

ELSE
SET credit = 'F';
END CASE;
SELECT CONCAT('취득점수==>', point), CONCAT('학점==>', credit);
END $$
DELIMITER ;
CALL caseProc();
use sqldb;
SELECT U.userID, U.name, SUM(price*amount) AS '총구매액',
CASE
WHEN (SUM(price*amount) >= 1500) THEN '최우수고객'
WHEN (SUM(price*amount) >= 1000) THEN '우수고객'
WHEN (SUM(price*amount) >= 1 ) THEN '일반고객'
ELSE '유령고객'
END AS '고객등급'
FROM buyTbl B
RIGHT OUTER JOIN userTbl U
ON B.userID = U.userID
GROUP BY U.userID, U.name
ORDER BY sum(price*amount) DESC ;
--