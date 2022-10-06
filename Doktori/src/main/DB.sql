CREATE  SEQUENCE book_num
INCREMENT BY 1
START WITH 1
MINVALUE 1
nomaxvalue 
nocycle
nocache

--DROP TABLE BOOKLIST  
--
--DROP SEQUENCE  book_num
--
--SELECT DISTINCT  LIBNAME  FROM BOOKLIST b 
--
--DELETE  BOOKLIST b  WHERE LIBNAME ='MA'


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
)




DELETE FROM booklist
WHERE title = '3' OR title='2-9' OR title = '2-2' OR title ='2-12'
OR title ='1' OR title='10' OR title ='2' OR title= '5' OR title='4' 
OR title = '6'OR title = '8' OR title= '9' OR title ='60' OR title='7'


CREATE  SEQUENCE notice_num
INCREMENT BY 1
START WITH 1
MINVALUE 1
nomaxvalue 
nocycle
nocache

CREATE TABLE DMEMBER(
name varchar2(30) NOT NULL,
nickname varchar2(30) NOT NULL,
id varchar2(30) NOT NULL PRIMARY KEY,
pass varchar2(30) NOT NULL
)

CREATE TABLE Notice (
num NUMBER  NOT NULL  ,
name varchar2(50) NOT NULL ,
title varchar2(50) NOT NULL ,   -- 타이틀 한 200되야하나
content varchar2(200) NOT NULL ,
files varchar2(100),
writedate DATE default sysdate,
libname varchar2(40) NOT NULL ,
readcount NUMBER(6) DEFAULT 0 NOT NULL,
id varchar2(30) NOT NULL 
)

ALTER TABLE NOTICE  ADD CONSTRAINT notice_fk FOREIGN KEY (id)
REFERENCES dmember (id);





SELECT * FROM DMEMBER d  

INSERT INTO DMEMBER (name,NICKNAME, id, pass)
VALUES ('관리자', '관리자','admin','1234')


CREATE TABLE faqtable(
	QU varchar2(4000),
	AN varchar2(4000),
	qnum number
)

CREATE SEQUENCE faq_seq 
INCREMENT BY 1
START WITH 1
MINVALUE 1
MAXVALUE 999
nocycle
nocache
noorder

ALTER TABLE faqtable ADD CONSTRAINT pk_name PRIMARY KEY(qnum)

