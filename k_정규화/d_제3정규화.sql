

# 제 3정규화 
# : 정규화의 세 번째 단계 
# - 2NF를 만족하는 테이블에서 모든 비기본 속성이 기본키에만 함수적으로 종속 
# > 이행적 종속성 
# : 어떤 속성 A가 다른 속성 B에 종속되고 
# B가 다른 속성 C에 종속된 경우 
# A가 C에 이행적으로 종속됨 

# 제3정규형의 핵심 조건 
# : 이행적 종속성을 제거하는 것 

/*
학번 이름 학과 학과명 학과위치 

기본키 : 학번 
비기본 속성: 이름 학과 학과명 학과 위치 

함수 종속 관계 
학번 > 학과 ID 
학과 ID > 학과명 , 학과 위치 

이행적 종속 
학번 > 학과ID > 학과명 , 학과 위치 

*/

DROP DATABASE IF EXISTS `normal`;
CREATE DATABASE IF NOT EXISTS `normal`;

USE `normal`;
CREATE TABLE `department` (
department_id int primary key,
department_name varchar(100),
location varchar(100)
);

CREATE TABLE `student` (
student_id int primary key,
name varchar(50),
department_id int,
foreign key (department_id) references department(department_id)
);

INSERT INTO department
VALUES
(101, '컴공', '서울'),
(102, '통계', '서울');

INSERT INTO student
VALUES
(1, '최강섭', 101),
(2, '손태경', 101),
(3. '박현우', 102);

SELECT * FROM department;
SELECT * FROM student;

SELECT 
S.student_id, S.name, D.department_name, D.location 
FROM
student S
join department D
on S.department_id = D.department_id;

# 제3정규화 장점 
# 1) 중복 제거로 저장 공간 절약 
# 2) 데이터 일관성 유지 가능 
# 3) 삽입 갱신 삭제 이상 방지 
# 4) 테이블 간 명확한 관계 형성 

# 제3정규화 모범 사례 
# 서로 다른 종류의 정보를 따로 담어야 안전 
# 무조건인 정규화는 오히려 효율성 저하 
# 경우에 따라 반정규화 























