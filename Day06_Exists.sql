/*=========================== EXISTS, NOT EXIST ================================
    EXISTS operatoru bir Boolean operatordur ve true - false deger dondurur. 
    EXISTS operatorü siklikla Subquery'lerde satirlarin dogrulugunu test etmek icin kullanilir.
    
    Eger bir subquery (altsorgu) bir satiri dondururse EXIST operatoru de TRUE 
    deger dondurur. Aksi takdirde, FALSE deger dondurecektir.
    
    Ozellikle altsorgularda hizli kontrol islemi gerceklestirmek icin kullanilir
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
  ORNEK 1 : MART VE NISAN aylarinda ayni URUN_ID ile satilan urunlerin
  URUN_ID’lerini listeleyen ve ayni zamanda bu urunleri MART ayinda alan
  MUSTERI_ISIM 'lerini listeleyen bir sorgu yaziniz. 
 -----------------------------------------------------------------------------*/       
    -- tablolara kisa isim vermek mumkundur. Boylece sorgularimizin daha kisa gozukmesini saglabiliriz.
    -- AS  -> bir sutuna kisa isim veriyor.
    -- Bir sorgu icerisinde  tabloya da kisa isim vermek mumkun. 
    -- tablo_Adi kisa_isim
    
    SELECT musteri_isim FROM mart_satislar
    WHERE EXISTS (SELECT urun_id FROM nisan_satislar
                                    WHERE mart_satislar.urun_id = nisan_satislar.urun_id);
    
    -- WHERE urun_id IN(SELECT urun_id FROM nisan_satislar
   --                                  WHERE mart_satislar.urun_id = nisan_satislar.urun_id);
   
   /* -----------------------------------------------------------------------------
  ORNEK 2 : Her iki ayda da satilan urunlerin URUN_ISIM'lerini ve bu urunleri
  NISAN ayinda satin alan MUSTERI_ISIM'lerini listeleyen bir sorgu yaziniz. 
 -----------------------------------------------------------------------------*/
 
 SELECT urun_isim, musteri_isim FROM nisan_satislar nisan -- Buraya nisan diye yazdigim yer nisan_satislar yerine gecti (nisan = nisan_satislar)
 WHERE EXISTS (SELECT urun_id FROM mart_satislar mart -- Ayni sey mart icin de gecerli (mart = mart_satislar). Altta ki komutta bu isimleri kullanabilirim.
                                WHERE mart.urun_id = nisan.urun_id); -- nisan ve mart sadece bu sorgu icin gecerli isimler oluyor.
 
 /* ----------------------------------------------------------------------------
  ORNEK3: Her iki ayda da ortak olarak satilmayan urunlerin URUN_ISIM'lerini 
  ve bu urunleri NISAN ayinda satin alan MUSTERI_ISIM'lerini listeleyiniz. 
 -----------------------------------------------------------------------------*/
 
 SELECT urun_isim, musteri_isim FROM nisan_satislar nisan -- Buraya nisan diye yazdigim yer nisan_satislar yerine gecti (nisan = nisan_satislar)
 WHERE NOT EXISTS (SELECT urun_id FROM mart_satislar mart -- Ayni sey mart icin de gecerli (mart = mart_satislar). Altta ki komutta bu isimleri kullanabilirim.
                                          WHERE mart.urun_id = nisan.urun_id); -- nisan ve mart sadece bu sorgu icin gecerli isimler oluyor.
 
 
 
 
 
 
    