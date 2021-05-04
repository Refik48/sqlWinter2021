/* CRUD ;
C => CREATE TABLE
R => SELECT * FROM student
U => INSTERT INTO student VALUES
D => DROP TABLE student
Gecen ders bunlari gorduk bugun ki derste "CONSTRAINTS (KISITLAMALAR)"i gorecegiz.

SQL kisitlamalari ile bir tablodaki veriler icin kurallar belirlenebilir.
Kisitlamalar ile verinin turu ve alacagi degerlere sinirlandirma koyulabilir.
Boylece, tablodaki verinin dogrulugu ve guvenirligi saglanabilir.
Eger, bir veri islemi sirasinda kisitlamaya uygun olmayan bir islem gerceklesirse bu islem kisitlama sayesinde gecersiz olacagindan otomatik olarak iptal edilir.
Kisitlamalar "Sutun" veya "Tablo" seviyesinde uygulanabilir. Eger tablo seviyesinde konulursa tum tabloyu kapsamis olur.
Ornegin : Null olmasin bos deger girilemesin diye kisitlama getirebilirim. 
Primary Key (TC no gibi essiz veriler) aslinda birer Constraints'dir.

Yaygin kullanilan kisitlamalar :
- NOT NULL => Bir sutunun NULL icermemesini garanti eder.
- UNIQUE => Bir sutundaki tum degerlerin BENZERSIZ olmasini garanti eder.
- PRIMARY KEY => Bir sutunun NULL icermemesini ve sutundaki verilerin BENZSERSIZ olmasini garanti eder(Nut Null + Unique = Primary Key)
- FOREIGN KEY => Baska bir tablodaki Primary Key'i referans gostermek icin kullanilir. Boylelikle, tablolar Arasinda iliski kurulmus olur.
- CHECK => Bir sutundaki tum verilerin belirlenen ozel bir sarti saglamasini garanti eder.
- DEFAULT => Herhangi bir deger atanamadiginda Baslangic degerinin atanmasini saglar. 
    (Parcali veri girisi yaptigimizda girmedigimiz degerleri Default ile atayabiliriz)
*/

CREATE TABLE calisanlar
(
        id CHAR(5) PRIMARY KEY, -- id degiskeni 5 haneli olacaktir. 
        -- Primary Key'i sonradan ekledikten sonra Kullanilmasi icin ya Update etcez ya da Drop yaptiktan sonra tekrardan Create edecegim.
        isim VARCHAR2(50) NOT NULL UNIQUE, -- isim'e 50 karaktere kadar veri girebilirim.
        maas NUMBER(5) NOT NULL, -- maas'in karakteri max 5 haneli olacak ve
        ise_baslama DATE
);

INSERT INTO calisanlar VALUES('10001', 'Kazim Nihat', 12000, '22-Apr-2021'); 
INSERT INTO calisanlar VALUES('10002', 'Elif Sude', 8000, '06-Aug-2018');
INSERT INTO calisanlar VALUES('10003', 'Fatma', 6000, '7-Feb-2007');
INSERT INTO calisanlar VALUES('10004', 'Murat', 4000, '15-Dec-1998');
INSERT INTO calisanlar VALUES('10005', 'Yusuf Burak', 2000, '30-Mar-2024');
-- INSERT INTO calisanlar VALUES('10005', 'Pilot Kalem', 500, '30-Mar-2024'); -- Bunu ekleyemedim cunku 2 tane 10005 yani Primary Key oldu.
-- INSERT INTO calisanlar VALUES('', 'Pilot Kalem', 500, '30-Mar-2024'); -- Bunu da ekleyemedim cunku Primary Key bos olamaz.
-- INSERT INTO calisanlar VALUES('10006', '', 1230, '23-Mar-2004'); -- name kismi Null olamayacagi icin hata verdi.

SELECT * FROM calisanlar;

DROP TABLE calisanlar;

DELETE calisanlar WHERE id = '10002'; -- id'si 10002 olan veriyi siler.

-- calisanlara sag klik yap Popup Describe'e tikla yukardan "Constraints"e tiklarsak hangi Constraints'ler kullanilmis goruyoruz. 
-- Her Constraint'in SQL tarafindan verilmis random name'i vardir. Bu isim random ve uzun kullanmak istedigimizde yorucu olabiliyor.
-- Eger Popup calismiyorsa soldan Calisanlari secerek Constraints kismina gidebiliriz.

