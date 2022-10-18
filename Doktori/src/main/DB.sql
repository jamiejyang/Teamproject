CREATE  SEQUENCE book_num
INCREMENT BY 1
START WITH 1
MINVALUE 1
nomaxvalue 
nocycle
nocache

DROP TABLE notice
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
ofile varchar2(100),
sfile varchar2(100),
writedate DATE default sysdate,
managecode varchar2(40) NOT NULL ,
readcount NUMBER(6) DEFAULT 0 NOT NULL,
id varchar2(30) NOT NULL
)

ALTER TABLE BOOKLIST ADD bookimg VARCHAR(200) DEFAULT ' '

ALTER TABLE NOTICE  ADD CONSTRAINT notice_fk2 FOREIGN KEY (li)
REFERENCES dmember (id);





SELECT * FROM DMEMBER d  

INSERT INTO DMEMBER (name,NICKNAME, id, pass)
VALUES ('관리자', '관리자','admin','1234')


CREATE TABLE LIKES(
id varchar2(30),
book_num NUMBER 
)

ALTER TABLE NOTICE  ADD CONSTRAINT fk_libname FOREIGN KEY (libname) REFERENCES booklist(libname)

ALTER TABLE LIKES ADD CONSTRAINT fk_booknum FOREIGN KEY (book_num) REFERENCES booklist(book_num)

CREATE TABLE RESERVE(
id varchar2(30),
book_num NUMBER 
)

ALTER TABLE reserve ADD CONSTRAINT refk_id FOREIGN KEY (id) REFERENCES dmember(id)

ALTER TABLE reserve ADD CONSTRAINT refk_booknum FOREIGN KEY (book_num) REFERENCES booklist(book_num)

CREATE TABLE liblist (
managecode varchar2(20) PRIMARY KEY,
libname varchar2(50) ,
dayoff varchar2(100),
url varchar2(100),
place varchar2(100),
tel varchar2(60)
)


INSERT INTO liblist (MANAGECODE, LIBNAME, DAYOFF, url, place, tel)
VALUES ('MA', '강남도서관', '첫째 주, 셋째 주 수요일', 'https://gnlib.sen.go.kr/','서울특별시 강남구 선릉로 116길 45','02-3448-4741');

