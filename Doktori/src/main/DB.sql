-------------------------------------------박준혁------------------------------
CREATE TABLE booklist(
bookKey	varchar2(60),
speciesKey varchar2(60),
libName	varchar2(50),
manageCode varchar2(20),
regNo varchar2(60),
controlNo varchar2(60),
callNo varchar2(60),
shelfLocName varchar2(100),
title varchar2(300),
author varchar2(300),
publisher varchar2(60),
pubYear varchar2(30),
isbn varchar2(75), 
book_num NUMBER  PRIMARY KEY 
);

CREATE  SEQUENCE book_num
INCREMENT BY 1
START WITH 1
MINVALUE 1
nomaxvalue 
nocycle
nocache;


CREATE  SEQUENCE notice_num
INCREMENT BY 1
START WITH 1
MINVALUE 1
nomaxvalue 
nocycle
nocache
;

CREATE TABLE DMEMBER(
name varchar2(30) NOT NULL,
nickname varchar2(30) NOT NULL,
id varchar2(30) NOT NULL PRIMARY KEY,
pass varchar2(30) NOT NULL
);

CREATE TABLE Notice (
num NUMBER  NOT NULL  ,
name varchar2(50) NOT NULL ,
title varchar2(100) NOT NULL ,  
content varchar2(600) NOT NULL ,
ofile varchar2(100),
sfile varchar2(100),
writedate DATE default sysdate,
managecode varchar2(40) NOT NULL ,
readcount NUMBER(6) DEFAULT 0 NOT NULL,
id varchar2(30) NOT NULL
);


ALTER TABLE BOOKLIST ADD bookimg VARCHAR(200) DEFAULT ' ';

ALTER TABLE NOTICE  ADD CONSTRAINT notice_fk2 FOREIGN KEY (id)
REFERENCES dmember (id);

INSERT INTO DMEMBER (name,NICKNAME, id, pass)
VALUES ('관리자', '관리자','admin','1234');


CREATE TABLE LIKES(
id varchar2(30),
book_num NUMBER 
);


ALTER TABLE LIKES ADD CONSTRAINT fk_booknum FOREIGN KEY (book_num) REFERENCES booklist(book_num);


ALTER TABLE likes ADD CONSTRAINT likefk_id FOREIGN KEY (id) REFERENCES dmember(id);


CREATE TABLE RESERVE(
id varchar2(30),
book_num NUMBER 
);

ALTER TABLE reserve ADD CONSTRAINT refk_id FOREIGN KEY (id) REFERENCES dmember(id);

ALTER TABLE reserve ADD CONSTRAINT refk_booknum FOREIGN KEY (book_num) REFERENCES booklist(book_num);

CREATE TABLE liblist (
managecode varchar2(20) PRIMARY KEY,
libname varchar2(50) ,
dayoff varchar2(100),
url varchar2(100),
place varchar2(100),
tel varchar2(60)
);


ALTER TABLE BOOKLIST ADD CONSTRAINT bfk_lib FOREIGN KEY (managecode) REFERENCES liblist(managecode);

ALTER TABLE NOTICE  ADD CONSTRAINT nfk_lib FOREIGN KEY (managecode) REFERENCES liblist(managecode);

CREATE TABLE libinfo(
managecode varchar2(20) ,
Status varchar2(60),
HOUrs varchar2(60) 
);

ALTER TABLE libinfo
ADD CONSTRAINT lib_ma
FOREIGN KEY (managecode)
REFERENCES liblist(managecode);


---------------------------------------양은정--------------------------------------------


--//SUGGESTBOARD 건의사항 게시판
CREATE TABLE suggestboard(
num NUMBER PRIMARY KEY,
title varchar2(200) NOT NULL,
content varchar2(2000) NOT NULL,
processing varchar2(12) DEFAULT '등록',
id varchar2(30) NOT NULL,
pass varchar2(30),
writedate DATE DEFAULT sysdate NOT NULL,
readcount number(6),
ofile varchar2(100),
sfile varchar2(100)
);

--//SUGGESTCOMMENT 건의사항 게시판 댓글
CREATE TABLE SUGGESTCOMMENT(
CMTNUM NUMBER NOT NULL,
BBSNUM NUMBER NOT NULL,
CMTID varchar2(30),
CMTDATE DATE DEFAULT sysdate NOT NULL,
CMTCONTENT varchar2(1000) NOT NULL
);

ALTER TABLE SUGGESTCOMMENT ADD CONSTRAINT fk_suggestboard
FOREIGN key(bbsnum) REFERENCES suggestboard(num);


