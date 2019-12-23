##########################################################
##########################################################
##########################################################

# SQL - MySQL for Data Analytics and Business Intelligence
# Lecture and Exercise Code

##########################################################
##########################################################
##########################################################





##########################################################
##########################################################

-- SECTION: First Steps in SQL

##########################################################
##########################################################

# sales database 생성


create database sales;


# sales database 선택
use sales;



drop table test;
# test table 생성
# test column 생성 - datatype -  DECIMAL(5,3)

create table test
(test decimal(5,3)); -- 전체가 다섯자리이고 소숫점은 세자리까지 표시하라 



# 값 10.5 입력
insert into test values (10.5);



# test테이블 출력
select * from test;



# 값 입력 - 12.55555
insert into test values (12.55555);


## 칼럼 추가  `test_fl` - FLOAT(5,3) NULL AFTER `test`

alter table test add test_fl float(5,3) null after test;

select * from test;

## 값 입력 - test_fl : 14.55555 / test : 16.55555
update test set test = 16.55555;

SET SQL_SAFE_UPDATES = 0;

select * from test;

update test set test_fl = 14.55555;


select * from test;
## test table 삭제

delete from test;



/*
sales 테이블 생성
	purchase_number - INT  ,
    date_of_purchase - DATE NOT NULL,     
    customer_id - INT,
    item_code - VARCHAR(10) NOT NULL
 */   
    
create table sales (
purchase_number  INT  auto_increment primary key,
date_of_purchase  DATE NOT NULL,     
customer_id  INT,
item_code  VARCHAR(10) NOT NULL
);




/*
customers 테이블 생성
    customer_id - INT,
    first_name - varchar(255),
    last_name - varchar(255),
    email_address - varchar(255),
    number_of_complaints - int
*/
    
    
create table customers (
	customer_id  INT,
    first_name  varchar(255),
    last_name  varchar(255),
    email_address  varchar(255),
    number_of_complaints  int
);


## sales 테이블의 purchase_number를 primary key로 지정 - 2가지 방범/ not null로 지정/ auto_increment로 지정
## customers 테이블의 customer_id를 primary key로 지정

drop table if exists customers;

create table customers (
	customer_id  INT primary key,
    first_name  varchar(255),
    last_name  varchar(255),
    email_address  varchar(255),
    number_of_complaints  int
    );

/* or 
create table customers (
	customer_id  INT,
    first_name  varchar(255),
    last_name  varchar(255),
    email_address  varchar(255),
    number_of_complaints  int,
    primary key(customer_id)
    );
*/
    

#  customers table에 customer_id에 primary key 제약조건 추가
alter table customers add primary key (customer_id);

#  sales 테이블에  purchase_number 칼럼에에 primary key 제약조건 추가
alter table sales add primary key (purchase_number);

# customers, sales 테이블의 정보 확인
describe customers;
describe sales;



items 테이블 생성, 
	
	primary key - item_id
    item_id - VARCHAR(255),
    item - VARCHAR(255),
    unit_price - NUMERIC(10 , 2 ),
    company_id - VARCHAR(255),
    
    drop table if exists items; 
    
    create table items(
    item_id  VARCHAR(255) primary key,
    item  VARCHAR(255),
    unit_price  NUMERIC(10 , 2 ),
    company_id  VARCHAR(255)
    );


companies 테이블 생성, 
	primary key - company_id
    company_id - VARCHAR(255),
    company_name - VARCHAR(255),
    headquarters_phone_number - INT(12),
    
    create table companies(
		company_id  VARCHAR(255),
		company_name  VARCHAR(255),
		headquarters_phone_number  INT(12),
        primary key(company_id)
        );
    



## alter - customers테이블 - email_address - unique key로 지정

alter table customers add unique key (email_address);
    


## customers table에 외래키를 추가하고 삭제 시 자동 없데이트 옵션
alter table sales add foreign key (customer_id)
references customers (customer_id);


## customers테이블 gender column를 추가 - enum('M', 'F')
alter table customers add column gender enum ('m', 'f') after last_name; -- enum: 범주형 데이터를 구성하는 데이터타입


## customers 테이블 값 추가 - '01', 'John', 'Mackinley', 'M', 'john.mckinley@365careers.com', 0
insert into customers values ('01', 'John', 'Mackinley', 'M', 'john.mckinley@365careers.com', 0);


## customers 테이블 값 추가 - customer_id, first_name, last_name, gender, email_address -> 2, 'Peter', 'Figaro', 'M', 'sss@hotmail.com'

