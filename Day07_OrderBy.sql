/*================================ ORDER BY  ===================================
    ORDER BY cumlecigi bir SORGU deyimi içerisinde belli bir SUTUN’a göre 
    SIRALAMA yapmak için kullanilir.
  
    ORDER BY sutun_adi ASC   -- ARTAN
    ORDER BY sutun_adi DESC  -- AZALAN
==============================================================================*/
CREATE TABLE kisiler 
    (
        ssn char(9) PRIMARY KEY,
        isim VARCHAR2(50), 
        soyisim VARCHAR2(50), 
        maas NUMBER,
        adres VARCHAR2(50) 
    );
    INSERT INTO kisiler VALUES(123456789, 'Ali','Can', 3000,'Istanbul');
    INSERT INTO kisiler VALUES(234567890, 'Veli','Cem', 2890,'Ankara');
    INSERT INTO kisiler VALUES(345678901, 'Mine','Bulut',4200,'Ankara');
    INSERT INTO kisiler VALUES(256789012, 'Mahmut','Bulut',3150,'Istanbul');
    INSERT INTO kisiler VALUES (344678901, 'Mine','Yasa', 5000,'Ankara');
    INSERT INTO kisiler VALUES (345458901, 'Veli','Yilmaz',7000,'Istanbul');

    SELECT * FROM kisiler;
    DROP TABLE kisiler;
/* ----------------------------------------------------------------------------
  ORNEK 1: kisiler tablosunu adres’e göre siralayarak sorgulayiniz.
-----------------------------------------------------------------------------*/
    SELECT * FROM kisiler
    ORDER BY adres;

/* ----------------------------------------------------------------------------
  ORNEK 2 : kisiler tablosunu maas’a gore siralayarak sorgulayiniz.
-----------------------------------------------------------------------------*/
    SELECT * FROM kisiler
    ORDER BY maas;
    
/* ----------------------------------------------------------------------------
  ORNEK 3 : kisiler tablosunu adres’e göre AZALAN sirada sorgulayiniz.
-----------------------------------------------------------------------------*/
    SELECT * FROM kisiler
    ORDER BY maas DESC; -- DESC = AZALANA GORE SIRALAR

/* ----------------------------------------------------------------------------
  ORNEK 4 : ismi Mine olanlari, SSN'e gore AZALAN sirada sorgulayiniz.
-----------------------------------------------------------------------------*/
    SELECT * FROM kisiler
    WHERE isim = 'Mine'
    ORDER BY ssn DESC;
    
/* ----------------------------------------------------------------------------
  ORNEK 5 : soyismi'i Bulut olanlari isim sirali olarak sorgulayin
-----------------------------------------------------------------------------*/
    SELECT * FROM kisiler
    WHERE soyisim = 'Bulut'
    ORDER BY 2; -- Kacinci sutune gore siralayacagini yaziyor. 2. Sutun isim oldugu icin isim'e gore siraladi.
    
/* ----------------------------------------------------------------------------
  ORNEK 6 : Maas'i en yuksek 3 kisinin bilgilerini listeleyen sorguyu yaziniz
-----------------------------------------------------------------------------*/
    SELECT * FROM kisiler
    ORDER BY maas DESC
    FETCH NEXT 3 ROWS ONLY; -- Java'nin son surumu ile geldi olmuyorsa dusuk surum kullaniyorsun demektir.

/* ----------------------------------------------------------------------------
  ORNEK 7 : Maas'i en dusuk 2 kisinin bilgilerini listeleyen sorguyu yaziniz
-----------------------------------------------------------------------------*/
    SELECT * FROM kisiler
    ORDER BY maas ASC
    FETCH NEXT 2 ROWS ONLY; -- Java'nin son surumu ile geldi olmuyorsa dusuk surum kullaniyorsun demektir.

/* ----------------------------------------------------------------------------
  ORNEK 8 : Maas'a gore siralamada 4. ile 6. kisilerin bilgilerini listeyen sorguyu yaziniz.
-----------------------------------------------------------------------------*/
    SELECT * FROM kisiler
    ORDER BY maas DESC
    OFFSET 3 ROWS    -- Ilk 3 kaydi atlayacak
    FETCH NEXT 3 ROWS ONLY; -- Sonraki 3 kaydi sectik.

/*====================== FETCH NEXT, OFFSET (12C VE ÜSTÜ) ======================
   1) FETCH cumlecigi ile listelenecek kayitlari sinirlandirabiliriz. istersek satir sayisina gore 
   istersek de toplam satir sayisinin belli bir yuzdesine gore sinirlandirma koymak mumkundur. 
   Syntax
   ---------
   FETCH NEXT satir_sayisi ROWS ONLY;
   FETCH NEXT satir_yuzdesi PERCENT ROWS ONLY;
   
   2) OFFSET Cumlecigi ile de listenecek olan satirlardan sirasiyla istedigimiz kadarini atlayabiliriz.  
   Syntax
   ----------
   OFFSET satir_sayisi ROWS;
==============================================================================*/ 