ALTER TABLE SUGGESTBOARD  ADD CONSTRAINT subfk_id FOREIGN KEY (id) REFERENCES dmember(id);

ALTER TABLE SUGGESTCOMMENT  ADD CONSTRAINT subfk_id2 FOREIGN KEY (cmtid) REFERENCES dmember(id);

CREATE SEQUENCE seq_board_num
INCREMENT BY 1
START WITH 1
MINVALUE 1
nomaxvalue
nocycle
nocache;


CREATE SEQUENCE seq_commentboard_num
INCREMENT BY 1
START WITH 1
MINVALUE 1
nomaxvalue
nocycle
nocache;


------------------------------------------구경미-----------------------------

CREATE TABLE REVIEWBOARD (
    NUM NUMBER PRIMARY KEY,
    ID VARCHAR2(30) NOT NULL,
    TITLE VARCHAR2(100) NOT NULL,
    CONTENT VARCHAR2(2000) NOT NULL,
    WRITEDATE DATE,
    READCOUNT NUMBER,
    TOPFIX INT DEFAULT 0,
    OFILE VARCHAR2(100),
    SFILE VARCHAR2(100)
    );


create SEQUENCE rboard_seq;


ALTER TABLE REVIEWBOARD ADD CONSTRAINT fk_id FOREIGN KEY (id)
REFERENCES DMEMBER (id);


CREATE TABLE REVIEWCOMMENT(
    CMTNUM NUMBER NOT NULL,
    BBSNUM NUMBER NOT NULL,
    CMTID varchar2(30),
    CMTDATE DATE,
    CMTCONTENT varchar2(1000) NOT NULL
);


CREATE SEQUENCE cmt_seq;


alter table REVIEWCOMMENT add constraint FK_NUM foreign key (BBSNUM) 
references REVIEWBOARD(NUM) ;


ALTER TABLE REVIEWCOMMENT DROP CONSTRAINT FK_NUM;


ALTER TABLE REVIEWCOMMENT 
ADD CONSTRAINT FK_NUM FOREIGN key(bbsnum) 
REFERENCES reviewboard(num) ON DELETE CASCADE;

ALTER TABLE REVIEWCOMMENT ADD CONSTRAINT reviewfk_id FOREIGN KEY (cmtid) REFERENCES dmember(id);

--------------------------------윤세윤-------------------------------

INSERT INTO LIBINFO (managecode,STATUS,HOURS)
VALUES ('MH','문학실·한국문학자료관','09:00 - 20:00')

INSERT INTO LIBINFO (managecode,STATUS,HOURS)
VALUES ('MH','자연과학실','09:00 - 18:00')

INSERT INTO LIBINFO (managecode,STATUS,HOURS)
VALUES ('MH','디지털라운지','09:00 - 18:00')

INSERT INTO LIBINFO (managecode,STATUS,HOURS)
VALUES ('MH','독서치료·어학실','09:00 - 18:00')

INSERT INTO LIBINFO (managecode,STATUS,HOURS)
VALUES ('MH','일반열람실','07:00 - 22:00')

INSERT INTO LIBINFO (managecode,STATUS,HOURS)
VALUES ('MV','문헌정보실','09:00 - 20:00')

INSERT INTO LIBINFO (managecode,STATUS,HOURS)
VALUES ('MV','디지털자료실','09:00 - 18:00')

INSERT INTO LIBINFO (managecode,STATUS,HOURS)
VALUES ('MV','어린이실','09:00 - 18:00')

INSERT INTO LIBINFO (managecode,STATUS,HOURS)
VALUES ('MV','자율학습실','07:00 - 22:00')

INSERT INTO LIBINFO (managecode,STATUS,HOURS)
VALUES ('MJ','자율학습실','08:00 - 22:00')

INSERT INTO LIBINFO (managecode,STATUS,HOURS)
VALUES ('MJ','종합자료실','09:00 - 20:00')

INSERT INTO LIBINFO (managecode,STATUS,HOURS)
VALUES ('MJ','어린이실·디지털자료실','09:00 - 18:00')

INSERT INTO LIBINFO (managecode,STATUS,HOURS)
VALUES ('MK','종합자료1실','09:00 - 20:00')

INSERT INTO LIBINFO (managecode,STATUS,HOURS)
VALUES ('MK','종합자료2실','09:00 - 18:00')

INSERT INTO LIBINFO (managecode,STATUS,HOURS)
VALUES ('MK','어린이실','09:00 - 18:00')