--------------------------------------------- ALNERNATIF PRIMARY KEY TANIMLAMA YONTEMI---------------------------
CREATE TABLE calisanlar
(
        id CHAR(5), -- id degiskeni 5 haneli olacaktir. 
        -- Primary Key'i sonradan ekledikten sonra Kullanilmasi icin ya Update etcez ya da Drop yaptiktan sonra tekrardan Create edecegim.
        isim VARCHAR2(50), -- isim'e 50 karaktere kadar veri girebilirim.
        maas NUMBER(5) NOT NULL, -- maas'in karakteri max 5 haneli olacak ve
        ise_baslama DATE,
        CONSTRAINT id_pk PRIMARY KEY(id) --  DISABLE -- Yazarsam bu satiri kapatir !!!!!!
);
SELECT * FROM calisanlar;
-- FK nasil olusturulur ? EN ALTA SOZEL OLARAK YAZDIM.
-- FK icin 2 yontem vardir;
------------------------------------------1. YONTEM-----------------------------------------------
CREATE TABLE adresler
(
        adres_id CHAR(5) REFERENCES calisanlar(id) , -- Burasi FK olacaksa buraya calisanlar(id)'yi refere ediyoruz 
        -- calisanlar PARENT oldu . adresler ise CHILD olmus oldu.
        sokak VARCHAR(50),
        cadde VARCHAR(30),
        sehir VARCHAR(15)
);
INSERT INTO adresler VALUES ( '10001', 'Mutlu Sokak', '16.cadde', 'Bursa');
INSERT INTO adresler VALUES ( '10002', 'Neseli Sokak', '34.cadde', 'Istanbul');
INSERT INTO adresler VALUES ( '10003', 'Sevincli Sokak', '35.cadde', 'Izmir');
-- INSERT INTO adresler VALUES ( '10006', 'Sevincli Sokak', '35.cadde', 'Izmir');  
-- Parent'da olmayan id'ye child'da ekleme yapilamaz.

SELECT * FROM adresler;
SELECT * FROM calisanlar;
-- Iki Select'ide ayni anda secip, Run'in yanindaki RUN SCRIPT'e basarsak hepsi beraber gozukuyor.

SELECT * FROM calisanlar, adresler
WHERE id = '10001';

DROP TABLE calisanlar; -- (Calisanlar Parent) -- Tablo silerken eger once child'i silmeyip parent'i silmeye kalkarsak hata verir. Once CHILD DROP edilmeli.
DROP TABLE adresler; -- (adresler Child) -- Once CHILD DROP edilmeli daha sonra Parent Drop edilebilir.

------------------------------------------2. YONTEM-----------------------------------------------
CREATE TABLE adresler
(
       adres_id CHAR(5) REFERENCES calisanlar(id) , -- Burasi FK olacaksa buraya calisanlar(id)'yi refere ediyoruz 
        sokak VARCHAR(50),
        cadde VARCHAR(30),
        sehir VARCHAR(15),
        CONSTRAINT id_fk FOREIGN KEY (adres_id) REFERENCES calisanlar(id)
        -- calisanlar PARENT oldu . adresler ise CHILD olmus oldu.
);
/*
FOREIGN KEY (FK) =>
- Ornek olarak : CALISANLAR tablosunu calisanlarin adreslerini iceren ADRESLER adinda bir baska tablo ile iliskilendirelim.
- Bunun icin 2 tablo arasinda PARENT - CHILD iliskisi kurmamiz gerekmektedir.
ADIMLAR : 
1) Parent tabloda (calisanlar) bit sutun Primary Key'i (PK) olmasi gerekmektedir.
2) Child tablomuzu olusturmamiz gerekmektedir. (adresler) Mumkunse farkli isimler vermeliyiz.
3) Tablolar arasi iliski kurabilmek icin CALISANLAR'in PK'sina referans verecek bir FOREIGN KEY tanimlamamiz gerekmektedir.
-- Bir tabloda birden fazla FOREIGN KEY olabilir. 
-- FOREIGN KEY null degeri alabilir.
*/

--------------------------------------------------------------------------------------------------------------------
------------------------------------------- CHECK ve DEFAULT------------------------------------------------
--------------------------------------------------------------------------------------------------------------------
/*
1) CHECK ile bir alana girilebilecek degerleri sinirlayabiliriz.
Ornegin yas sutuna negatif sayi girilmesinin engellenmesi gibi.
2) DEFAULT kisitlamasi ile de veri girisi sirasinda bos birakilan kisimlara null girilmesi yerine belirledigimiz bir degerin girilmesi saglanabilir. 
*/
CREATE TABLE sehirler(
        alan_kodu NUMBER(3) DEFAULT 00,
        isim VARCHAR2(20) DEFAULT 'noname',
        nufus NUMBER(8) CHECK(nufus>0)
);
INSERT INTO sehirler VALUES (16, 'Bursa', 2995000);
INSERT INTO sehirler VALUES ( '', 'Erzincan', 500000); -- TIRNAK ARASINA BOSLUK KOYMA
INSERT INTO sehirler VALUES (03, '', 454800); -- Bos birakildigi zaman SQL diyor ki burasi doldurulacak demek ki ben buraya default atamayayim der.
-- AMA parcali giris yaparsak bos birakilan yerler DEFAULT yerlerle doldurulur. (Not : Create asamasinda Default deger atamazsak SQL'in default'u NULL'dur)
INSERT INTO sehirler(nufus) VALUES (88888); -- Parcali giris
INSERT INTO sehirler VALUES ( '9', 'Urfa', -250554); -- CHECK(nufus>0) yazdigim icin nufus kismina negatif deger yazamiyorum.

SELECT * FROM sehirler;
DROP TABLE sehirler;



