/* SYNTAX :
UPDATE tablo_adi
SET sutun_adi = yeni deger
WHERE sutun_adi;
*/
-- NOT : Day04_OrnekFkPk'da olusturdugum tablolari buraya aktariyorum.

CREATE TABLE tedarikciler
(
        vergi_no NUMBER(3),
        firma_ismi VARCHAR2(50),
        irtibat_ismi VARCHAR2(50),
        CONSTRAINT pk_ted PRIMARY KEY (vergi_no)
);
    INSERT INTO tedarikciler VALUES (101, 'IBM', 'Kim Yon');
    INSERT INTO tedarikciler VALUES (102, 'Huawei', 'Cin Li');
    INSERT INTO tedarikciler VALUES (103, 'Erikson', 'Maki Tammamen');
    INSERT INTO tedarikciler VALUES (104, 'Apple', 'Adam Eve');
    
    SELECT * FROM tedarikciler;
    
CREATE TABLE urunler
(
         ted_vergino NUMBER(3), 
        urun_id NUMBER(11), 
        urun_isim VARCHAR2(50), 
        musteri_isim VARCHAR2(50),
        CONSTRAINT fk_urunler FOREIGN KEY (ted_vergino) REFERENCES tedarikciler (vergi_no)
);
    INSERT INTO urunler VALUES(101, 1001, 'Laptop', 'Ayse Can');
    INSERT INTO urunler VALUES(102, 1002, 'Phone', 'Fatma Aka');
    INSERT INTO urunler VALUES(102, 1003, 'TV', 'Ramazan Oz');
    INSERT INTO urunler VALUES(102, 1004, 'Laptop', 'Veli Han');
    INSERT INTO urunler VALUES(103, 1005, 'Phone', 'Canan Ak');
    INSERT INTO urunler VALUES(104, 1006, 'TV', 'Ali Bak');
    INSERT INTO urunler VALUES(104, 1007, 'Phone', 'Aslan Yilmaz');

    SELECT * FROM tedarikciler;
    SELECT * FROM urunler;
    
/*-----------------------------------------------------------------------------
  ORNEK 1 :  vergi_no’su 101 olan tedarikcinin ismini ‘LG’ ve guncelleyin.
-----------------------------------------------------------------------------*/
    UPDATE tedarikciler
    SET firma_ismi = 'LG'
    WHERE vergi_no = 101; -- Tedarikciler'deki vergi_no'u 101 olanlarin firmasin LG yapti.
    SELECT * FROM tedarikciler;
    SELECT * FROM urunler;
    
/*-----------------------------------------------------------------------------
  ORNEK 2 :  Tedarikciler tablosundaki tum firma isimlerini SAMSUNG olarak guncelleyin
-----------------------------------------------------------------------------*/   
    UPDATE tedarikciler
    SET firma_ismi = 'SAMSUNG'; -- Suan bunu kullanmiyorum fakat WHERE olmadan da yaziliyor, boyle yazilinca butun firma ismini SAMSUNG yapar.
    
    -- DROP TABLE tablonun icerisini siler , tabloyu da siler . FAKAT biz DELETE kullanirsak tabloyu degil SADECE icerigini siler. 
    DELETE FROM tedarikciler;
    SELECT * FROM tedarikciler;
    SELECT * FROM urunler;
    
/*-----------------------------------------------------------------------------
  ORNEK 3 :  vergi_no'su 102 olan tedarikcinin ismini 'SAMSUNG' ve irtibat_ismi'ni 'Ali Veli' Yapalim.
-----------------------------------------------------------------------------*/  
    UPDATE tedarikciler
    SET firma_ismi = 'SAMSUNG' , irtibat_ismi = 'Ali Veli' -- Birden fazla veri guncellerken , ile ayirarak guncelleme yapabiliriz.
    Where vergi_no = 102;
    SELECT * FROM tedarikciler;
    
/*-----------------------------------------------------------------------------
  ORNEK 4 :  firma_ismi Samsung olan tedarikcinin irtibat_ismini 'Ayse Yilmaz' olarak güncelleyiniz.
-----------------------------------------------------------------------------*/  
    UPDATE tedarikciler
    SET irtibat_ismi = 'Ayse Yilmaz'
    WHERE firma_ismi = 'SAMSUNG';
    SELECT * FROM tedarikciler;
    
 /*-----------------------------------------------------------------------------
  ORNEK 6 : urunler tablosundaki urun_id degeri 1004'ten buyuk olanlarin urun_id degerlerini bir arttiriniz.
 -----------------------------------------------------------------------------*/   
    UPDATE urunler 
    SET urun_id = urun_id + 1
    WHERE urun_id > 1004;
    SELECT * FROM urunler;
    
 /*-----------------------------------------------------------------------------
  ORNEK 7 : urunler tablosundaki tüm urunlerin urun_id degerini ted_vergino sutun degerleri ile toplayarak guncelleyiniz.
 -----------------------------------------------------------------------------*/  
    UPDATE urunler
    SET urun_id = urun_id + ted_vergi_no; -- Butun satirlar icin yapacagimiz icin WHERE ' e gerek yok.
    SELECT * FROM urunler;
    
 /*-----------------------------------------------------------------------------
   ORNEK 8 : urunler tablosundan Ali Bak’in aldigi urunun ismini, tedarikci 
   tablosunda irtibat_ismi ‘Adam Eve’ olan firmanin ismi (firma_ismi) ile degistiriniz
-----------------------------------------------------------------------------*/  
    UPDATE urunler
    SET urun_ismi = (SELECT firma_ismi FROM tedarikciler
                               WHERE irtibat_ismi = 'Adam Eve') -- Atama yaptigim icin hata vermesin diye parantez icine aldim.
    WHERE musteri_isim = 'Ali Bak';
    
 /*------------------------------------------------------------------------------
    ORNEK9: Laptop satin alan musterilerin ismini, Apple’in irtibat_isim'i ile degistirin
 -----------------------------------------------------------------------------*/   
    UPDATE urunler
    SET musteri_isim = (SELECT irtibat_ismi FROM tedarikciler WHERE firma_ismi = 'Apple')
    WHERE urun_isim = 'Laptop';
    SELECT * FROM urunler;
    
    
    DROP TABLE tedarikciler;
    DROP  TABLE urunler;
