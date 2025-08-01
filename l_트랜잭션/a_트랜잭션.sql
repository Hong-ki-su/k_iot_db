

## 1. 트랜잭션 개요 
# : 데이터베이스에서 하나의 논리적인 작업 단위를 의미 
# : 여러 개의 작업이 한 번에 처리되어야 할 때 사용 
# > 중간에 하나라도 실패하면 전체 작업을 취소 
# > 모든 작업이 문제없이 완료되면 확정 

## 2. 트랜잭션 목적 
# : 여러 개의 SQL 작업을 하나의 작업처럼 묶어서 처리 
# > 데이터의 일관성과 신뢰성을 보장 

# EX) A가 B에게 돈을 송금하는 경우 
# A 계좌에서 출금 + B 계좌에 입금 

## 3. 트랜잭션 4가지 특징 
# atomicity 원자성 : 트랜잭션 내 모든 작업은 모두 성공 | 모두 실패 중 하나 
# consistency : 트랜잭션 전 후 데이터베이스의 일관성 유지 
# Isolation : 동시에 여러 트랜잭션이 실행되어도 서로 간섭하지 않음 
# Durability : 트랜잭션 성공시 결과는 영구적으로 보존 

/*
4. 트랜잭션 실행 흐름 
1) 트랜잭션 시작 - START TRANSACTION;
2) SQL 명령어 실행 - INSERT UPDATE DELETE 등 
3) 문제 없이 완료되면 - COMMIT
4) 중간에 오류 발생시 또는 취소시 - ROLLBACK;

start transaction;

# start 이후 블럭 내의 명령어는 하나의 명령어처럼 처리 
>> 성공 

update account 
set balance = balance 
where account_id = A 

update account 
set balance 

cf) savepoint: 트랜잭션 내 특정 지점 저장 해당 지점에서 

*/

drop database if exists `트랜잭션`;
create database if not exists `트랜잭션`;
use `트랜잭션`;

create table `members` (
member_id int primary key,
member_name varchar(50),
member_age int
);

create table `purchases` (
purchase_id int primary key,
member_id int,
product_name varchar(100),
price int,
foreign key (member_id) references members(member_id)
);

-- 트랜잭션 상태 확인 
select @@autocommit; 
# > 1 자동 커밋이 활성화 된 상태 
# INSERT UPDATE DELETE 쿼리 실행 직후 자동 COMMIT 됨 
# - 실패가 없으면 자동 저장됨 
# > 0 자동 커밋 비활성화 된 상태 
# 트랜잭션은 START TRANSACTRION  또는 DML 문으로 시작 
# COMMIT 또는 ROLLBACK을 직접 호출 

start transaction;

insert into members
values
(1, '권지혜', 25);

insert into purchases
values
(1, 2, '노트북', 200); -- 외래키 제약 조건 오류 

commit;

select * from members;
select * from purchases;
 
## 스토어드 프로시저 사용 예시 
# : 트랜잭션 쿼리를 전체 동시 실행 

delimiter $$ 

create procedure insert_member_and_purchase()
begin 
declare exit handler for sqlexception
begin 
rollback;
select '트랜잭션 롤백: 오류 발생으로 모든 변경이 취소되었습니다.' AS message;
end;

start transaction;

insert into members
values
(101, '권지혜', 25);

insert into purchases
values
(1234,999, '노트북', 200);

commit;

select '트랜잭션 커밋: 모든 데이터가 성공적으로 저장되었습니다.' AS message;
end $$

delimiter ; 

call insert_member_and_purchase();
select * from `members`;

## 
create table `accounts` (
account_id int primary key auto_increment,
account_holder varchar(50),
balance int unsigned 
);

create table transaction_log (
transaction_id int primary key auto_increment,
from_account_id int,
to_account_id int,
amount int,
transaction_date datetime default current_timestamp,
foreign key (from_account_id) references accounts(account_id),
foreign key (to_account_id) references accounts(account_id)
);

insert into accounts (account_holder, balance)
values
('김동후', 50000),
('김지선', 40000);

delimiter $$

create procedure transfer_money() 
begin
declare from_balance int;

set autocommit = 0;

start transaction;

select balance into from_balance
from accounts
where 
account_holder = '김지선';

if from_balance >= 1000 then 
update accounts
set balance = balance - 1000
where 
account_holder = '김지선';

update accounts
set balance = balance + 10000 
where
account_holder = '김동우';

insert into transaction_log (from_account_id, to_account_id, amount)
values
(
(select account_id from accounts where account_holder = '김지선'), 
(select account_id from accounts where account_holder = '김동우'),
10000
);
commit;
else 
rollback;
end if;
end $$

delimiter ;
call transfer_money();

select * from accounts;
select * from transaction_log;

# if 조건문 벗어나면 실행된 이체된 내역 ROLLBACK 취소 
# > 잔고가 10000원 

















