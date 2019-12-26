SELECT CAST('2020-10-19 12:35:29.123' AS DATE) AS 'DATE' ;
SELECT CAST('2020-10-19 12:35:29.123' AS TIME) AS 'TIME' ;
SELECT CAST('2020-10-19 12:35:29.123' AS DATETIME) AS 'DATETIME' ;

USE sqlDB;
SET @myVar1 = 5 ;
SET @myVar2 = 3 ;
SET @myVar3 = 4.25 ;
SET @myVar4 = '가수 이름==> ' ;

SELECT @myVar1 ;
SELECT @myVar2 + @myVar3 ;
SELECT @myVar4 , Name FROM userTbl WHERE height > 180 ;
SET @myVar1 = 3 ;

PREPARE myQuery	FROM 'SELECT useName, height FROM userTbl ORDER BY height LIMIT ?';
EXECUTE myQuery USING @myVar1 ;

USE sqlDB ;
SELECT AVG(amount) AS '평균 구매 개수' FROM buyTbl ;
SELECT CAST(AVG(amount) AS SIGNED INTEGER) AS '평균 구매 개수' FROM buyTbl ;
SELECT CONVERT(AVG(amount) , SIGNED INTEGER) AS '평균 구매 개수' FROM buyTbl ;

SELECT CAST('2020$12$12' AS DATE);
SELECT CAST('2020/12/12' AS DATE);
SELECT CAST('2020%12%12' AS DATE);
SELECT CAST('2020@12@12' AS DATE);

SELECT num, CONCAT(CAST(price AS CHAR(10)), 'X', CAST(amount AS CHAR(4)) ,'=' ) AS '단가X수 량', price*amount AS '구매액' FROM buyTbl ;
SELECT '100' + '200' ; -- 문자와 문자를 더함 (정수로 변환되서 연산됨)
SELECT CONCAT('100', '200'); -- 문자와 문자를 연결 (문자로 처리)
SELECT CONCAT(100, '200'); -- 정수와 문자를 연결 (정수가 문자로 변환되서 처리)

SELECT IF (100>200, '참이다', '거짓이다');
SELECT IFNULL(NULL, '널이군요'), IFNULL(100, '널이군요');
SELECT NULLIF(100,100), IFNULL(200,100);

SELECT CASE 10
WHEN 1 THEN '일'
WHEN 5 THEN '오'
WHEN 10 THEN '십'
ELSE '모름'
END;

-- 문자 인덱싱
SELECT BIT_LENGTH('abc'), CHAR_LENGTH('abc'), LENGTH('abc'); -- length : byte 길이
SELECT BIT_LENGTH('가나다'), CHAR_LENGTH('가나다'), LENGTH('가나다');
SELECT CONCAT_WS('/', '2020', '01', '01'); -- 구분자로 문자열을 이어준다.
SELECT ELT(2, '하나', '둘', '셋'), FIELD('둘', '하나', '둘', '셋'), FIND_IN_SET('둘', '하나,둘,셋'), INSTR('하나 둘셋', '둘'), LOCATE('둘', '하나둘셋');
SELECT FORMAT(123456.123456, 4);
SELECT INSERT('abcdefghi', 3, 4, '@@@@'), INSERT('abcdefghi', 3, 2, '@@@@');
SELECT LEFT('abcdefghi', 3), RIGHT('abcdefghi', 3);
SELECT LOWER('abcdEFGH'), UPPER('abcdEFGH');
SELECT LPAD('이것이', 5, '##'), RPAD('이것이', 5, '##');
SELECT LTRIM(' 이것이'), RTRIM('이것이 ');
SELECT REPEAT('이것이', 3);
SELECT REPLACE ('이것이 MySQL이다', '이것이' , 'This is');
SELECT REVERSE ('MySQL');
SELECT CONCAT('이것이', SPACE(10), 'MySQL이다');
SELECT SUBSTRING('대한민국만세', 3, 2);
SELECT SUBSTRING_INDEX('cafe.naver.com', '.', 2), SUBSTRING_INDEX('cafe.naver.com', '.', -2);

