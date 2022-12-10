```create table```

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

```insert data```

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

