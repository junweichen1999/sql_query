create database sql_practice;
use sql_practice;

select * from student;
select * from sc;
select * from teacher;
select * from course;



create table student(
 sno varchar(10) primary key,
 sname varchar(20),
 sage int(2), 
 ssex varchar(5)
);

create table teacher(
 tno varchar(10) primary key, 
 tname varchar(20)
);

create table course(
 cno varchar(10),
 cname varchar(20), 
 tno varchar(20), 
 constraint pk_course primary key (cno,tno)
);


create table sc(
 sno varchar(10),
 cno varchar(10), 
 score float(4,2),
 constraint pk_sc primary key (sno,cno)
);
show warnings;
show tables;

/* 插入學生資料*/
insert into student values ('s001','張三',23,'男');
insert into student values ('s002','李四',23,'男');
insert into student values ('s003','吳鵬',25,'男');
insert into student values ('s004','琴沁',20,'女');
insert into student values ('s005','王麗',20,'女');
insert into student values ('s006','李波',21,'男');
insert into student values ('s007','劉玉',21,'男');
insert into student values ('s008','蕭蓉',21,'女');
insert into student values ('s009','陳蕭曉',23,'女');
insert into student values ('s010','陳美',22,'女');
insert into student values ('s011','王麗',24,'女');
insert into student values ('s012','蕭蓉',20,'女');
insert into student values ('s013','王張蓉',30,'女');
select * from student;

/* 插入老師資料*/
insert into teacher values ('t001', '劉陽');
insert into teacher values ('t002', '諶燕');
insert into teacher values ('t003', '胡明星');
select * from teacher;

/* 插入課表資料*/
insert into course values ('c001','J2SE','t002');
insert into course values ('c002','Java Web','t002');
insert into course values ('c003','SSH','t001');
insert into course values ('c004','Oracle','t001');
insert into course values ('c005','SQL SERVER 2005','t003');
insert into course values ('c006','C#','t003');
insert into course values ('c007','JavaScript','t002');
insert into course values ('c008','DIV+CSS','t001');
insert into course values ('c009','PHP','t003');
insert into course values ('c010','EJB3.0','t002');
select * from course;


/* 插入成績資料*/
insert into sc values ('s001','c001',78.9);
insert into sc values ('s002','c001',80.9);
insert into sc values ('s003','c001',81.9);
insert into sc values ('s004','c001',50.9);
insert into sc values ('s005','c001',59.9);
insert into sc values ('s001','c002',82.9);
insert into sc values ('s002','c002',72.9);
insert into sc values ('s003','c002',82.9);
insert into sc values ('s001','c003',59);
insert into sc values ('s006','c003',99.8);
insert into sc values ('s002','c004',52.9);
insert into sc values ('s003','c004',20.9);
insert into sc values ('s004','c004',59.8);
insert into sc values ('s005','c004',50.8);
insert into sc values ('s002','c005',92.9);
insert into sc values ('s001','c007',78.9);
insert into sc values ('s001','c010',78.9);
select * from sc;

/*以下為練習題*/


/* 1. 查詢學生表的 前10條資料 */
select * from student join sc 
on student.sno = sc.sno 
order by  score desc
limit 10;

/*2. 查詢成績表所有成績的最低分,平均分,總分*/
select min(score) 最低分, avg(score) 平均分, sum(score) 總分 from sc;

/*3. 查詢老師 “諶燕” 所帶的課程設數量*/
select * from course;
select * from teacher;
/*testing*/
select * from course left outer join teacher
on course.tno = teacher.tno;

select count(cno) 諶燕帶課數量 from course left outer join teacher
on course.tno = teacher.tno
where tname = "諶燕";

/*4.查詢所有老師所帶 的課程 數量*/
select count(course.cno) 教課數量 ,tname 教師名稱 from course left outer join teacher
on course.tno = teacher.tno
group by teacher.tno;
show warnings;

/*5. 查詢姓”張”的學生名單*/ 
select * from student where sname like '張%'; 

/*6. 查詢課程名稱為'Oracle'且分數低於60 的學號和分數 */
select sc.sno 學號, sc.score 分數, student.sname 抓起來打 from sc 
join student on sc.sno = student.sno
join course on sc.cno = course.cno 
where course.cname = "Oracle" and sc.score<60;

