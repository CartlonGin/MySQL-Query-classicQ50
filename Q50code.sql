#SQL_Q50 Practice
#Q1 查詢”01"課程比”02"課程成績高的學生的資訊及課程分數
select s.Sid, s.Sname, s.Sage, s.Ssex, Q1.C1, Q1.C2
from Student as s
right join(
    select a.Sid, a.s_score as C1, b.s_score as C2
	from (select Sid, Cid, s_score from score where Cid = '01') as a,
		 (select Sid, Cid, s_score from score where Cid = '02') as b
	where a.s_score > b.s_score and a.Sid = b.Sid
) as Q1
on s.Sid = Q1.Sid;

#Q2 查詢同時存在" 01 "課程和" 02 "課程的情況
select Student.*, C1, C2
from Student 
right join(
    select a.Sid, a.Cid as C1, b.Cid as C2
	from (select * from score where Cid = '01') as a,
		 (select * from score where Cid = '02') as b
	where a.Sid = b.Sid
) as Q2
on Student.Sid = Q2.Sid;

#Q3 查詢存在" 01 "課程但可能不存在" 02 "課程的情況(不存在時顯示為 null)
select s1.Sid, s1.Cid, s1.s_score as s1s, s2.Cid, s2.s_score as s2s
from 
	(select * from score where Cid='01') as s1 
	left join (select * from score where Cid='02') as s2 
on s1.Sid = s2.Sid;
    
#Q4 查詢不存在" 01 "課程但存在" 02 "課程的情況
select student.*, Q4.Cid, Q4.s_score
from student 
     inner join(
     select * from score where Cid = '02' and Sid not in (select Sid from score where Cid = '01')
     ) as Q4
on student.Sid = Q4.Sid;

#Q5 查詢平均成績大於等於60分的同學的學生編號和學生姓名和平均成績
select student.Sid, student.sname, avg(s_score) 
from Score inner join student on Score.Sid = student.Sid
group by Sid
having avg(s_score) >= 60;

#Q6 查詢在SC表存在成績的學生資訊
select distinct student.*
from Student, Score
where Student.Sid = Score.Sid;

#Q7 查詢所有同學的學生編號、學生姓名、選課總數、所有課程的總成績(沒成績的顯示為 null)
select s.Sid, s.Sname, count(ss.Cid), sum(ss.s_score)
from Student as s
inner join Score as ss
on s.Sid = ss.Sid
group by Sid;

#Q8 查詢「李」姓老師的數量
select count(1)
from Teacher
where Tname like '李%';

#Q9 查詢學過「張三」老師授課的同學的資訊
select student.*
from Student 
inner join Score on Student.Sid = Score.Sid
inner join Course on Score.Cid = Course.Cid
inner join Teacher on Course.Tid = Teacher.Tid
where Teacher.Tname = '張三';

#Q10 查詢沒有學所有課程的同學的資訊
select Student.*
from student
where student.Sid not in(
	select Score.Sid
	from Score 
	group by Score.Sid
    having count(Score.Cid) = (select count(Cid) from course)
    );
    
#Q11 查詢至少有一門課與學號為"01"的同學所學相同的同學的資訊
select Student.*
from Student
where Student.Sid in(
	select Score.Sid
	from Score 
	where Score.Cid in(
		select Score.Cid
		from Score
		where Score.Sid = '01'
    )
) and Student.Sid <> '01';

#Q12 查詢和"01"號的同學學習的課程完全相同的其他同學的資訊 ***
select Score.Sid, Sname, Sage, Ssex, group_concat(Cid) as total_c
from Score inner join Student on Score.Sid = Student.Sid
group by Sid
having group_concat(Cid) in
(
	select group_concat(Cid) as total_c
	from Score
    group by Sid
	having Sid = '01' #where會先於group by，所以要用分組後的當條件，就要用having
) and Sid <> '01';