INSERT INTO LIBINFO (managecode,STATUS,HOURS)
VALUES ('MK','자율학습1실','07:00 - 22:00')

INSERT INTO LIBINFO (managecode,STATUS,HOURS)
VALUES ('MK','자율학습2실','07:00 - 22:00')

INSERT INTO LIBINFO (managecode,STATUS,HOURS)
VALUES ('ML','노트북실,대기실','07:00 - 22:00')

INSERT INTO LIBINFO (managecode,STATUS,HOURS)
VALUES ('ML','자율학습실','07:00 - 22:00')

INSERT INTO LIBINFO (managecode,STATUS,HOURS)
VALUES ('ML','어린이실','09:00 - 18:00')

INSERT INTO LIBINFO (managecode,STATUS,HOURS)
VALUES ('ML','디지털자료실','09:00 - 18:00')

INSERT INTO LIBINFO (managecode,STATUS,HOURS)
VALUES ('ML','종합자료실','09:00 - 20:00')

INSERT INTO LIBINFO (managecode,STATUS,HOURS)
VALUES ('MX','문헌정보실','09:00 - 20:00')

INSERT INTO LIBINFO (managecode,STATUS,HOURS)
VALUES ('MX','어린이실','09:00 - 18:00')

INSERT INTO LIBINFO (managecode,STATUS,HOURS)
VALUES ('MX','학습실','07:00 - 22:00')

INSERT INTO LIBINFO (managecode,STATUS,HOURS)
VALUES ('MM','헬스장','08:00 - 20:00')

INSERT INTO LIBINFO (managecode,STATUS,HOURS)
VALUES ('MM','수영장','07:00 - 20:20')

INSERT INTO LIBINFO (managecode,STATUS,HOURS)
VALUES ('MM','평생학습교실','10:00 - 21:00')

INSERT INTO LIBINFO (managecode,STATUS,HOURS)
VALUES ('MM','자율학습실','07:00 - 22:00')

INSERT INTO LIBINFO (managecode,STATUS,HOURS)
VALUES ('MM','문헌정보실','09:00 - 20:00')

INSERT INTO LIBINFO (managecode,STATUS,HOURS)
VALUES ('MM','마포리움','09:00 - 18:00')

INSERT INTO LIBINFO (managecode,STATUS,HOURS)
VALUES ('MM','어린이·다누리실','09:00 - 18:00')

INSERT INTO LIBINFO (managecode,STATUS,HOURS)
VALUES ('MM','시각장애인실','09:00 - 18:00')

INSERT INTO LIBINFO (managecode,STATUS,HOURS)
VALUES ('MM','디지털·간행물실','09:00 - 18:00')

INSERT INTO LIBINFO (managecode,STATUS,HOURS)
VALUES ('MP','자율학습실','07:00 - 22:00')

INSERT INTO LIBINFO (managecode,STATUS,HOURS)
VALUES ('MP','종합자료실','09:00 - 20:00')

INSERT INTO LIBINFO (managecode,STATUS,HOURS)
VALUES ('MP','어린이자료실','09:00 - 18:00')

INSERT INTO LIBINFO (managecode,STATUS,HOURS)
VALUES ('MP','디지털·연속간행물실','09:00 - 18:00')

INSERT INTO LIBINFO (managecode,STATUS,HOURS)
VALUES ('MW','인문사회자연과학실','09:00 - 20:00')

INSERT INTO LIBINFO (managecode,STATUS,HOURS)
VALUES ('MW','어학문학실','09:00 - 20:00')

INSERT INTO LIBINFO (managecode,STATUS,HOURS)
VALUES ('MW','어린이실','09:00 - 18:00')

INSERT INTO LIBINFO (managecode,STATUS,HOURS)
VALUES ('MW','디지털자료실','09:00 - 18:00')

INSERT INTO LIBINFO (managecode,STATUS,HOURS)
VALUES ('MW','일반열람실','07:00 - 22:00')

INSERT INTO LIBINFO (managecode,STATUS,HOURS)
VALUES ('MN','열린학습실','07:00 - 22:00')

INSERT INTO LIBINFO (managecode,STATUS,HOURS)
VALUES ('MN','책누리실','09:00 - 20:00')

INSERT INTO LIBINFO (managecode,STATUS,HOURS)
VALUES ('MN','꿈동산실','09:00 - 18:00')

INSERT INTO LIBINFO (managecode,STATUS,HOURS)
VALUES ('MN','정보마당실','09:00 - 17:00')

INSERT INTO LIBINFO (managecode,STATUS,HOURS)
VALUES ('MQ','책누리1','09:00 - 18:00')

