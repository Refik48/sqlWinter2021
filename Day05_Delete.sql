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

ROLLBACK; -- DELETE ile silenen verileri geri getirir.(Ben de calismadi ama oyleymis)

DROP TABLE ogrenciler; -- DDL KOMUTUDUR. 
-- Suan Tablomuz veritabani cop kutusunda, geri getirmek mumkun. Solda en altlarda Recycle Bin'in icinde DROP komutu ile silinmis tablolar bulunmaktadir.
-- Eger oradaki tablolardan birine -> Sag klik -> Purge -> Apply ile silinir.

-- EGER Tabloyu Recyle Bin'e atmadan direkt olarak komple silmek istersek,
DROP TABLE ogrenciler PURGE; -- Komutu kullanabiliriz.

-- COP KUTUSUNDAN BIR TABLO GETIRMEK ICIN ;
-- Dropla sildigimizi geri almak istersek -> Sag klik -> Flashback to Before Drop -> geri alindiginda ismi ne olsun diye soruyor isim yazip Apply diyoruz.
FLASHBACK TABLE ogrenciler TO BEFORE DROP; -- Ayni isimle geri getirir. Flashbackle geri getirilemez.

/*=========================== TRUNCATE ===========================*/

-- DELETE gibi tum verileri siler. Secmeli silme yapamaz. (DDL Komutudur).
-- Truncate ile silme yapildiginda ROLL BACK ile geri alma YAPILAMAZ, hassas silme islemi yapar.

/*======================== DELETE - TRUCATE - DROP FARKLARI ============================  
   
    1-) TRUNCATE komutu DELETE komutu gibi bir tablodaki verilerin tamamini siler.
    Ancak, seçmeli silme yapamaz. Cunku Truncate komutu DML degil DDL komutudur.
    
    2-) DELETE komutu beraberinde WHERE cumlecigi kullanilabilir. TRUNCATE ile kullanilmaz.
    
    3-) Delete komutu ile silinen veriler ROLLBACK komutu ile kolaylikla geri alinabilir.
    
    4-) Truncate ile silinen veriler geri alinmasi daha zordur. Ancak Transaction yöntemi ile geri alinmasi mumkun olabilir.
    
    5-) DROP komutu da bir DDL komutudur. Ancak DROP veriler ile tabloyu da siler. Silinen tablo Veritabaninin geri donusum kutusuna gider. 
    Silinen tablo asagidaki komut ile geri alinabilir. Veya SQL GUI’den geri alinabilir.
       
     FLASHBACK TABLE tablo_adi TO BEFORE DROP;  -> tabloyu geri alir.
    
     PURGE TABLE tablo_adi;        -> Geri donusumdeki tabloyu siler.
           
     DROP TABLE tablo_adi PURGE;  -> Tabloyu tamamen siler
==============================================================================*/
TRUNCATE TABLE ogrenciler; -- Tum verileri hassas bir sekilde siler (DDL yani WHERE gibi clause kelimeler kullanilamaz.)
SELECT * FROM ogrenciler;

/*============================== ON DELETE CASCADE =============================
  Her defas?nda önce child tablodaki verileri silmek yerine ON DELETE CASCADE
  silme özelli?ini aktif hale getirebiliriz.
  Bunun için FK olan sat?r?n en sonuna ON DELETE CASCADE komutunu yazmak yeterli
==============================================================================*/ 
-- ========================= Tablolar aras?nda ili?ki var ise veriler nas?l silinebilir? =========================
CREATE TABLE talebeler
(
        id CHAR(3),  --PK
        isim VARCHAR2(50),
        veli_isim VARCHAR2(50),
        yazili_notu NUMBER(3),
        CONSTRAINT talebe_pk PRIMARY KEY (id)
); 
INSERT INTO talebeler VALUES(123, 'Ali Can', 'Hasan',75);
INSERT INTO talebeler VALUES(124, 'Merve Gul', 'Ayse',85);
INSERT INTO talebeler VALUES(125, 'Kemal Yasa', 'Hasan',85);
INSERT INTO talebeler VALUES(126, 'Nesibe Y?lmaz', 'Ayse',95);
INSERT INTO talebeler VALUES(127, 'Mustafa Bak', 'Can',99);
 CREATE TABLE notlar 
( 
        talebe_id char(3), --FK
        ders_adi varchar2(30), 
        yazili_notu number (3), 
        CONSTRAINT notlar_fk FOREIGN KEY (talebe_id) 
        REFERENCES talebeler(id) ON DELETE CASCADE
);
INSERT INTO notlar VALUES ('123','kimya',75);
INSERT INTO notlar VALUES ('124', 'fizik',65);
INSERT INTO notlar VALUES ('125', 'tarih',90);
INSERT INTO notlar VALUES ('126', 'Matematik',90);

SELECT * FROM ogrenciler;
SELECT * FROM talebeler;

DROP TABLE notlar;
DROP TABLE talebeler;

-- id'si 124 olan kisiyi siliniz.
-- 1. YOL
DELETE FROM notlar
WHERE talebe_id = 124; -- Once Child'i sildik sonra parenti silmek zorundayiz.
DELETE FROM talebeler
WHERE id = 124; -- 124 id'li kisinin CHILD'da verisi oldugu icin ONCE CHILD verisi silinmeli daha sonra PARENT'dan silinebilir.
-- Aksi takdirde hata verir.

--2. YOL
-- Eger CONSTRAINT kismina ON DELETE CASCADE yazarsak Yukardaki gibi 2 kez yazmamiza gerek kalmaz SQL otomatik baglantili verileri de siler.
DELETE FROM talebeler
WHERE id = 124;




