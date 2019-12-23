create database webdb;
use webdb;
show databases;
show tables;

create table pet(
name varchar(20),
owner varchar(20),
species varchar(20),
sex char(1),
birth date,
death date);

show tables;

-- drop tables pet;

insert into pet values('Fluffy','Harold', 'cat','f','1999-02-04',null);


select * from pet;

load data local infile 'C:/Temp/pettable.txt' into table pet;

show variables like 'secure-file%';

select * from pet;

select * from pet where name = 'Bowser';

select * from pet where birth >='1998-01-01';

select * from pet where species = 'dog' and sex = 'f';

select * from pet where species = 'snake' or species= 'bird';

select name, birth from pet;

select name, birth from pet order by birth;
select name, birth from pet order by birth desc;

select name from pet where death is not null;

select name from pet where death is null;

select * from pet where name like 'b%';

select * from pet where name like '%fy';

select* from pet where name like '%w%';

select* from pet where name like '_____';

select* from pet where name like '^b';

select* from pet where name like 'fy$';

select count(*) from pet;
select * from pet;

set sql_safe_updates = 0;
-- sql의 자동 업데이트 방지 기능 해제

update pet set species='dog' where name = 'claws';
select * from pet;

update pet set death = null where death = '0000-00-00';

update pet set species = 'pig' where birth < '1990-01-01';
-- 1990년대 이후에 태어난 동물은 'pig'로 바꾸겠다
