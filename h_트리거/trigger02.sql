

## 트리거 예제 
USE `market_db`;

# singer 테이블: member 테이블에서 데이터 추출 
create table if not exists `singer` (
select mem_id, mem_name, mem_number, addr 
from 
`member`
);

select * from `singer`;

create table `backup_singer` (
mem_id char(8) not null,
mem_name varchar(10) not null, 
mem_number int not null,
addr char(2) not null,

modType char(2),
modDate date,
modUser varchar(30)
);

-- 변경이 발생했을 때 작동하는 트리거 
drop trigger if exists singer_updateTrg;

delimiter $$ 
create trigger singer_updateTrg
after update
on singer 
for each row 
begin 
insert into backup_singer 
values 
(
ORD.mem_id, ORD.mem_name, ORD.mem_number, ORD.arr, '수정', curdate(), current_user()
);
end $$

delimiter ;

# ORD 테이블
# : Update 또는 delete가 수행될 때 
# 변경 | 삭제 전의 데이터가 잠깐 저장되는 임시 테이블 

select current_user();

update `singer`
set 
addr = '미국'
where 
mem_id = 'BLK';











