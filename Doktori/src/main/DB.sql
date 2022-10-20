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
CREATE TABLE faqtable(
QU varchar2(4000),
AN varchar2(4000),
qnum NUMBER PRIMARY KEY, 
id varchar2(30)
)

ALTER TABLE FAQTABLE  ADD CONSTRAINT faqfk_id FOREIGN KEY (id) REFERENCES dmember(id);

CREATE SEQUENCE faq_seq 
INCREMENT BY 1
START WITH 1
MINVALUE 1
MAXVALUE 999
nocycle
nocache
noorder