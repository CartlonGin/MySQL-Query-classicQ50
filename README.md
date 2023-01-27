# MySQL-ClassicQ50

MySQL 的經典50題練習，有助於培養基本的資料庫查詢觀念與邏輯培養，也可以當成基本的查詢工具書。
This is a basic practice of MySQL, including 50 questions of the query. It is helpful for new hands of MySQL to build the logic of database queries.

* ### 50 Questions:
```
1. 查詢" 01 "課程比" 02 "課程成績高的學生的資訊及課程分數
2. 查詢同時存在" 01 "課程和" 02 "課程的情況
3. 查詢存在" 01 "課程但可能不存在" 02 "課程的情況(不存在時顯示為 null )
4. 查詢不存在" 01 "課程但存在" 02 "課程的情況
5. 查詢平均成績大於等於 60 分的同學的學生編號和學生姓名和平均成績
6. 查詢在 SC 表存在成績的學生資訊
7. 查詢所有同學的學生編號、學生姓名、選課總數、所有課程的總成績(沒成績的顯示為 null )
8. 查詢「李」姓老師的數量
9. 查詢學過「張三」老師授課的同學的資訊
10. 查詢沒有學全所有課程的同學的資訊
11. 查詢至少有一門課與學號為" 01 "的同學所學相同的同學的資訊
12. 查詢和" 01 "號的同學學習的課程 完全相同的其他同學的資訊
13. 查詢沒學過"張三"老師講授的任一門課程的學生姓名
14. 查詢兩門及其以上不及格課程的同學的學號，姓名及其平均成績
15. 檢索" 01 "課程分數小於 60，按分數降序排列的學生資訊
16. 按平均成績從高到低顯示所有學生的所有課程的成績以及平均成績
17. 查詢各科成績最高分、最低分和平均分：以如下形式顯示：課程 ID，課程 name，最高分，最低分，平均分，及格率，中等率，優良率，優秀率; 及格為>=60，中等為：70-80，優良為：80-90，優秀為：>=90，要求輸出課程號和選修人數，查詢結果按人數降序排列，若人數相同，按課程號升序排列
18. 按各科成績進行排序，並顯示排名， Score 重複時保留名次空缺
19. 按各科成績進行排序，並顯示排名， Score 重複時合併名次
20. 查詢學生的總成績，並進行排名，總分重複時保留名次空缺
21. 查詢學生的總成績，並進行排名，總分重複時不保留名次空缺
22. 統計各科成績各分數段人數：課程編號，課程名稱，[100-85]，[85-70]，[70-60]，[60-0] 及所佔百分比
23. 查詢各科成績前三名的記錄
24. 查詢每門課程被選修的學生數
25. 查詢出只選修兩門課程的學生學號和姓名
26. 查詢男生、女生人數
27. 查詢名字中含有「風」字的學生資訊
28. 查詢同名同性學生名單，並統計同名人數
29. 查詢 1990 年出生的學生名單
30. 查詢每門課程的平均成績，結果按平均成績降序排列，平均成績相同時，按課程編號升序排列
31. 查詢平均成績大於等於 85 的所有學生的學號、姓名和平均成績
32. 查詢課程名稱為「數學」，且分數低於 60 的學生姓名和分數
33. 查詢所有學生的課程及分數情況（存在學生沒成績，沒選課的情況）
34. 查詢任何一門課程成績在 70 分以上的姓名、課程名稱和分數
35. 查詢不及格的課程
36. 查詢課程編號為 01 且課程成績在 80 分以上的學生的學號和姓名
37. 求每門課程的學生人數
38. 成績不重複，查詢選修「張三」老師所授課程的學生中，成績最高的學生資訊及其成績
39. 成績有重複的情況下，查詢選修「張三」老師所授課程的學生中，成績最高的學生資訊及其成績
40. 查詢不同課程成績相同的學生的學生編號、課程編號、學生成績
41. 查詢每門功成績最好的前兩名
42. 統計每門課程的學生選修人數（超過 5 人的課程才統計)
43. 檢索至少選修兩門課程的學生學號
44. 查詢選修了全部課程的學生資訊
45. 查詢各學生的年齡，只按年份來算
46. 按照出生日期來算，當前月日 < 出生年月的月日則，年齡減一
47. 查詢本週過生日的學生
48. 查詢下週過生日的學生
49. 查詢本月過生日的學生
50. 查詢下月過生日的學生
```
---
## 1. Database
* #### 建立資料表架構：首先要先建立4張表，分別是：學生(Student)、課程(Course)、教師(Teacher)、成績(Score)，並建立關聯。（ps.各個表與資料類別的縮寫與可依照自己習慣設定）
```js
CREATE TABLE `Student`(
`Sid` VARCHAR(20),
`Sname` VARCHAR(20) NOT NULL DEFAULT '',
`Sage` VARCHAR(20) NOT NULL DEFAULT '',
`Ssex` VARCHAR(10) NOT NULL DEFAULT '',
PRIMARY KEY(`Sid`)
);

CREATE TABLE `Course`(
`Cid` VARCHAR(20),
`Cname` VARCHAR(20) NOT NULL DEFAULT '',
`Tid` VARCHAR(20) NOT NULL,
PRIMARY KEY(`Cid`)
);

CREATE TABLE `Teacher`(
`Tid` VARCHAR(20),
`Tname` VARCHAR(20) NOT NULL DEFAULT '',
PRIMARY KEY(`Tid`)
);

CREATE TABLE `Score`(
`Sid` VARCHAR(20),
`Cid` VARCHAR(20),
`Sscore` INT(3),
PRIMARY KEY(`Sid`,`Cid`)
);
```
* #### 輸入資料：用```insert```將各個資料輸入進去各個表中。（ps. 資料內容也可以自行調整)