#Q13 查詢沒學過"張三"老師講授的任一門課程的學生姓名
select *
from Student
where Sid not in(
	select Score.Sid from Score 
    inner join Course on Score.Cid = Course.Cid
	inner join Teacher on Course.Tid = Teacher.Tid
    where Tname = '張三'
);

#Q14 查詢兩門及其以上不及格課程的同學的學號，姓名及其平均成績
select Sid, Sname, avg(F_score)
from Student inner join
(	
	select s.Sid as F_Sid, sc.s_score as F_score
	from Student as s
	inner join Score as sc on s.Sid = sc.Sid
    where sc.s_score < 60
) as F
on Student.Sid = F_Sid
group by Sid
having count(F_score) >= 2;

#Q15 檢索"01"課程分數小於 60，按分數降序排列的學生資訊
select *
from Student inner join Score on Student.Sid = Score.Sid
where Cid = '01' and s_score < 60
order by s_score DESC;

#Q16 按平均成績從高到低顯示所有學生的所有課程的成績以及平均成績
select Sid, avg(s_score)
from Score
group by Sid
order by avg(s_score) DESC;

#Q17 查詢各科成績最高分、最低分和平均分：以如下形式顯示：課程 ID，課程 name，最高分，最低分，平均分，及格率，中等率，優良率，優秀率
#及格為>=60，中等為：70-80，優良為：80-90，優秀為：>=90
#要求輸出課程號和選修人數，查詢結果按人數降序排列，若人數相同，按課程號升序排列
select  c.Cid as ID, Cname as `Name`, count(s.Sid) as `選修人數`,
		max(s_score) as `MAX`, min(s_score) as `MIN`, avg(s_score) as `AVG`,
		sum(case when s_score >= 60 then 1 else 0 end)/count(*) as `及格率`,
        sum(case when s_score >=70 and s_score < 80 then 1 else 0 end)/count(*) as `中等率`,
        sum(case when s_score >=80 and s_score < 90 then 1 else 0 end)/count(*) as `優良率`,
        sum(case when s_score >=90 then 1 else 0 end)/count(*) as `優秀率`
from score as s
inner join course as c on s.Cid = c.Cid
group by c.Cid
order by count(*) DESC, c.Cid;

#Q18 按各科成績進行排序，並顯示排名，Score重複時保留名次空缺**** (OLAP function)
select a.Cid, a.Sid, a.s_score, count(b.s_score)+1 as `rank`
from score as a left join score as b on a.Cid = b.Cid and a.s_score < b.s_score
group by a.Cid, a.Sid
order by a.Cid, `rank` ASC;

select *, rank() over(partition by Cid order by s_score DESC) as `rank`
from score;

#Q19 按各科成績進行排序，並顯示排名， Score重複時合併名次**** (OLAP function)
select *, row_number() over(partition by Cid order by s_score DESC) as `rank`
from score;

#Q20 查詢學生的總成績，並進行排名，總分重複時保留名次空缺***
set @rank := 0;
select Q20.*, @rank := @rank +1 as `rank` 
from(
	select Sid, sum(s_score) as `sum`
	from score
	group by Sid
	order by `sum` desc
) as Q20;

set @curRank = 0,
	@preScore = NULL;

select 
	Sid, `sum`, `rank`
from
	(select t1.*, @curRank := if (`sum` = @preScore, @curRank, @curRank +1) as `Rank`, @preScore = `sum`
	from
		(select Sid, sum(s_score) as `sum`
		from score
		group by Sid
		order by `sum` desc
        ) as t1
	)as result;
    
#OLAP窗口函數***
select	Sid, sum(s_score), 
		rank() over(order by sum(s_score) desc) as `rank`
from score
group by Sid;
    
#Q21 查詢學生的總成績，並進行排名，總分重複時不保留名次空缺
set @currank := 1,
    @prescore := NULL,
    @totalrank := 1;
	
