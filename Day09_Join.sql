/*============================== JOIN ?SLEMLER? ===============================
    
    Set Operatorleri (Union,Intersect,Minus) farkl? tablolardaki sutunlari 
    birlestirmek kullanilir.
    
    Join islemleri ise farkl? Tablolari birlestirmek icin kullanilir. Diger 
    bir ifade ile farkli tablolardaki secilen sutunlar ile yeni bir tablo 
    olusturmak icin kullanilabilir.
    
    JOIN islemleri Iliskisel Veritabanlari icin cok onemli bir ozelliktir. Çunku
    Foreign Key'ler ile iliskili olan tablolardan istenilen sutunlari cekmek 
    icin JOIN islemleri kullanilabilir.
    
    ORACLE SQL'de 4 Cesit Join isemi kullanilabilmektedir.
    1) FULL JOIN:  Tablodaki tum sonuclari gosterir
    2) INNER JOIN:  Tablolardaki ortak olan sonuc kumesini gosterir
    3) LEFT JOIN:  Ilk tabloda (Sol) olup digerinde olmayan sonuclari gosterir
    4) RIGHT JOIN: Sadece Ikinci tabloda olan tum sonuclari gosterir
   
==============================================================================*/   
    CREATE TABLE sirketler 
    (
        sirket_id NUMBER(9), 
        sirket_isim VARCHAR2(20)
    );
    
    INSERT INTO sirketler VALUES(100, 'Toyota');
    INSERT INTO sirketler VALUES(101, 'Honda');
    INSERT INTO sirketler VALUES(102, 'Ford');
    INSERT INTO sirketler VALUES(103, 'Hyundai');
    
    CREATE TABLE siparisler
    (
        siparis_id NUMBER(9),
        sirket_id NUMBER(9), 
        siparis_tarihi DATE
    );
    
    INSERT INTO siparisler VALUES(11, 101, '17-Apr-2020');
    INSERT INTO siparisler VALUES(22, 102, '18-Apr-2020');
    INSERT INTO siparisler VALUES(33, 103, '19-Apr-2020');
    INSERT INTO siparisler VALUES(44, 104, '20-Apr-2020');
    INSERT INTO siparisler VALUES(55, 105, '21-Apr-2020');

    SELECT * FROM siparisler;
    SELECT * FROM sirketler;
    
    DROP TABLE sirketler;
    DROP TABLE siparisler;
    
/*=============================== FULL JOIN  ==================================
    
    FULL JOIN, Her iki tablo icin secilen sutunlara ait olan tum satirlari getirmek icin kullanilir. 
    FULL JOIN -> Hepsini gosteriyor.
    JOIN -> 
    
    Syntax
    -----------
    SELECT sutun1,sutun2....sutunN
    FROM tablo1 
    FULL JOIN tablo2
    ON tablo1.sutun = tablo2.sutun;
==============================================================================*/   
   
/* -----------------------------------------------------------------------------
  ORNEK1: sirketler ve siparisler ad?ndaki tablolarda yer alan sirket_isim, 
  siparis_id ve siparis_tarihleri listeleyen bir sorgu yaziniz.
------------------------------------------------------------------------------*/ 
    SELECT s.sirket_isim, sp.siparis_id,  sp.siparis_tarihi, sp.sirket_id
    FROM sirketler s
    FULL JOIN siparisler sp
    ON s.sirket_id = sp.sirket_id; -- 2 tablonun ortak verisi id'ler o yuzden 2 tablonun ortak noktalarina gore id islemini yap anlaminda yaziyorum.
    --FULL JOIN'de iki tabloda var olam tum satirlar gosterilir.
    -- Bir olup da digerlerinde olmayan alanlar bos birakildi.
    -- Join isleminda genelde iki tablodaki ortak olarak bulunan sutun, ON cumleciginde kosul yapisi olarak kullanilir.
    -- Karsiligi olmayan yerlere NULL atamasi yapar.

/*=============================== INNER JOIN  ==================================
    Iki tablonun kesisim kumesi ile yeni bir tablo olusturmak icin kullanilir.
    
    Syntax
    -----------
    SELECT sutun1,sutun2....sutunN
    FROM tablo1
    INNER JOIN tablo2
    ON tablo1.sutun = tablo2.sutun;
================================================================================  
/* -----------------------------------------------------------------------------
  ORNEK2: Iki Tabloda sirket_id’si ayni olanlarin sirket_ismi, siparis_id ve
  siparis_tarihleri listeleyen bir sorgu yaziniz.
------------------------------------------------------------------------------*/

    SELECT 