/*7.查詢所有學生的選課 課程名稱*/
/*注意left join right join的使用*/
select student.sname, course.cname from sc 
right join student on sc.sno = student.sno
left join course on sc.cno = course.cno;
show warnings;

/*8.查詢任何一門課程成績在70 分以上的學生姓名.課程名稱和分數 */
select student.sname 姓名, course.cname 課堂名稱, sc.score 分數 from sc 
join student on sc.sno = student.sno
join course on sc.cno = course.cno
where sc.score > 70;


/*9. 查詢不及格的課程,並按課程號從大到小排列 學號,課程號,課程名,分數*/
select student.sno 學號, course.cno 課程號, course.cname 課程名, sc.score 成績, student.sname 姓名 from sc
join student on sc.sno = student.sno 
join course on sc.cno = course.cno 
where sc.score < 60
order by course.cno desc;


/*10. 查詢沒學過”諶燕”老師講授的任一門課程的學號,學生姓名 */
select sc.sno 學號, student.sname 姓名 from sc
right join student on sc.sno = student.sno 
join course on sc.cno = course.cno 
right join teacher on course.tno = teacher.tno
where teacher.tname != "諶燕"
group by student.sno;

/*testing*/
select * from sc
right join student on sc.sno = student.sno 
join course on sc.cno = course.cno 
join teacher on course.tno = teacher.tno; 
show warnings;


/*11. 查詢兩門以上不及格課程的同學的學號及其平均成績*/

select count(sc.sno) > 1 多於一科不及格, avg(sc.score) 平均成績, sc.sno 學號 from sc
join course on sc.cno = course.cno
where sc.score < 60
group by sc.sno;

select count(sc.sno) > 1 多於一科不及格, avg(sc.score) 平均成績, sc.sno 學號 from sc
join course on sc.cno = course.cno
where sc.score < 60 
group by sc.sno
having count(sc.sno) >1 ; 

select concat(count(sc.sno) > 1,"     /1 = yes, 0 = no") 多於一科不及格, avg(sc.score) 平均成績, sc.sno 學號 from sc
join course on sc.cno = course.cno
where sc.score < 60 
group by sc.sno
having count(sc.sno) >1 ; 

show warnings;

/*12. 檢索'c004'課程分數小於60,按分數降序排列的同學學號*/
select student.sno, sc.score from sc 
join student on sc.sno = student.sno
where cno = "c004"
having sc.score < 60
order by sc.score desc;


/*13. 查詢'c001'課程比'c002'課程成績高的所有學生的學號 (尚未解決)*/
select sc.score from sc 
join student on sc.sno= student.sno
where sc.cno="c001"
group by sc.sno 
;

select sc.score from sc 
join student on sc.sno= student.sno
where sc.cno="c002" 
group by sc.sno
;

/*正解*/
select sc1.sno 
from sc sc1, sc sc2
where sc1.sno = sc2.sno 
and sc1.cno="c001" and sc2.cno="c002" 
and sc1.score > sc2.score; 

select * from sc as sc1
join sc as sc2 on sc1.sno = sc2.sno
join student on sc1.sno = student.sno
where (select max(sc.score) from sc 
	join student on sc.sno= student.sno
	where sc.cno="c001"
	group by sc.sno ) > 
	(select max(sc.score) from sc 
	join student on sc.sno= student.sno
	where sc.cno="c002" 
	group by sc.sno
	);

SELECT a.sno FROM sc a,sc b
WHERE a.sno = b.sno AND a.cno='c001' AND b.cno='c002' AND a.score > b.score;

show warnings;

select * from sc
where cno="c001" or cno="c002"
having c001.score > c002.score;


/*14.查詢平均成績大於60 分的同學的學號和平均成績 */
select avg(sc.score) ,student.sname, student.sno from sc 
join student on sc.sno = student.sno
group by student.sno
having avg(sc.score) > 60;
/*後記: group by 後面如果沒有應用到 select 後面就不能寫 因為沒有應用到聚合函數內 */


show warnings;


/*15.查詢所有同學的學號.姓名.選課數.總成績 */
select count(course.cno) 選課數, student.sname 姓名, sum(sc.score) 總成績 , avg(sc.score) 平均成績 from sc 
right join student on sc.sno = student.sno
join course on sc.cno = course.cno
group by sc.sno; 