select 
		t.*,
		@currank := if (`sum` = @prescore, @currank, @totalrank) as `rank`, #這時的@prescore是前一個寫入的sum
		@prescore := `sum`, #寫入目前的sum
		@totalrank := @totalrank +1 #正常照順序1,2,3,4...
from 
		(select Sid, sum(s_score) as `sum`
		from score
		group by Sid
		order by `sum` DESC) as t;

#OLAP窗口函數
select  Sid, sum(s_score),
		dense_rank() over(order by sum(s_score) desc) as `rank`
from score
group by Sid;

#Q22 統計各科成績各分數段人數：課程編號，課程名稱，[100-85]，[85-70]，[70-60]，[60-0] 及所佔百分比
select 
s.Cid, c.cname,
sum(case when s_score > 85 and s_score <= 100 then 1 else 0 end) as `[100-85]`,
sum(case when s_score > 85 and s_score <= 100 then 1 else 0 end) / count(Sid)as `[100-85]pt`,
sum(case when s_score > 70 and s_score <= 85 then 1 else 0 end) as `[85-70]`,
sum(case when s_score > 70 and s_score <= 85 then 1 else 0 end) / count(Sid) as `[85-70]pt`,
sum(case when s_score > 60 and s_score <= 70 then 1 else 0 end) as `[70-60]`,
sum(case when s_score > 60 and s_score <= 70 then 1 else 0 end) / count(Sid) as `[70-60]pt`,
sum(case when s_score >= 0 and s_score <= 60 then 1 else 0 end) as `[60-0]`,
sum(case when s_score >= 0 and s_score <= 60 then 1 else 0 end) / count(Sid) as `[60-0]pt`
from score as s inner join course as c on s.Cid = c.Cid
group by Cid;

#Q23 查詢各科成績前三名的記錄***
select *
from
	(select a.Cid, a.Sid, a.s_score, count(b.s_score) +1 as `rank`
	from score as a left join score as b on a.Cid = b.Cid and a.s_score < b.s_score
	group by Cid, Sid
	order by Cid, `rank` asc) as Q23
where `rank` <= 3
;

#OLAP
select * 
from
	(select Cid, Sid,
	rank() over(partition by Cid order by s_score desc) as `rank`
	from score) as Q23	
where `rank` <= 3;

#Q24 查詢每門課程被選修的學生數
select Cid,count(Sid)
from score
group by Cid;

#Q25 查詢出只選修兩門課程的學生學號和姓名
select score.Sid, Sname, count(Cid)
from score inner join student on score.Sid = student.Sid
group by Sid
having count(Cid) = 2;

#Q26 查詢男生、女生人數
select Ssex, count(Sid) 
from student
group by Ssex;

#Q27 查詢名字中含有「風」字的學生資訊
select *
from student
where Sname like '%風%';

#Q28 查詢同名同性學生名單，並統計同名人數
select a.Sname, a.Ssex, count(1) as `number`
from student as a inner join student as b on a.Sname = b.Sname
where a.Ssex = b.Ssex and a.Sid <> b.Sid
group by a.Ssex, a.Sname; 

#Q29 查詢 1990 年出生的學生名單
select * 
from student
where year(Sage) = '1990';

#Q30 查詢每門課程的平均成績，結果按平均成績降序排列，平均成績相同時，按課程編號升序排列
select Cid, avg(s_score) as `avg`
from score
group by Cid
order by `avg` desc, Cid asc;

#Q31 查詢平均成績大於等於 85 的所有學生的學號、姓名和平均成績
select s.Sid, st.Sname, avg(s_score) as `avg`
from score as s inner join student as st on s.Sid = st.Sid
group by Sid
having `avg` >= 85;

#Q32 查詢課程名稱為「數學」，且分數低於 60 的學生姓名和分數
select s.Sid, st.Sname, s.Cid, c.Cname, s.s_score
from 
	score as s 
    inner join course as c on s.Cid = c.Cid
    inner join student as st on s.Sid = st.Sid
