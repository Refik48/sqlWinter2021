---------------------------------SELECT KOMUTU------------------------------------
CREATE TABLE ogrenciler
(
        id NUMBER(9),
        isim VARCHAR(50),
        adres VARCHAR2(100),
        sinav_notu NUMBER(3)
);
-- Not : Eger harfleriniz kucuk kaldiysa RUN tusunun en sagindaki fonksyionel tusu kullanabilirsin buyutmek icin.

INSERT INTO ogrenciler VALUES(123, 'Kazim Nihat', 'Bursa', 85);
INSERT INTO ogrenciler VALUES(124, 'Elif Sude', 'Ankara', 99);
INSERT INTO ogrenciler VALUES(125, 'Ipeksu', 'Istanbul', 80);
INSERT INTO ogrenciler VALUES(126, 'Bilge Su', 'Izmir', 75);
INSERT INTO ogrenciler VALUES(127, 'Fatma', 'Tokat', 90);

DROP TABLE ogrenciler;
SELECT * FROM ogrenciler;

SELECT * FROM ogrenciler WHERE sinav_notu>80; -- Where kismini asagi'da indirebiliriz cunku SQL okumayi ; isaretine kadar yapacaktir.

SELECT isim,sinav_notu -- Sinav notu 80'den buyuk olanlarin isim ve sinav_notu'nu getir dedim.
FROM ogrenciler -- Ogrenciler tablosundan
WHERE sinav_notu>80; -- Sinav Notu 80'den buyuk olanlari goster dedim .

SELECT *FROM ogrenciler
WHERE adres = 'Ankara';

SELECT * FROM ogrenciler
WHERE id = 123; -- SORGULARKEN yani burada DATA TYPE'i NUMBER olanlari ,
-- ' ' icine yazmaktansa normal bir sekilde yazip aratmak daha saglikli sonuclar verir.
-- ' ' icinde olmaz mi ? Olur fakat hata verebilir ve hata verirse nerede oldugunu bulamayiz o yuzden ' ' icinde yazmamak daha iyi.
/*
=                  ==> Esit mi ?
>                  ==> Buyuk mu ?
<                  ==> Kucuk mu ?
>=               ==> Buyuk esit mi ?
<=               ==> Kucuk esit mi ?
<>               ==> Esit degil mi ?
AND           ==> Ve Operator'u
OR              ==> Veya Operator'u
BETWEEN ==> Belirtilen degerler arasindaki veriler icin. Iki mantiksal ifade ile tanimlayabilecegimiz durumlari tek komutla yazabilme imkani verir.
NOT BETWEEN ==> Arasinda olmayanlari gosterir.
IN               ==> Bir sutun icin bir cok uygun kosulu secmek icin
LIKE          ==> sorgulama yaparken belirli patternleri kullanabilmemize olanak saglar. 
    Pattern icin % ---> 0 veya daha fazla karakteri belirtir,
    Pattern icin _ ---> Tek bir karakteri temsil eder.
*/
------- ISARET OPERATORLERI KULLANMAK ------
CREATE TABLE personel
    (   
        id CHAR(5),
        isim VARCHAR2(50),
        maas NUMBER(5)
);
INSERT INTO personel VALUES('10001', 'Ahmet Aslan', 7000);
INSERT INTO personel VALUES( '10002', 'Mehmet Yilmaz' ,12000);
INSERT INTO personel VALUES('10003', 'Nihat ', 7215);
INSERT INTO personel VALUES('10004', 'Veli Han', 5000);
INSERT INTO personel VALUES('10005', 'Mustafa Ali', 5500);
INSERT INTO personel VALUES('10006', 'Ayse Can', 4000);

SELECT * FROM personel;

/*==================================== BETWEEN ====================================*/
-- id'si 10002 ile 10005 arasinda olan personelin tum bilgilerini listeleyin.
SELECT * FROM personel
WHERE id>='10002' AND id<='10005';

SELECT * FROM personel
WHERE id BETWEEN '10002' AND '10005'; -- Between dedigimizde 10002 ve 10005'lerde dahildir.

-- Mehmet Yilmaz ile Veli Han arasindaki Personel bilgilerini listeleyin.
SELECT * FROM personel
WHERE isim BETWEEN 'Mehmet Ali' AND 'Veli Han';

-- NOT BETWEEN Arasinda olmayanlari gosterir.
-- id'si 10002 ile 10004 arasinda olmayan personelin tum bilgilerini yazdirin.
SELECT * FROM personel
WHERE id NOT BETWEEN '10002' AND '10004'; -- 10002 ve 10004'de dahil bu NOT BETWEEN'e

/*==================================== IN ====================================*/
-- id'si 10001, 10002 ve 10004 olanlari listeleyin.
-- OR yontemi ile
SELECT * FROM personel
WHERE id ='10002' OR id='10001' OR id ='10004';

-- IN yontemi ile
SELECT * FROM personel
WHERE id IN ( '10001', '10002', '10004');

-- Maas'i SADECE 7000 ile 12000 olan personelin bilgilerini listeleyelim.
SELECT * FROM personel
WHERE maas IN (7000,12000); -- IN'de aralik yoktur, esitlik vardir. Yani maas'i 8000 olani gostermeyecek sadece 7000 ve 12000 olanlari gosterecek.

/*==================================== LIKE ====================================*/
/*LIKE            ==> sorgulama yaparken belirli patternleri kullanabilmemize olanak saglar. 
    Pattern icin % ---> 0 veya daha fazla karakteri belirtir,
    Pattern icin _ ---> Tek bir karakteri temsil eder.
Ornegin ; WHERE isim LIKE 'A%' ismi A ile baslayanlari listeler.
               WHERE isim LIKE '%n' ismi n ile bitenleri listeler.
               WHERE isim LIKE 'he%' isminde he olanlari listeler.
               WHERE isim LIKE '_ih%' isminin 2. harfi i ve 3. harfi h olanlari listeler.
               WHERE isim LIKE '_ih' SADECE ismi 3 harfli olan ve 2. harfi i ve 3. harfi h olanlari listeler.
               WHERE isim LIKE '_a%y%' isminin 2. harfi a ve geri kalan kisimda y harfi bulunanlari sorgular.
               WHERE isim LIKE '__z__' ismi 5 harfli olup 3. harfi k olanlari sorgular.
               WHERE maas LIKE '_____' maasi 5 basamakli olanlari sorgular. _ bir karakterdir.
               */
SELECT * FROM personel
WHERE isim LIKE 'M%'; -- Ismi M ile baslayanlari goster.

SELECT * FROM personel
WHERE isim LIKE '______'; -- Ismi 5 karakterli olanlari gosterir

SELECT * FROM personel
WHERE isim LIKE '_e%'; -- 2. Harfi e olanlar

SELECT * FROM personel
WHERE maas LIKE '%00'; -- Son 2 hanesi 00 olanlari gosterir.

SELECT * FROM personel
WHERE isim LIKE 'A_____a%'; -- 1. Harfi A ve 7. Harfi a olanlari listerler.

SELECT * FROM personel
WHERE isim LIKE '%an%'; -- Isminde an gecenleri listeler.

SELECT * FROM personel
WHERE maas LIKE '_____'; -- Maas'i 5 basamakli olanlari gosterir.

SELECT * FROM personel
WHERE maas NOT LIKE '____' ; -- Maas'i 4 basamakli olmayanlari gosterir.

SELECT * FROM personel
WHERE isim LIKE '_e%z%'; -- 2. harfi e olan geri kalanin z olan ismi verir. (Son harf dahil)

-- DEVAMI "Day04_Select" kisminda.

 
 
 
 
 
 
 
 
 
 
 