INSERT INTO liblist (MANAGECODE, LIBNAME, DAYOFF, url,place,tel)
VALUES ('MB', '강동도서관', '첫째 주 셋째 주 목요일', 'https://gdlib.sen.go.kr/','
서울특별시 강동구 양재대로116길57','02-2225-9800');

INSERT INTO liblist (MANAGECODE, LIBNAME, DAYOFF, url,place,tel)
VALUES ('MC', '강서도서관', '첫째 주 셋째 주 금요일', 'https://gslib.sen.go.kr/','서울특별시 강서구 등촌로51나길 29','02-3219-7000');

INSERT INTO liblist (MANAGECODE, LIBNAME, DAYOFF, url,place,tel)
VALUES ('MD', '개포도서관', '둘째 주 넷째 주 목요일', 'https://gplib.sen.go.kr/','서울특별시 강남구 선릉로4길 30','02-3460-8200')

INSERT INTO liblist (MANAGECODE, LIBNAME, DAYOFF, url,place,tel)
VALUES ('ME', '고덕평생학습관', '둘째 주 넷째 주 월요일', 'https://gdllc.sen.go.kr/','서울특별시 강동구 고덕로 295 ','02-6902-2600')

INSERT INTO liblist (MANAGECODE, LIBNAME, DAYOFF, url,place,tel)
VALUES ('MF', '고척도서관', '둘째 주 넷째 주 수요일', 'http://gclib.sen.go.kr/','서울특별시 구로구 고척로45길 31','02-2615-0524')

INSERT INTO liblist (MANAGECODE, LIBNAME, DAYOFF, url,place,tel)
VALUES ('MG', '구로도서관', '첫째 주 셋째 주 수요일', 'http://grlib.sen.go.kr/','서울특별시 구로구 공원로 15','02-6958-2800')

INSERT INTO liblist (MANAGECODE, LIBNAME, DAYOFF, url,place,tel)
VALUES ('MH', '남산도서관', '첫째 주 셋째 주 월요일', 'https://nslib.sen.go.kr/','서울 특별시 용산구 소월로 109','02-754-7338')

INSERT INTO liblist (MANAGECODE, LIBNAME, DAYOFF, url,place,tel)
VALUES ('MV', '노원평생학습관', '둘째 주 넷째 주 월요일', 'https://nwllc.sen.go.kr/','서울특별시 노원구 동일로204 13','
02-979-1741')

INSERT INTO liblist (MANAGECODE, LIBNAME, DAYOFF, url,place,tel)
VALUES ('MJ', '도봉도서관', '둘째 주 넷째 주 수요일', 'https://dblib.sen.go.kr/','서울특별시 도봉구 삼양로 556','02-6714-7400')

INSERT INTO liblist (MANAGECODE, LIBNAME, DAYOFF, url,place,tel)
VALUES ('MK', '동대문도서관', '둘째 주 넷째 주 수요일', 'https://ddmlib.sen.go.kr/','서울특별시 동대문구 천호대로4길 22','02-2170-1000')

INSERT INTO liblist (MANAGECODE, LIBNAME, DAYOFF, url,place,tel)
VALUES ('ML', '동작도서관', '둘째 주 넷째 주 금요일', 'http://djlib.sen.go.kr/','서울특별시 동작구 장승배기로 94','02-823-6419')

INSERT INTO liblist (MANAGECODE, LIBNAME, DAYOFF, url,place,tel)
VALUES ('MX', '마포평생아현분관', '둘째 주 넷째 주 월요일', 'https://ahyon.sen.go.kr/','서울특별시 마포구 마포대로 224','02-362-8785')

INSERT INTO liblist (MANAGECODE, LIBNAME, DAYOFF, url,place,tel)
VALUES ('MM', '마포평생학습관', '둘째 주 넷째 주 월요일', 'https://mpllc.sen.go.kr/','서울특별시 마포구 홍익로2길 16','02-2137-0000')

INSERT INTO liblist (MANAGECODE, LIBNAME, DAYOFF, url,place,tel)
VALUES ('MP', '서대문도서관', '첫째 주 셋째 주 화요일', 'https://sdmlib.sen.go.kr/','서울특별시 서대문구 모래내로 412','02-1833-6948')

INSERT INTO liblist (MANAGECODE, LIBNAME, DAYOFF, url,place,tel)
VALUES ('MW', '송파도서관', '둘째 주 넷째 주 화요일', 'https://splib.sen.go.kr/','서울특별시 송파구 동남로 263','02-3434-3333')

INSERT INTO liblist (MANAGECODE, LIBNAME, DAYOFF, url,place,tel)
VALUES ('MN', '양천도서관', '첫째 주 셋째 주 목요일', 'https://yclib.sen.go.kr/','서울 양천구 목동서로 113','02-2062-3900')

INSERT INTO liblist (MANAGECODE, LIBNAME, DAYOFF, url,place,tel)
VALUES ('MQ', '어린이도서관', '첫째 주 셋째 주 월요일', 'https://childlib.sen.go.kr/','서울특별시 종로구 사직로9길 7','02-731-2300')

INSERT INTO liblist (MANAGECODE, LIBNAME, DAYOFF, url,place,tel)
VALUES ('MR', '영등포평생학습관', '둘째 주 넷째 주 월요일', 'https://ydpllc.sen.go.kr/','서울특별시 영등포구 버드나루로15길 10','02-6712-7500')

INSERT INTO liblist (MANAGECODE, LIBNAME, DAYOFF, url,place,tel)
VALUES ('MS', '용산도서관', '둘째 주 넷째 주 화요일', 'https://yslib.sen.go.kr/','서울특별시 용산구 두텁바위로 160','02-6902-7777')

INSERT INTO liblist (MANAGECODE, LIBNAME, DAYOFF, url,place,tel)
VALUES ('MT', '정독도서관', '첫째 주 셋째 주 수요일', 'https://jdlib.sen.go.kr/','서울특별시 종로구 북촌로5길 48','02-2011-5799')

INSERT INTO liblist (MANAGECODE, LIBNAME, DAYOFF, url,place,tel)
VALUES ('MU', '종로도서관', '둘째 주 넷째 주 월요일', 'https://jnlib.sen.go.kr/','서울특별시 종로구 사직로9길 15-14','02-721-0707')

ALTER TABLE BOOKLIST ADD CONSTRAINT bfk_lib FOREIGN KEY (managecode) REFERENCES liblist(managecode)

ALTER TABLE NOTICE  ADD CONSTRAINT nfk_lib FOREIGN KEY (managecode) REFERENCES liblist(managecode)

CREATE TABLE libinfo(
managecode varchar2(20) ,
Status varchar2(60),
HOUrs varchar2(60) 
)

ALTER TABLE libinfo
ADD CONSTRAINT lib_ma
FOREIGN KEY (managecode)
REFERENCES liblist(managecode);

INSERT INTO LIBINFO (managecode,STATUS,HOURS)
VALUES ('MA','종합자료실','09:00 - 20:00')

INSERT INTO LIBINFO (managecode,STATUS,HOURS)
VALUES ('MA','어린이실','09:00 - 18:00')


INSERT INTO LIBINFO (managecode,STATUS,HOURS)
VALUES ('MA','디지털자료실','09:00 - 18:00')

INSERT INTO LIBINFO (managecode,STATUS,HOURS)
VALUES ('MA','일반열람실','07:00 - 22:00')

INSERT INTO LIBINFO (managecode,STATUS,HOURS)
VALUES ('MB','문헌정보실','09:00 - 20:00')

INSERT INTO LIBINFO (managecode,STATUS,HOURS)
VALUES ('MB','어린이실','09:00 - 18:00')

INSERT INTO LIBINFO (managecode,STATUS,HOURS)
VALUES ('MB','디지털자료실','09:00 - 18:00')

INSERT INTO LIBINFO (managecode,STATUS,HOURS)
VALUES ('MB','자율학습실','07:00 - 22:00')

INSERT INTO LIBINFO (managecode,STATUS,HOURS)
VALUES ('MC','인문사회자연과학실','09:00 - 20:00')

INSERT INTO LIBINFO (managecode,STATUS,HOURS)
VALUES ('MC','어린이자료실','09:00 - 18:00')

INSERT INTO LIBINFO (managecode,STATUS,HOURS)
VALUES ('MC','어문학·간행물실','09:00 - 18:00')

INSERT INTO LIBINFO (managecode,STATUS,HOURS)
VALUES ('MC','디지털자료실','09:00 - 18:00')

INSERT INTO LIBINFO (managecode,STATUS,HOURS)
VALUES ('MC','자율학습실','07:00 - 22:00')

INSERT INTO LIBINFO (managecode,STATUS,HOURS)
VALUES ('MD','문헌정보실','09:00 - 20:00')

INSERT INTO LIBINFO (managecode,STATUS,HOURS)
VALUES ('MD','어린이실','09:00 - 18:00')

INSERT INTO LIBINFO (managecode,STATUS,HOURS)
VALUES ('MD','일반 학습실','07:00 - 22:00')

INSERT INTO LIBINFO (managecode,STATUS,HOURS)
VALUES ('MD','디지털.연속간행물실','09:00 - 18:00')

INSERT INTO LIBINFO (managecode,STATUS,HOURS)
VALUES ('ME','문헌정보실 및 연속간행물실','09:00 - 20:00')

INSERT INTO LIBINFO (managecode,STATUS,HOURS)
VALUES ('ME','디지털자료실','09:00 - 18:00')

INSERT INTO LIBINFO (managecode,STATUS,HOURS)
VALUES ('ME','어린이실','09:00 - 18:00')

INSERT INTO LIBINFO (managecode,STATUS,HOURS)
VALUES ('ME','일반열람실','07:00 - 22:00')

INSERT INTO LIBINFO (managecode,STATUS,HOURS)
VALUES ('MF','종합자료실','09:00 - 20:00')

INSERT INTO LIBINFO (managecode,STATUS,HOURS)
VALUES ('MF','어린이자료실','09:00 - 18:00')

INSERT INTO LIBINFO (managecode,STATUS,HOURS)
VALUES ('MF','디지털자료실','09:00 - 18:00')

INSERT INTO LIBINFO (managecode,STATUS,HOURS)
VALUES ('MF','일반열람','07:00 - 22:00')

INSERT INTO LIBINFO (managecode,STATUS,HOURS)
VALUES ('MG','일반열람실','07:00 - 22:00')

INSERT INTO LIBINFO (managecode,STATUS,HOURS)
VALUES ('MG','어린이자료실','09:00 - 18:00')

INSERT INTO LIBINFO (managecode,STATUS,HOURS)
VALUES ('MG','간행물실','09:00 - 18:00')

INSERT INTO LIBINFO (managecode,STATUS,HOURS)
VALUES ('MG','디지털자료실','09:00 - 18:00')

INSERT INTO LIBINFO (managecode,STATUS,HOURS)
VALUES ('MG','종합자료실','09:00 - 20:00')

INSERT INTO LIBINFO (managecode,STATUS,HOURS)
VALUES ('MH','인문사회과학실','09:00 - 20:00')

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


//SUGGESTBOARD 건의사항 게시판
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

//SUGGESTCOMMENT 건의사항 게시판 댓글
CREATE TABLE SUGGESTCOMMENT(
CMTNUM NUMBER NOT NULL,
BBSNUM NUMBER NOT NULL,
CMTID varchar2(30),
CMTDATE DATE DEFAULT sysdate NOT NULL,
CMTCONTENT varchar2(1000) NOT NULL
);

ALTER TABLE SUGGESTCOMMENT ADD CONSTRAINT fk_suggestboard
FOREIGN key(bbsnum) REFERENCES suggestboard(num);