where s_score < 60 and Cname = '數學';

#Q33 查詢所有學生的課程及分數情況（存在學生沒成績，沒選課的情況)
select student.Sname, score.Cid, score.s_score
from score inner join student on score.Sid = student.Sid;

#Q34 查詢任何一門課程成績在 70 分以上的姓名、課程名稱和分數
select st.Sname, c.Cname, sc.s_score
from 
	student as st 
    inner join score as sc on st.Sid = sc.Sid
    inner join course as c on sc.Cid = c.Cid
where sc.s_score > 70;

#Q35 查詢不及格的課程
select score.Cid, course.Cname, score.s_score
from score inner join course on score.Cid = course.Cid
where score.s_score <60
order by score.s_score DESC;

#Q36 查詢課程編號為 01 且課程成績在 80 分以上的學生的學號和姓名
select score.Sid, student.Sname
from score inner join student on score.Sid = student.Sid
where Cid = '01' and s_score >= 80;

#Q37 求每門課程的學生人數
select Cid, count(Sid)
from score 
group by Cid;

#Q38 成績不重複，查詢選修「張三」老師所授課程的學生中，成績最高的學生資訊及其成績
select * 
from score as sc inner join student as st on sc.Sid = st.Sid
where s_score in(
	select max(s_score)
	from score as sc 
	inner join course as c on sc.Cid = c.Cid
	inner join teacher as t on c.Tid = t.Tid
	where t.tname = '張三')
;

#Q39 成績有重複的情況下，查詢選修「張三」老師所授課程的學生中，成績最高的學生資訊及其成績
select * 
from score as sc inner join student as st on sc.Sid = st.Sid
where s_score in(
	select max(s_score)
	from score as sc 
	inner join course as c on sc.Cid = c.Cid
	inner join teacher as t on c.Tid = t.Tid
	where t.tname = '張三');

#Q40 查詢不同課程成績相同的學生的學生編號、課程編號、學生成績
select distinct a.*
from score as a inner join score as b on a.s_score = b.s_score
where a.Cid <> b.Cid;

#Q41 查詢每門功成績最好的前兩名
select Q41.Cid, s.Sid, s.Sname, Q41.`rank`
from student as s inner join 
    (select Sid, Cid,
	rank() over(partition by Cid order by s_score desc) as `rank`
    from score) as Q41 on s.Sid = Q41.Sid
where `rank` <= 2;

#Q42 統計每門課程的學生選修人數（超過 5 人的課程才統計）
select Cid, count(Sid)
from score
group by Cid
having count(Sid) > 5;

#Q43 檢索至少選修兩門課程的學生學號
select Sid, count(Cid)
from score
group by Sid
having count(Cid) >= 2;

#Q44 查詢選修了全部課程的學生資訊
select *
from student
where Sid in(
	select Sid
	from score
	group by Sid
	having count(1)=(
		select count(1) from course));

#Q45 查詢各學生的年齡，只按年份來算
select Sid, Sname, year(now())-year(Sage) as `age`
from student;

#Q46 按照出生日期來算，當前月日 < 出生年月的月日則，年齡減一
select  Sid, Sname, 
		case when date_format(now(), '%m%d') < date_format(sage, '%m%d')
        then year(now())-year(Sage) -1
        else year(now())-year(Sage)
        end as `age`
from student;

#Q47 查詢本週過生日的學生
select Sid, Sname, Sage
from student
where week(Sage) = week(now());

#Q48 查詢下週過生日的學生
select Sid, Sname, Sage
from student
where week(Sage) = week(now()) +1;

#Q49 查詢本月過生日的學生
select Sid, Sname, Sage
from student
where month(Sage) = month(now());

#Q50 查詢下月過生日的學生
select Sid, Sname, Sage
from student
where month(Sage) = month(now()) +1;