insert into customers (customer_id, first_name, last_name, gender, email_address) 
values (2, 'Peter', 'Figaro', 'M', 'sss@hotmail.com');


## companies table의 company_name을 not null로 추가
alter table companies modify company_name varchar(200) not null;

-- or alter table companies change company_name company_name varchar(200) not null; 

/*
alter table companies add constraint not null(company_name);

alter table companies modify column company_name not null;

ALTER TABLE customers
CHANGE COLUMN number_of_complaints number_of_complaints INT DEFAULT 0;
*/

## company_name을 varchar(200), null로 변경




## employees database 선택
use employees;



## first_name, last_name 출력
select first_name, last_name from employees;



## first_name이  'Denis'인 데이터 출력
select * from employees where first_name = 'Denis';


    
# 이름이 'Denis' 이고 남성인 데이터 출력
select * from employees where first_name = 'Denis' and gender = 'M';



## 이름이 'Denis' 또는  'Elvis'인 데이터 출력
select * from employees where first_name = 'Denis' or first_name = 'Elvis';



## 이름이 'Cathie' , 'Mark', 'Nathan'에 해당하는 row출력 - in 사용
select * from employees where first_name in ('Cathie', 'Mark', 'Nathan');



## 이름이 'Cathie' , 'Mark', 'Nathan'에 해당하지 않는 row출력
select * from employees where first_name not in ('Cathie', 'Mark', 'Nathan');



## 이름이 Mar로 시작하는 row출력
select * from employees where first_name like 'Mar%';



## 이름이 ar로 끝나는 row출력
select * from employees where first_name like '%ar';



## 이름이 Mar로 시작하고 4글자인 row출력
select * from employees where first_name like 'Mar_';
select * from employees where first_name like 'Mar%' and first_name like '____';




# 이름에 jack을 포한하는 row를 출력

select * from employees where first_name like '%jack%';

    

# hire_date이 '1990-01-01' 과 '2000-01-01' 사이인 row출력
select * from employees where hire_date between '1990-01-01' and '2000-01-01';
select * from employees where hire_date >= '1990-01-01' and hire_date <= '2000-01-01'; 


    
# salary가 66000과 70000 사이인 row출력
show tables; -- employee 테이블에 salary 정보가 포함되어있지않기때문에 어떤 테이블들이 있는지 먼저 보도록한다

select * from salaries;
select * from salaries where salary between 66000 and 70000;

 
# 이름이 null인 row출력

select * from employees where first_name is null;

 
 # 이름이 null이 아닌 row출력
select * from employees where first_name is not null;



    
# salary가 150000  이상인 데이터 출력
select * from salaries where salary >= 150000;


# 중복없는 title 데이터 출력

show tables;
select distinct(title) from titles;
 
    
# 사원번호 갯수를 출력

show tables;
select * from employees;
select count(*) from employees;
select count(distinct(emp_no)) from employees;


# 중복없는 이름의 갯수 출력
select * from employees;
select count(distinct(first_name)) from employees;


# 연봉 100000이상인 사람의 총 수
select count(salary ) from salaries where salary > 100000;



# 메니저인 사람의 총 수 출력
select count(distinct(emp_no)) from dept_manager;



# 성울 선순위, 이름을 차순위로 내림차순 정렬
select last_name, first_name from employees order by last_name, first_name ;



# 연봉 상위 100명  출력
select emp_no from salaries order by salary desc limit 100;



#중복 이름이 100 이상인 이름 목록 출력
select first_name, count(first_name) from employees group by first_name having (count(first_name) >= 100) ;




# 평균 연봉이 120000 이상인 직원 번호와 평균 임금 출력
select emp_no, avg(salary) from salaries group by emp_no having avg(salary) >= 120000;
select * from salaries;


# 중복 이름이 200번 이상인 사람의 이름과 중복된 이름의 갯수 출력

select first_name, count(first_name) from employees group by first_name having count(first_name) >= 200;



## departments에서 dept_no가 'd010'인 데이터의 dept_name을 'data analysis'로 수정하시오

update departments set dept_name = 'data analysis' where dept_no = 'd010'; 


    
## employees 테이블에서 emp_no가 999903인 데이터를 삭제하시오
delete from employees where emp_no = '999903';



## departments에서 dept_no가 'd010'인 데이터를 삭제하시오

delete from departments where dept_no = 'd010';


