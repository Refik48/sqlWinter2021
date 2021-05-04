-- TABLO OLUSTURMAK ICIN 

CREATE TABLE student
(
        std_id CHAR(3), -- id 3 haneli olsun dedim
        std_name VARCHAR(20),
        std_age NUMBER    -- SON YAZDIGIM ELEMANIN SONUNA " , " koymuyoruz.
);
-- Tabloya veri eklemek ; Butun degerler girilmek zorundadir eger deger girilmezse hata verir eger parcali giris yapmak istiyorsan 17. satira bak
INSERT INTO student VALUES('100', 'Kazim Nihat', 24);
INSERT INTO student VALUES('101', 'Elif Sude', 20);
INSERT INTO student VALUES('102', 'Ipek', 23);
INSERT INTO student VALUES('103', 'Bilgesu', 23);
INSERT INTO student VALUES('105', 'Fatma', ''); -- Tirnak ile oraya null atanabilir.
-- Char ve Varchar'lar tirnak (' ') icinde yazilir. Number'lar normal yazilir.

-- Parcali Giris Yapmak icin ;
INSERT INTO student(std_id,std_name) VALUES('104', 'Stewie Griffin'); -- Sadece id ve name girdim

SELECT * FROM student; -- * = Her sey anlamindadir. student tablosundaki her seyi getir dedim. Yani bu komutla Veri sorgulama islemi yapiyorum.
-- Direkt olarak run tusuna basarsan calismayacaktir. Burada run edecegin seyi mouse ile secmen gerekiyor gerekiyor. 
-- Toplu bir sekilde direkt olarak secebilirsin ama aradaki 19. satir olan Drop'a dikkat et tabloyu siliyor.

DROP TABLE student; -- TABLO SILMEYE YARIYOR.(Icerigini degil kendisini TABLES kategorisinden siler)

-- URUNLER ADINDA TABLO OLUSTUR. ICERISINE id,adi,fiyat,TETT,stok_adedi KOY.

CREATE TABLE urunler
(
        urun_id NUMBER,
        urun_adi VARCHAR2(50),
        fiyat NUMBER(5,2),
        tett DATE,
        stok_adedi NUMBER(10)
);

INSERT INTO urunler VALUES (101, 'CIPS', 5.5021, '01-Apr-2021', 500);
INSERT INTO urunler VALUES(102,'BISKUVI',2.50,'01-Feb-2024',300);
INSERT INTO urunler VALUES(103,'GOFRET',1.50,'05-Jan-2023',120);
INSERT INTO urunler VALUES(104,'KOLA',4.50,'21-Jun-2025',50);
INSERT INTO urunler VALUES(105,'AYRAN',2.50,'01-Aug-2021',5);
-- Tarih'ler onemli nasil yazildigini bulmak icin Prefences'e git NLS yaz araya hangi isaretlemeyi koyacagin orada yaziyor. 
-- Benim bilgisayar icin Ay'i number kabul etmiyor. Ay'larin isimleri ile yazmak gerekiyor.
SELECT * FROM urunler;

DROP TABLE urunler;

