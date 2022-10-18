CREATE  SEQUENCE book_num
INCREMENT BY 1
START WITH 1
MINVALUE 1
nomaxvalue 
nocycle
nocache


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
title varchar2(100) NOT NULL ,  
content varchar2(600) NOT NULL ,
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


INSERT INTO NOTICE ( num, NAME,TITLE,CONTENT,OFILE,SFILE,managecode,id)
VALUES (NOTICE_num.nextval,'강동도서관','마스크 착용 방역지침 준수 안내','서울시에서 마스크 착용 방역지침 준수명령 지도점검을 시행합니다.
실내 마스크 미착용 적발 시, 횟수와 관계없이 10만원 이하의 과태료가 부과되오니, 반드시 마스크 착용을 부탁드립니다.
기간은 9월26일 부터 별도 안내 시까지 진행됩니다.',' ', ' ','MB','admin')

INSERT INTO NOTICE ( num, NAME,TITLE,CONTENT,OFILE,SFILE,managecode,id)
VALUES (NOTICE_num.nextval,'강서도서관','2022년 희망도서 신청 마감안내','2022년 희망도서 신청 마감 안내
한 해 동안 희망도서 신청서비스를 이용해 주신 모든 분께 감사드립니다.
서울시 22개 공공도서관의 희망도서 신청을
2022년 11월 19일(토)까지 마감할 예정임을 알려드립니다.
2022년 11월 20일 이후에 신청하신 희망도서는 2023년 구입 예정이오니
시민 여러분들의 많은 양해 바랍니다.
관련 문의사항은 도서관 장서개발팀으로 연락주시면 상세한 답변 드리겠습니다.',' ', ' ','MC','admin')

INSERT INTO NOTICE ( num, NAME,TITLE,CONTENT,OFILE,SFILE,managecode,id)
VALUES (NOTICE_num.nextval,'서대문도서관','화장실 리모델링 공사 안내','화장실 리모델링 공사 안내문 도서관 노후시설(화장실) 개선공사를 실시할 예정입니다.
이용불편을 최소화 하기 위해 4층 화장실 공사를 최대한 늦게 실시합니다.
4층 화장실 공사가 시작될 시 외부 공원 화장실을 이용하여주시기 바랍니다.
구체적인 공사 일정은 나오지 않아 안내 못드리는점 죄송합니다.
공사기간: 2022년 10월 17일(월) ~ 12월25일(일)
공사내용: 실내 전체 인테리어 리모델링
이용에 불편을 드려 대단히 죄송합니다.
',' ', ' ','MP','admin')

INSERT INTO NOTICE ( num, NAME,TITLE,CONTENT,OFILE,SFILE,managecode,id)
VALUES (NOTICE_num.nextval,'개포도서관','이호영 작가 북토크 모집 안내','<나의 첫 책> 프로젝트
이호영 작가 북토크 모집
-1930년대 경성, 일제 강점기를 살아가는 소녀 미용사 인덕이의 파란만정 성장기
○ 도서명: 경성 최고 화신미용실입니다
○ 저자: 이호영
○ 일시: 2022. 10. 30.(일) 14시
○ 장소: 개포도서관 1층 로비
○ 신청기간: 2022. 10. 14.(금~10.29.(토)
○ 신청방법: 네이버 폼( 위 안내문의 큐알코드 연결 또는 https://naver.me/xKWBlFIn )
○ 인원: 30명 선착순 접수:
○ 참가비: 무료
○ 문의: 02-6339-1232, prm_team1@prm.co.kr',' ', ' ','MD','admin')

INSERT INTO NOTICE ( num, NAME,TITLE,CONTENT,OFILE,SFILE,managecode,id)
VALUES (NOTICE_num.nextval,'고척도서관','그린커튼과 함께하는 푸른숲 도서관','그린커튼과 함께하는 푸른숲 도서관
○ 그린커튼 연계 자연이야기
  - 운영기간: 2022. 10. 25.(화) 16시~18시
  - 운영대상: 성인 10명
  - 운영내용: 그린커튼 열매를 이용한 수세미청, 작두콩차 만들기
  - 접수기간: 2022. 10. 14.(금) 10시~ 배움숲홈페이지
○ 교과연계 그린커튼 융합활동
  - 운영기간: 2022. 10. 29.(토)~11. 5.(토)
  - 운영대상: 초등3,4학년 10명(성남시민)
  - 운영내용: 그린커튼을 관찰하고 교과와 연계한 융합활동
  * 개인준비물: 필기도구',' ', ' ','MF','admin')

INSERT INTO NOTICE ( num, NAME,TITLE,CONTENT,OFILE,SFILE,managecode,id)
VALUES (NOTICE_num.nextval,'송파도서관','숲은 내친구 참여가족 모집안내','(숲은 내친구)참여가족 모집안내
○ 운영일시: 2022. 10. 29 (토) A반 10:00 - 12:00 (10팀)
B반 13:00 - 15:00 (10팀)
○ 접수기간: 2022. 10. 20 (목) ~ 마감시
○ 접수방법: 성남시 “배움 숲” 온라인 선착순 접수
○ 운영방법: 대면 강좌(송파도서관)
○ 대 상: 초등1-3학년 학생과 보호자 1인
○ 내 용: 숲놀이를 통해 신체감각을 익히며 다양한 놀잇감을 통해 가족의 친밀함을 높인다.
목록',' ', ' ','MW','admin')

INSERT INTO NOTICE ( num, NAME,TITLE,CONTENT,OFILE,SFILE,managecode,id)
VALUES (NOTICE_num.nextval,'도봉도서관','2022년 10월 체험형 동화구연 운영안내','*체험형 동화구연이란?
대형 화면 속 스크린을 통해 펼쳐지는 가상공간에서 어린이들이 동화 속 주인공이 되어 체험하는 프로그램입니다.
*대상 : 5-7세 어린이
*일시 : 10월5일, 12일, 19일, 26일
매주 수요일 15:00-16:00(1차시), 16:00-17:00(2차시)
*접수 : 배움숲 선착순 접수
성남시 평생학습포털 배움숲(http://sugang.seongnam.go.kr/) 선착순 접수
※9월16일(금요일) 오전10:00부터 일괄 접수입니다.',' ', ' ','MJ','admin')

INSERT INTO NOTICE ( num, NAME,TITLE,CONTENT,OFILE,SFILE,managecode,id)
VALUES (NOTICE_num.nextval,'양천도서관','수해복구에 따른 주차장 사용 잠정 중단 알림','양천도서관에서 알려드립니다.
8.8~8.10 집중호우로 인해 운중도서관 주차장 지반이 침하되어 붕괴 위험이 있습니다.
복구작업에 의해 당분간 주차장 사용이 불가함을 알려드리니 양지하여 주시기 바라며,  조속히 처리하도록 노력하겠습니다.
추후 일정은 다시 공지하도록 하겠습니다.
기간: 22.8.09 ~ 복구시까지',' ', ' ','MN','admin')

INSERT INTO NOTICE ( num, NAME,TITLE,CONTENT,OFILE,SFILE,managecode,id)
VALUES (NOTICE_num.nextval,'동작도서관','10월 체험형 동화구연 안내','2022년 체험형 동화구연 운영 안내
- 접수일시: 2022년 10월 18일(화)~ "배움숲" 선착순 마감시 까지
- 접수대상: 어린이(5~8세)
- 운영내용: 10월 26일(수) 16:00~18:00 / 아기돼지삼형제 체험형 동화구연 운영
- 운영방법: 지하1층 병아리교실, 대면프로그램',' ', ' ','ML','admin')

INSERT INTO NOTICE ( num, NAME,TITLE,CONTENT,OFILE,SFILE,managecode,id)
VALUES (NOTICE_num.nextval,'강서도서관','동절기(11월 ~ 2월) 도서관 운영시간 안내','▷동절기 도서관 운영시간 안내
중원어린이도서관 운영시간이 동절기에는 아래와 같이 변경운영되오니. 이용에 참고하시기 바랍니다.
동절기 (11월~2월) 평일 및 주말 운영시간 - 09:00~18:00
*주말운영시간은 현재와 동일.(09:00~18:00)',' ', ' ','MC','admin')

INSERT INTO NOTICE ( num, NAME,TITLE,CONTENT,OFILE,SFILE,managecode,id)
VALUES (NOTICE_num.nextval,'강남도서관','강남도서관 카카오톡 채널 서비스 안내','Q. 채널 추가는 어떻게 하나요?
1. 카카오톡 친구 검색창에서 ‘강남도서관’ 검색하고 채널 추가
2. 스마트폰 카메라에서 QR코드 스캔
두 가지 중 편한 방식으로 추가하시면 됩니다
Q. 어떤 정보를 확인할 수 있나요?
중원도서관 공지사항, 신착자료, 추천도서를 확인할 수 있는 홈페이지 링크로 연결됩니다.

○ 채팅방 메뉴
- 공지사항
- 신착도서
- 추천도서
카카오톡 채널 추가 이벤트도 진행 예정이니 많은 관심 부탁드립니다.',' ', ' ','MA','admin')