/* 16. 查詢姓”劉”的老師的個數*/
select count(*) 姓劉的老師數量 from teacher
where tname like "劉%";

/*17. 查詢只學”諶燕”老師所教的課的同學的學號:姓名*/
select distinct student.sno 學號 , student.sname 學生姓名 , teacher.tname 授課老師 from sc 
join student on sc.sno = student.sno
join course on sc.cno = course.cno
join teacher on course.tno = teacher.tno
where tname = "諶燕" 
-- having count(teacher.tname)=1
;
show warnings;

/*(尚未解決)18. 查詢學過”c001″並且也學過編號”c002″課程的同學的學號.姓名(解答一半)*/
select * from sc 
join student on sc.sno = student.sno
-- group by student.sno-- 
where sc.sno = "s001" or sc.sno = "s002"
;

/*經過上面的 顯示出他要的但並不是正解*/
select distinct student.sno, student.sname from sc 
join student on sc.sno = student.sno
-- group by student.sno-- 
where sc.sno = "s001" or sc.sno = "s002"
;

show warnings;

/*19.查詢學過”諶燕”老師所教的所有課的同學的學號:姓名 17 & 19其中一個需要被調整*/
select distinct student.sno 學號 , student.sname 學生姓名 , teacher.tname 授課老師 from sc 
join student on sc.sno = student.sno
join course on sc.cno = course.cno
join teacher on course.tno = teacher.tno
where tname = "諶燕"
;

/*20. 查詢課程編號”c004″的成績比課程編號”c001″和”c002″課程低的所有同學的學號.姓名*/

select distinct sc1.sno from sc sc1, sc sc2, sc sc3
where sc1.sno = sc2.sno = sc3.sno 
and sc1.cno = "c004" and sc2.cno="c001" and sc3.cno="c002"
and sc1.score < sc2.score and sc1.score < sc3.score; 


SELECT a.sno FROM sc a,sc b,sc c
WHERE a.sno = b.sno AND b.sno = c.sno 
AND a.cno='c001' AND b.cno='c004' AND c.cno='c002' 
AND a.score > b.score AND c.score > b.score;



/*21. 查詢所有課程成績小於60 分的同學的學號.姓名*/
select student.sno, student.sname from sc
join student on sc.sno= student.sno
where sc.score < 60;

/*22. 查詢沒有學課的同學的學號.姓名(有看答案的思考邏輯)*/
select sno, sname from student
where sno not in (SELECT DISTINCT sno FROM sc)
;
/*所有修課的表*/
SELECT DISTINCT sno FROM sc;


/*23.查詢與學號為”s001″一起上過課的同學的學號和姓名 */
select cno from sc 
join student on sc.sno= student.sno
where sc.sno="s001";

select distinct student.sno as 學號 , student.sname as 姓名 from sc 
join student on sc.sno= student.sno
where sc.cno in
(select cno from sc 
join student on sc.sno= student.sno
where sc.sno="s001");

show warnings;

/*24. 查詢跟學號為”s005″所修課程完全一樣的同學的學號和姓名*/
select cno from sc
join student on sc.sno= student.sno
where student.sno="s005";

select cno from course; 

select sc.sno from sc
join student on sc.sno= student.sno
where sc.cno = "c001" or sc.cno="c004"
group by sc.sno
;

select sc.sno, student.sname from sc
join student on sc.sno= student.sno
where sc.cno not in ("c002","c003","c005","c006","c007","c008","c009","c010")
group by sc.sno
;
/*我的正解*/
select sc.sno, student.sname from sc
join student on sc.sno= student.sno
where sc.cno in (select cno from sc
join student on sc.sno= student.sno
where student.sno="s005")
group by sc.sno
;
show warnings;

/*25. 查詢各科成績最高和最低的分 顯示:課程ID,最高分,最低分*/
select cno 課程編號 ,max(score) 最高分 ,min(score)  最低分 from sc 
group by cno;


/*26.按各科平均成績和及格率的百分數 照平均從低到高顯示 */
select avg(score),cno,(count(score > 60)/count(*)) 不確定是否為真的及格率 from sc
group by cno
order by avg(score) ;

select avg(score),cno from sc
group by cno;

select (count(score > 60)/count(*)),cno from sc
group by cno;

