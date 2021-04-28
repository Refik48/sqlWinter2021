/*=========================== EXISTS, NOT EXIST ================================
    EXISTS operatorü bir Boolean operatördür ve true - false de?er döndürür. 
    EXISTS operatorü s?kl?kla Subquery'lerde sat?rlar?n do?rulu?unu test etmek 
    için kullan?l?r.
    
    E?er bir subquery (altsorgu) bir sat?r? döndürürse EXIST operatörü de TRUE 
    de?er döndürür. Aksi takdirde, FALSE de?er döndürecektir.
    
    Özellikle altsorgularda h?zl? kontrol i?lemi gerçekle?tirmek için kullan?l?r
==============================================================================*/
CREATE TABLE mart_satislar 
    (
        urun_id number(10),
        musteri_isim varchar2(50), 
        urun_isim varchar2(50)
    );
    
    CREATE TABLE nisan_satislar 
    (
        urun_id number(10),
        musteri_isim varchar2(50), 
        urun_isim varchar2(50)
    );
    INSERT INTO mart_satislar VALUES (10, 'Mark', 'Honda');
    INSERT INTO mart_satislar VALUES (10, 'Mark', 'Honda');
    INSERT INTO mart_satislar VALUES (20, 'John', 'Toyota');
    INSERT INTO mart_satislar VALUES (30, 'Amy', 'Ford');
    INSERT INTO mart_satislar VALUES (20, 'Mark', 'Toyota');
    INSERT INTO mart_satislar VALUES (10, 'Adem', 'Honda');
    INSERT INTO mart_satislar VALUES (40, 'John', 'Hyundai');
    INSERT INTO mart_satislar VALUES (20, 'Eddie', 'Toyota');
    
    INSERT INTO nisan_satislar VALUES (10, 'Hasan', 'Honda');
    INSERT INTO nisan_satislar VALUES (10, 'Kemal', 'Honda');
    INSERT INTO nisan_satislar VALUES (20, 'Ayse', 'Toyota');
    INSERT INTO nisan_satislar VALUES (50, 'Yasar', 'Volvo');
    INSERT INTO nisan_satislar VALUES (20, 'Mine', 'Toyota');
    
    SELECT * FROM mart_satislar;
    SELECT * FROM nisan_satislar;
    DELETE FROM nisan_satislar;
    
    /* -----------------------------------------------------------------------------
  ORNEK 1 : MART VE N?SAN aylar?nda ayn? URUN_ID ile sat?lan ürünlerin
  URUN_ID’lerini listeleyen ve ayn? zamanda bu ürünleri MART ay?nda alan
  MUSTERI_ISIM 'lerini listeleyen bir sorgu yaz?n?z. 
 -----------------------------------------------------------------------------*/       
    -- tablolara k?sa isim vermek mümkündür. Böylece sorgular?m?z?n daha k?sa 
    -- gözükmesini sa?labiliriz.
    
    SELECT musteri_isim FROM mart_satislar
    WHERE EXISTS (SELECT urun_id FROM nisan_satislar
                                    WHERE mart_satislar.urun_id = nisan_satislar.urun_id)                                    
    
    
    