INSERT INTO LIBINFO (managecode,STATUS,HOURS)
VALUES ('MQ','책누리2','09:00 - 18:00')

INSERT INTO LIBINFO (managecode,STATUS,HOURS)
VALUES ('MQ','유아책누리','09:00 - 18:00')

INSERT INTO LIBINFO (managecode,STATUS,HOURS)
VALUES ('MQ','온꿈누리','09:00 - 18:00')

INSERT INTO LIBINFO (managecode,STATUS,HOURS)
VALUES ('MQ','어린이 갤러리','09:00 - 18:00')

INSERT INTO LIBINFO (managecode,STATUS,HOURS)
VALUES ('MR','어린이실','09:00 - 18:00')

INSERT INTO LIBINFO (managecode,STATUS,HOURS)
VALUES ('MR','디지털간행물실','09:00 - 18:00')

INSERT INTO LIBINFO (managecode,STATUS,HOURS)
VALUES ('MR','자율학습실','07:00 - 22:00')

INSERT INTO LIBINFO (managecode,STATUS,HOURS)
VALUES ('MR','문헌정보실','09:00 - 20:00')

INSERT INTO LIBINFO (managecode,STATUS,HOURS)
VALUES ('MS','문헌정보실','09:00 - 20:00')

INSERT INTO LIBINFO (managecode,STATUS,HOURS)
VALUES ('MS','어린이실','09:00 - 18:00')

INSERT INTO LIBINFO (managecode,STATUS,HOURS)
VALUES ('MS','디지털·간행물실','09:00 - 18:00')

INSERT INTO LIBINFO (managecode,STATUS,HOURS)
VALUES ('MS','자율학습실','08:00 - 22:00')

INSERT INTO LIBINFO (managecode,STATUS,HOURS)
VALUES ('MT','자율학습실','08:00 - 22:00')

INSERT INTO LIBINFO (managecode,STATUS,HOURS)
VALUES ('MT','서울교육박물관','09:00 - 18:00')

INSERT INTO LIBINFO (managecode,STATUS,HOURS)
VALUES ('MT','디지털자료실','09:00 - 18:00')

INSERT INTO LIBINFO (managecode,STATUS,HOURS)
VALUES ('MT','청소년관','09:00 - 18:00')

INSERT INTO LIBINFO (managecode,STATUS,HOURS)
VALUES ('MT','어린이자료실','09:00 - 18:00')

INSERT INTO LIBINFO (managecode,STATUS,HOURS)
VALUES ('MT','다국어·연속간행물실','09:00 - 18:00')

INSERT INTO LIBINFO (managecode,STATUS,HOURS)
VALUES ('MT','인문사회자연과학실','09:00 - 20:00')

INSERT INTO LIBINFO (managecode,STATUS,HOURS)
VALUES ('MT','어문학·족보실','09:00 - 20:00')

INSERT INTO LIBINFO (managecode,STATUS,HOURS)
VALUES ('MU','인문사회과학실','09:00 - 20:00')

INSERT INTO LIBINFO (managecode,STATUS,HOURS)
VALUES ('MU','어문학실','09:00 - 20:00')

INSERT INTO LIBINFO (managecode,STATUS,HOURS)
VALUES ('MU','자연과학정보실','09:00 - 18:00')

INSERT INTO LIBINFO (managecode,STATUS,HOURS)
VALUES ('MU','인왕관(특화자료실)','09:00 - 18:00')

INSERT INTO LIBINFO (managecode,STATUS,HOURS)
VALUES ('MU','자율학습실','07:00 - 22:00')



CREATE TABLE suggestboard(
num NUMBER PRIMARY KEY,
title varchar2(200) NOT NULL,
content varchar2(2000) NOT NULL,
processing varchar2(12) DEFAULT '등록',
id varchar2(30) NOT NULL,
pass varchar2(30),
writedate DATE DEFAULT sysdate NOT NULL,
readcount number(6),
ofile varchar2(100),
sfile varchar2(100)
);


CREATE TABLE SUGGESTCOMMENT(
CMTNUM NUMBER NOT NULL,
BBSNUM NUMBER NOT NULL,
CMTID varchar2(30),
CMTDATE DATE DEFAULT sysdate NOT NULL,
CMTCONTENT varchar2(1000) NOT NULL
);

ALTER TABLE SUGGESTCOMMENT ADD CONSTRAINT fk_suggestboard
FOREIGN key(bbsnum) REFERENCES suggestboard(num);