/*27.查詢每個課程的老師及平均分從高到低顯示 老師名稱,課程名稱,平均分數*/
select avg(sc.score),sc.cno,max(teacher.tname) from sc
join course on sc.cno = course.cno
join teacher on course.tno = teacher.tno
group by sc.cno
order by avg(sc.score) desc;
show warnings;

/*(完全不會)28.統計列印各科成績,各分數段人數:課程ID,課程名稱,verygood[100-86], good[85-71], bad[<60]*/
declare @verygood INT, @good INT, @bad INT;
show warnings;

/*
select 
count(
	case when score > 86
    then 
) as verygood people
from sc
group by cno;
*/

/*(半完成)29. 查詢各科成績前三名的記錄:(不考慮成績並列情況)*/
select sc1.cno, sc1.sno, sc1.score from sc sc1, sc sc2,sc sc3
group by sc1.cno, sc1.sno
order by sc1.cno;


show warnings;
select distinct cno from sc;

/*30 查詢每門課程被選修的學生數*/
select count(sc.sno) 選課人數,course.cname,course.cno from sc 
join course on sc.cno = course.cno
group by course.cno, course.cname;


/*31.查詢出只選修了兩門課程的全部學生的學號和姓名 */
select student.sno, student.sname,count(sc.cno) from sc
join student on sc.sno = student.sno
group by student.sno
having count(sc.cno)=2;

/*32查詢男生.女生人數*/
select count(ssex) from student
group by ssex; 

/*(沒有完成  好難)32-1. 查詢每個課程的男生女生總數*/
select cno, count(a.ssex),count(b.ssex)  from sc 
join student a on sc.sno = a.sno
join student b on sc.sno = b.sno
where a.ssex ="男" and b.ssex="女"
group by cno;

select* from student ;

SELECT b.cno 
FROM sc b 
JOIN student ON b.sno = student.sno
GROUP BY b.cno;

show warnings;


/*33. 查詢同名同姓學生名單,並統計同名人數*/
select * from student s1, student s2
where s1.sname = s2.sname and s1.sno <> s2.sno;

select sname, count(*) from student
group by sname
having count(sname)>1;

SELECT sname,COUNT(*) FROM student x 
GROUP BY sname
HAVING COUNT(*)>1;

/*34.查詢年紀最小跟最大的學生名單(注:Student 表中Sage 列的型別是int) */
select sno,sage,sname from student
where sname =(select sname from student
group by sno
order by sage desc
limit 1)
or sname = (select sname from student
group by sno
order by sage 
limit 1)
;

select sname,sage from student
group by sno
order by sage desc
limit 1;

select sname,sage from student
group by sno
order by sage 
limit 1;


/*35.查詢每門課程的平均成績,結果按平均成績升序排列,平均成績相同時,按課程號降序排列 */
select avg(sc.score),sc.cno from sc 
join course on sc.cno = course.cno
group by sc.cno
order by avg(sc.score) ,sc.cno desc;

/*36.查詢平均成績大於85 的所有學生的學號.姓名和平均成績 */
select student.sno, student.sname, avg(sc.score)  from sc 
join student on sc.sno = student.sno
group by student.sno
having avg(sc.score) >85;


/*37. 查詢課程編號為c001 且課程成績在80 分以上的學生的學號和姓名*/
select * from sc 
join student on sc.sno = student.sno
where sc.cno = "c001" and sc.score>80;


/*38.檢索每課程第二高分的學號 分數(考慮成績並列) */
select * from sc a, sc b
;
select sc.cno, sc.score from sc 
join student on sc.sno= student.sno
group by sc.cno, sc.score
order by sc.cno desc;

SELECT *
FROM (SELECT * FROM sc GROUP BY score,cno)AS sca
WHERE (SELECT COUNT(*) FROM (SELECT * FROM sc GROUP BY score,cno)AS scb WHERE sca.cno=scb.cno AND sca.score < scb.score)=1
ORDER BY cno;

select * from sc join student on sc.sno= student.sno
group by sc.cno;
/*全部的 做高到低的排列   我覺得把她帶到group by cno就可以運作*/
select * from sc join student on sc.sno= student.sno
order by sc.score desc;

/*(好像錯了 但我以為是對的)39.求選了課程的學生人數*/
select sno  from sc 
group by sno;

select distinct count(*) from sc 
right join student on sc.sno = student.sno
where sc.sno not in (select  cno  from sc 
group by cno);

