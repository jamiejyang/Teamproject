CREATE  SEQUENCE book_num
INCREMENT BY 1
START WITH 1
MINVALUE 1
nomaxvalue 
nocycle
nocache

--DROP SEQUENCE  book_num  --시퀀스 다시 만들 떄

CREATE TABLE booklist(
bookKey	varchar2(60),
speciesKey varchar2(60),
libName	varchar2(40),
manageCode varchar2(10),
regNo varchar2(60),
controlNo varchar2(60),
callNo varchar2(60),
shelfLocName varchar2(100),
title varchar2(300),
author varchar2(300),
publisher varchar2(60),
pubYear varchar2(30),
isbn varchar2(75), 
book_num varchar2(200) PRIMARY KEY 
)

--ALTER TABLE booklist MODIFY (libname VARCHAR2(40)); 

--DROP TABLE BOOKLIST  


SELECT * FROM BOOKLIST b ORDER BY libname asc

--DELETE FROM booklist
--WHERE title = '3' OR title='2-9' OR title = '2-2' OR title ='2-12'
--OR title ='1' OR title='10' OR title ='2' OR title= '5' OR title='4' 
--OR title = '6'OR title = '8' OR title= '9' OR title ='60' OR title='7'




suggestboard(건의사항 게시판)
CREATE TABLE suggestboard(
num NUMBER PRIMARY KEY,
title varchar2(200) NOT NULL,
content varchar2(2000) NOT NULL,
processing varchar2(12),
id varchar2(30) NOT NULL,
pass varchar2(30),
postdate DATE DEFAULT sysdate NOT NULL,
visitcount number(6),
ufile varchar2(100) 
);