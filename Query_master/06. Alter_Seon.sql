create database testdb;
use testdb;
drop table if exists buytbl, usertbl;

select * from usertbl;
select * from buytbl;

create table usertbl
( userID char(8) not null primary key,
name varchar(10) not null,
birthyear int not null,
addr char(2) not null,
mobile1 char(3) null,
mobile2 char(8) null,
height smallint null,
mdate date null
);

create table buytbl
( num int auto_increment not null primary key,
userid char(8) not null,
foreign key(userid) references usertbl(userID),
prodname char(6) not null,
groupname char(4) null,
price int not null,
amount smallint not null
);

insert into usertbl values('LSG', '이승기', 1987, '서울', '011', '1111111', 182, '2008-8-8');
insert into usertbl values('KBS', '김범수', 1979, '경남', '011', '2222222', 173, '2012-4-4');
insert into usertbl values('KKH', '김경호', 1971, '전남', '019', '3333333', 177, '2007-7-7');

select * from usertbl;

insert into buytbl values(null, 'KBS', '운동화', null, 30, 2);
insert into buytbl values(null, 'KBS', '노트북', '전자', 1000, 1);
insert into buytbl values(null, 'JYP', '모니터', '전자', 200, 1);
-- 외래키 항목 입력시 주키가 입력되어있어야 가능

select * from buytbl;

insert ignore into buytbl values(null, 'KBS', '운동화', null, 30, 2);
insert ignore into buytbl values(null, 'KBS', '노트북', '전자', 1000, 1);
insert ignore into buytbl values(null, 'JYP', '모니터', '전자', 200, 1);

select * from buytbl;

drop table usertbl;
-- foreign key 때문에 안지워짐
alter table buytbl drop foreign key buytbl_ibfk_1;
-- foreign key 해제

drop table usertbl;
select * from usertbl;

create table usertbl
( userID char(8) not null,
name varchar(10) not null,
birthyear int not null,
addr char(2) not null,
mobile1 char(3) null,
mobile2 char(8) null,
height smallint null,
mdate date null,
email char(30) null
);
-- constraint ak_email uniue (email)

alter table usertbl
add constraint email_unique_key unique key (email);

alter table usertbl
add constraint pk_usertbl_userid
primary key (userid);

create table prodtbl
(prodcode char(3) not null,
prodid char(4) not null,
proddate datetime not null,
prodcur char(10) null
);

alter table prodtbl
add constraint pk_prodtbl_procode_prodid
primary key (prodcode, prodid);

drop table if exists prodtbl;

create table prodtbl
(prodcode char(3) not null,
prodid char(4) not null,
proddate datetime not null,
prodcur char(10) null,
primary key (prodcode, prodid)
);


show index from buytbl;
show index from usertbl;
-- table의 key 정보 확인

alter table buytbl
add constraint fk_usertbl_buytbl
foreign key userid
references usertbl (userid)
;

create table usertbl
( userID char(8) not null primary key,
name varchar(10) not null,
birthyear int not null,
addr char(2) not null,
mobile1 char(3) null,
mobile2 char(8) null,
height smallint null,
mdate date null
);

alter table usertbl
alter column birthyear set default -1;

alter table usertbl
alter column addr set default '서울';

alter table usertbl
alter column height set default 170;
-- default 값 설정

insert into usertbl values ('wb', '원빈',1982, '대전', '019', '9876543', 176, '2017.5.5');
insert into usertbl values ('lhl', '이혜리',default, default, '011', '1234567', default, '2019.7.5');
insert into usertbl(userid, name) values('kay', '김아영');
-- column 명 필수

select * from usertbl;

-- 시스템 변수 확인
show variables like 'innodb_file_format'; -- barracuda
show variables like 'innodb_large_format'; -- on

create database if not exists compressdb;
use compressdb;
create table normaltbl(emp_no int, first_name varchar(14));
create table compresstbl( emp_no int, first_name varchar(14)) row_format= compressed;


-- 외부에서 데이터를 가져와 입력 ( table 복사)
insert into normaltbl 
select emp_no, first_name from employees.employees;


insert into compresstbl
select emp_no, first_name from employees.employees;

show table status from compressdb;
drop database if exists compressdb;