```js
insert into Student values('01' , '趙雷' , '1990-01-01' , '男');
insert into Student values('02' , '錢電' , '1990-12-21' , '男');
insert into Student values('03' , '孫風' , '1990-05-20' , '男');
insert into Student values('04' , '李雲' , '1990-08-06' , '男');
insert into Student values('05' , '周梅' , '1991-12-01' , '女');
insert into Student values('06' , '吳蘭' , '1992-03-01' , '女');
insert into Student values('07' , '鄭竹' , '1989-07-01' , '女');
insert into Student values('08' , '王菊' , '1990-01-20' , '女');

insert into Course values('01' , '語文' , '02');
insert into Course values('02' , '數學' , '01');
insert into Course values('03' , '英語' , '03');


insert into Teacher values('01' , '張三');
insert into Teacher values('02' , '李四');
insert into Teacher values('03' , '王五');


insert into Score values('01' , '01' , 80);
insert into Score values('01' , '02' , 90);
insert into Score values('01' , '03' , 99);
insert into Score values('02' , '01' , 70);
insert into Score values('02' , '02' , 60);
insert into Score values('02' , '03' , 80);
insert into Score values('03' , '01' , 80);
insert into Score values('03' , '02' , 80);
insert into Score values('03' , '03' , 80);
insert into Score values('04' , '01' , 50);
insert into Score values('04' , '02' , 30);
insert into Score values('04' , '03' , 20);
insert into Score values('05' , '01' , 76);
insert into Score values('05' , '02' , 87);
insert into Score values('06' , '01' , 31);
insert into Score values('06' , '03' , 34);
insert into Score values('07' , '02' , 89);
insert into Score values('07' , '03' , 98);
```
## 2. Query
MySQL 的語法處理順序大致上為：```FROM``` > ```WHERE``` > ```GROUP BY``` > ```HAVING``` > ```SELECT``` > ```ORDER BY``` > ```LIMIT```
* 完整語法請看 https://github.com/CartlonGin/MySQL-classicQ50/blob/fffd17a2cc335b140523cbd989bbaf98503c8bc3/Q50code.sql
* 一些筆記，前方數字為題號：
12. 題目要求完全相同：不只一筆資料，所以是一個list，用 ```GROUP_CONCAT```
17. ```sum(case when column1 = ’value1’ then 1 else 0 end)```，如果欄位值有’value1’，則case回傳1給sum，沒有則回傳0，sum則加1，可以用在取得在特定欄位中有多少列有value1
18. 排序問題解法： 
	  Online Analytical Processing 窗口函數
	    <窗口函数/聚合函數> over (partition by <用來分组的列名> #partition分組不會改變行數 #group分組會改變行數
                                order by <用來排序的列名>)
	   <ex> 每個班級內按照成績排名
	   ```js
     select *,
     rank() over (partition by 班級 order by 成績 desc) as ranking
     from 班级表 
     ```
20. ```set @rank := 0;```  #外部宣告好處在於如果沒執行到宣告，下方程式碼不會出錯只會顯示NULL，可 ```=``` or ```:=``` ，
	  ```select Q20.*, @rank := @rank +1 as `rank` ```，select 的賦值一定要是 ```:=```，此句意思為此變數@rank經歷每筆資料後都會加1