select count(*) from student
join sc on student.sno= sc.sno 
group by student.sno
having count(sc.cno)>1;

SELECT COUNT(*)
FROM (SELECT DISTINCT sno FROM sc)AS scount;

/*40 查詢選修”諶燕”老師所授課程的學生中,成績最高的學生姓名及其成績*/
select * from sc 
join student on sc.sno = student.sno
join course on sc.cno = course.cno
join teacher on course.tno = teacher.tno
where teacher.tname = "諶燕";

/*. 最高分有兩筆*/
select * from sc 
join student on sc.sno = student.sno
join course on sc.cno = course.cno
join teacher on course.tno = teacher.tno
where teacher.tname = "諶燕"
order by sc.score desc
limit 2;

/*41.(需要用到 self join ) 查詢不同課程成績有相同的學生的學號.課程號.學生成績*/
select * from sc;
select * from student;
select * from teacher;
select * from course;


select student.sno from sc sc1
join sc sc2 on sc1.sno= sc2.sno
join student on sc1.sno = student.sno
group by student.sno
;


show tables;

select * from sc 
join student on sc.sno = student.sno
group by sc.cno;

/*42. 所有課程排名成績(不考慮並列) 學號,課程號,排名,成績 照課程,排名排序*/
select * from sc join student on sc.sno = student.sno;


/*43.所有課程排名成績(考慮並列) 學號,課程號,排名,成績 照課程,排名排序 */

/*44. 做所有學生顯示學生名稱,課程名稱,成績,老師名稱的視圖*/
select student.sname, teacher.tname, sc.score, course.cname from sc 
join student on sc.sno= student.sno
join course on sc.cno= course.cno
join teacher on course.tno = teacher.tno
order by student.sno;

/*45. 查詢上過所有老師教的課程的學生 學號,學生名*/
select tname from teacher;

select student.sno from sc 
join student on sc.sno = student.sno
join course on sc.cno = course.cno
join teacher on course.tno = teacher.tno
group by student.sno 
having teacher.tname in (select teacher.tname from teacher);
show warnings;
use sql_practice;

select tno from teacher;

select sc.sno, GROUP_CONCAT(course.tno)  from sc 
join student on sc.sno = student.sno 
join course on sc.cno = course.cno
join teacher on course.tno = teacher.tno
group by sc.sno
having GROUP_CONCAT(distinct course.tno) = (select group_concat(distinct tno) from teacher)
;

select group_concat(distinct tno) from teacher;
select tno from teacher;

select * from course;
show warnings;

/*46. 查詢包含數字的課程名*/
select * from course where cname regexp '[0-9]';

/*47. 查詢只有英文的課程名*/
select cname from course
where cname regexp '\\S' and cname not regexp '[0-9]';



/*48. 查詢所有學生的平均成績 並排名 , 學號,學生名,排名,平均成績(不考慮並列) 對平均成績高到低及學號低到高排序*/
select avg(sc.score), student.sno, student.sname ,
ROW_NUMBER() OVER(order by avg(sc.score) desc) as 成績排名
from sc 
join student on sc.sno = student.sno
group by sc.sno
order by avg(sc.score) desc;


/* 因為 row num沒有辦法用average score這個別名，因為sql的執行順序的問題
所以用仔查詢解決但我看的頭很痛所以直接上面的寫法 作用一樣但欄位標題不一樣*/
SELECT 
    average_score,
    sno,
    sname,
    ROW_NUMBER() OVER(ORDER BY average_score DESC) AS 成績排名
FROM (
    SELECT 
        AVG(sc.score) AS average_score,
        student.sno,
        student.sname
    FROM 
        sc 
    JOIN 
        student ON sc.sno = student.sno
    GROUP BY 
        sc.sno, student.sno, student.sname
) AS subquery
ORDER BY 
    average_score DESC;


show warnings;
show databases;
use sql_practice;

/*49. 查詢所有學生的平均成績 並排名 , 學號,學生名,排名,平均成績(考慮並列) 對平均成績高到低及學號低到高排序*/


/*50. 查詢課程有學生的成績是其他人成績兩倍的學號 學生名*/


select sc1.sno from sc sc1
join student on sc1.sno= student.sno
join sc sc2 on sc1.sno = sc2.sno
where sc1.sno <> sc2.sno
group by student.sno
having sc1.score = (sc2.score*2);


