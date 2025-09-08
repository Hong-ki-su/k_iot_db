### c_ddl >> e_ddl실습답안 ###

-- 🔹 [문제 1] 데이터베이스 생성 및 선택
-- 	데이터베이스 생성: baseball_league
CREATE DATABASE `baseball_league`;

-- 	해당 데이터베이스를 사용 지정 
USE `baseball_league`;

-- 🔹 [문제 2] 팀 정보 테이블 생성
-- 	테이블 생성: teams 

-- 		컬럼명			데이터 타입			설명
-- 		team_id			INT				팀 고유 번호
-- 		name			VARCHAR(100)	팀 이름
-- 		city			VARCHAR(100)	연고지
-- 		founded_year	YEAR			창단 연도 (YYYY 형식)

-- ⚠️ 유의사항: 각 컬럼 선언 뒤에는 쉼표(,)를 적절히 사용하고, 마지막 컬럼 뒤에는 콤마를 쓰지 마세요.
CREATE TABLE `teams` (
	# 컬럼명 데이터타입 옵션
    team_id INT,
    name VARCHAR(100),
    city VARCHAR(100),
    founded_year YEAR
);

-- 🔹 [문제 3] 선수 정보 테이블 생성
-- 	players라는 테이블을 생성 (이미 존재하지 않을 경우에만 생성)

-- 	아래와 같은 구조로 생성:

-- 		컬럼명			데이터 타입								설명
-- 		player_id		INT									선수 고유 번호
-- 		name			VARCHAR(100)						선수 이름
-- 		position		ENUM('타자', '투수', '내야수', '외야수')	선수 포지션

CREATE TABLE IF NOT EXISTS `players` (
	player_id INT,
    name VARCHAR(100),
    position ENUM('타자', '투수', '내야수', '외야수')
);

-- 🔹 [문제 4] 테이블 구조 확인
-- 	teams 테이블과 players 테이블의 구조를 확인하는 SQL문을 각각 작성
DESCRIBE `teams`;
DESC `players`;

-- 🔹 [문제 5] 테이블 구조 수정
-- 	players 테이블에 birth_date 컬럼을 날짜형(DATE) 으로 추가

# alter table 테이블명 [add | modify | drop] (column) 컬럼명 데이터타입;
alter table `players`
add birth_date DATE;

-- 	변경 후 players 테이블의 구조를 다시 확인
DESC `players`;

-- 🔹 [문제 6] 테이블 삭제
-- 	games 테이블과 players 테이블 삭제 (존재할 경우에만)
drop table if exists `games`;
drop table if exists `players`;

-- 🔹 [문제 7] 데이터베이스 삭제
-- 	baseball_league 데이터베이스 삭제
drop database `baseball_league`;