-- 숫자 인덱싱
SELECT ABS(-100);
SELECT CEILING(4.7), FLOOR(4.7), ROUND(4.7);
SELECT CONV('AAA', 16, 2), CONV(100, 10, 8);
SELECT MOD(157, 10), 157 % 10, 157 MOD 10;
SELECT POW(2,3), SQRT(9);
SELECT SIGN(100), SIGN(0), SIGN(-100.123);
SELECT TRUNCATE(12345.12345, 2), TRUNCATE(12345.12345, -2);

-- length 특징
USE sqlDB;
CREATE TABLE maxTbl (col1 LONGTEXT, col2 LONGTEXT);
INSERT INTO maxTbl VALUES (REPEAT('A', 1000000), REPEAT('가',1000000));
SELECT LENGTH(col1), LENGTH(col2) FROM maxTBL;
INSERT INTO maxTbl VALUES (REPEAT('A', 10000000), REPEAT('가',10000000));

/*
CD %PROGRAMDATA%
CD MySQL
CD "MySQL Server 5.7"
DIR
NOTEPAD my.ini
max_allowed_packet=4M --> 1000M
NET STOP MySQL
NET START MySQL
*/


use sqldb;
INSERT INTO maxTbl VALUES (REPEAT('A', 10000000), REPEAT('가',10000000));
SELECT LENGTH(col1), LENGTH(col2) FROM maxTBL;
SHOW variables LIKE 'max%';
/*
secure-file-priv=C:/TEMP
*/

USE sqlDB;
SELECT * INTO OUTFILE 'C:/TEMP/userTBL.txt' FROM userTBL;
CREATE TABLE memberTBL LIKE userTBL; -- 테이블 구조만 복사
LOAD DATA LOCAL INFILE 'C:/TEMP/userTBL.txt' INTO TABLE memberTBL;
select * from membertbl;

-- </실습 2> -
select * from buytbl;
select * from usertbl;
USE sqlDB; -- 구매자 주소 확인

SELECT * FROM buyTbl INNER JOIN userTbl ON buyTbl.userID = userTbl.userID 
WHERE buyTbl.userID = 'JYP';

-- 필요한 열만 추출 - error
SELECT userID, usename, prodName, addr, mobile1 + mobile2 AS '연락처' 
FROM buyTbl INNER JOIN userTbl ON buyTbl.userID = userTbl.userID;

-- buytbl 기준
SELECT buyTbl.userID, usename, prodName, addr, mobile1 + mobile2 
AS '연락처' FROM buyTbl INNER JOIN userTbl ON buyTbl.userID = userTbl.userID;
select * from usertbl;
select * from buytbl;

-- where문 활용
SELECT buyTbl.userID, usename, prodName, addr, mobile1 + mobile2 
AS '연락처' FROM buyTbl, userTbl WHERE buyTbl.userID = userTbl.userID ;

-- 모두 테이블명
SELECT buyTbl.userID, userTbl.usename, buyTbl.prodName, userTbl.addr, userTbl.mobile1 + userTbl.mobile2 
AS '연락처' FROM buyTbl INNER JOIN userTbl ON buyTbl.userID = userTbl.userID;

-- 별칭
SELECT B.userID, U.usename, B.prodName, U.addr, U.mobile1 + U.mobile2 AS '연락처' 
FROM buyTbl B INNER JOIN userTbl U ON B.userID = U.userID;

SELECT B.userID, U.usename, B.prodName, U.addr, U.mobile1 + U.mobile2 AS '연락처'
FROM buyTbl B INNER JOIN userTbl U ON B.userID = U.userID WHERE B.userID = 'JYP';

-- 회원테이블 기준
SELECT U.userID, U.usename, B.prodName, U.addr, U.mobile1 + U.mobile2 AS '연락처' 
FROM userTbl U INNER JOIN buyTbl B ON U.userID = B.userID WHERE B.userID = 'JYP';

SELECT U.userID, U.usename, B.prodName, U.addr, U.mobile1 + U.mobile2 AS '연락처'
FROM userTbl U INNER JOIN buyTbl B ON U.userID = B.userID ORDER BY U.userID;

SELECT DISTINCT U.userID, U.usename, U.addr FROM userTbl U INNER JOIN buyTbl B
ON U.userID = B.userID ORDER BY U.userID ;