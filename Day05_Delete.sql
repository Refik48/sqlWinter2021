/* =========================== DELETE =========================== */

-- DELETE FROM tablo_adi;     Tablonun tum icerigini siler.
-- Bu komut tabloyu manipule ettigi icin bir DML komutudur. DML komutu oldugu icin devaminda WHERE gibi cumlecikler kullanilabilir.

-- DELETE FROM tablo_adi;
-- WHERE sutun_adi = veri;

CREATE TABLE ogrenciler
(
        id CHAR(3),
        isim VARCHAR(50),
        veli_isim VARCHAR2(50),
        yazili_notu NUMBER(3)
);

INSERT INTO ogrenciler VALUES(123, 'Ali Can', 'Hasan',75);
INSERT INTO ogrenciler VALUES(124, 'Merve Gul', 'Ayse',85);
INSERT INTO ogrenciler VALUES(125, 'Kemal Yasa', 'Hasan',85);
INSERT INTO ogrenciler VALUES(126, 'Nesibe Yilmaz', 'Ayse',95);
INSERT INTO ogrenciler VALUES(127, 'Mustafa Bak', 'Can',99);

SELECT * FROM ogrenciler;
DROP TABLE ogrenciler;

-- ============== Secerek silmek icin WHERE Anahtar kelimesi kullanilabilir=================
-- id'si 124 olan ogrenciyi silin.
DELETE FROM ogrenciler
WHERE id = 124;
SELECT * FROM ogrenciler;

-- Adi Kemal olan ogrenciyi silelim.
DELETE FROM ogrenciler
WHERE isim = 'Kemal Yasa';
SELECT * FROM ogrenciler;

-- Adi Nesibe Yilmaz ve Mustafa Bak olan kayitlari silin.
DELETE FROM ogrenciler
WHERE isim = 'Nesibe Yilmaz' OR  isim = 'Mustafa Bak'; -- AND neden koymadik ? Cunku isim hem Nesibe Yilmaz hem Mustafa Bak olmuyor OR kullanilmali.
SELECT * FROM ogrenciler;

-- Ismi Ali Can ve id'si 123 olan ogrenciyi silin.
DELETE FROM ogrenciler
WHERE isim = 'Ali Can' AND id = 123; -- AND ile bagladigimda ismi ali can olan ve id'si 123 olana bakti. Tek satir silmek icin AND ile bagdastirilir.
SELECT * FROM ogrenciler;

-- id'si 126'dan buyuk olan kayitlari silelim.
DELETE FROM ogrenciler
WHERE id>126; -- 1 tane vardi (127) .
SELECT * FROM ogrenciler;

-- id;si 123, 125 ve 126 olanlari silelim.
DELETE FROM ogrenciler
WHERE id IN(123,125,126);    -- veya WHERE id = 123 OR id = 125 OR id = 126 seklinde de yazilabilir.
SELECT * FROM ogrenciler;

-- Tablodaki tum tayitlari silelim.
SELECT * FROM ogrenciler;
DELETE FROM ogrenciler; -- DELETE FROM ile Where clause birlikte kullanilmazsa tablonun butun icerigini siler.
--Tabloyu silmez cunku tabloyu DROP ile siler ve veritabaninin cop kutusuna gonderir.

DROP TABLE ogrenciler; -- DDL KOMUTUDUR. 
-- Suan Tablomuz veritabani cop kutusunda, geri getirmek mumkun. Solda en altlarda Recycle Bin'in icinde DROP komutu ile silinmis tablolar bulunmaktadir.
-- Eger oradaki tablolardan birine -> Sag klik -> Purge -> Apply ile silinir.

-- EGER Tabloyu Recyle Bin'e atmadan direkt olarak komple silmek istersek,
DROP TABLE ogrenciler PURGE; -- Komutu kullanabiliriz.

-- COP KUTUSUNDAN BIR TABLO GETIRMEK ICIN ;
-- Dropla sildigimizi geri almak istersek -> Sag klik -> Flashback to Before Drop -> geri alindiginda ismi ne olsun diye soruyor isim yazip Apply diyoruz.
FLASHBACK TABLE ogrenciler TO BEFORE DROP; -- Ayni isimle geri getirir. Flashbackle geri getirilemez.





/*======================== DELETE - TRUCATE - DROP ============================  
   
    1-) TRUNCATE komutu DELETE komutu gibi bir tablodaki verilerin tamam?n? siler.
    Ancak, seçmeli silme yapamaz. Çünkü Truncate komutu DML de?il DDL komutudur.
   
    2-) DELETE komutu beraberinde WHERE cümleci?i kullan?labilir. TRUNCATE ile
    kullan?lmaz.
   
    3-) Delete komutu ile silinen veriler ROLLBACK Komutu ile kolayl?kla geri
    al?nabilir.
   
    4-) Truncate ile silinen veriler geri al?nmas? daha zordur. Ancak
    Transaction yöntemi ile geri al?nmas? mümkün olabilir.
   
    5-) DROP komutu da bir DDL komutudur. Ancak DROP veriler ile tabloyu da
    siler. Silinen tablo Veritaban?n?n geri dönü?üm kutusuna gider. Silinen
    tablo a?a??daki komut ile geri al?nabilir. Veya SQL GUI’den geri al?nabilir.
       
     FLASHBACK TABLE tablo_ad? TO BEFORE DROP;  -> tabloyu geri al?r.
    
     PURGE TABLE tablo_ad?;        -> Geri dönü?ümdeki tabloyu siler.
           
     DROP TABLE tablo_ad? PURGE;  -> Tabloyu tamamen siler
==============================================================================*/








