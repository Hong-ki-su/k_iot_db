
# : 한 데이터 타입을 다른 데이터 타입으로 바꾸는 것 
USE `market_db`;

# 1) 명시적 형 변환 
# case 값 as 데이터형식 
# convert 값, 데이터형식 
# >> 두 문법을 형식만 다르고 기능은 동일 

 
# cf) 형 변환 시 정수형 데이터 타입 
# >> singed, unsigned만 사용가능 
# _ singed: 부호가 있는 정수 양수,음수 모두 사용가능 
# - unsigned: 부호가 없는 정수 

select * from buy;
 avg(price) as '평균가격',
 cast(avg(price) as unsigned) '정수 평균 가격', 
 convert(avg(price), unsigned) '정수 평균 가격',

from 
	buy; 
    -- 날짜 형 변환 
    # date 타입: yyyy-mm-dd 
    # MySQL은 문자형식을 자동으로 분석하여 YYYY-MM-DD 형식으로 변환 
    # cf) 형식이 너무 벗어나는 경우 오류 발생 
    
    select cast('2025$07$31' as Date);
    select cast('2025@07!31' as Date);
    select cast('2025&07&31' as Date);
    select cast('2025_07_31' as Date);
    
    select convert('07/31/2025', Date); 
    
    # cast SQL 표준 
    # convert: MySQL 고유 문법 
    
    ## 2) 목시적 형 변환 
    # : 자동으로 데이터를 변환하는 것 
    select '100' + '200'; 
    
    select concat('100', '200');
    
    
    
    
    
    
    
    
    
    
    
    
    


