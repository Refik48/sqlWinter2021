/*============================= DISTINCT =====================================
    DISTINCT cumlecigi bir SORGU ifadesinde benzer olan satirlari filtrelemek
    icin kullanilir. Dolayisiyla secilen sutun yada sutunlar icin benzersiz veri iceren satirlar olusturmaya yarar.
    
    SYNTAX
    -------
    SELECT DISTINCT sutun_adi1, sutun_adi2, column_3
    FROM  tablo_adi;
==============================================================================*/
CREATE TABLE manav 
    (
        isim varchar2(50), 
        urun_adi varchar2(50), 
        urun_miktari number(9) 
    );
    INSERT INTO manav VALUES( 'Ali', 'Elma', 5);
    INSERT INTO manav VALUES( 'Ayse', 'Armut', 3);
    INSERT INTO manav VALUES( 'Veli', 'Elma', 2);
    INSERT INTO manav VALUES( 'Hasan', 'Uzum', 4);
    INSERT INTO manav VALUES( 'Ali', 'Armut', 2);
    INSERT INTO manav VALUES( 'Ayse', 'Elma', 3);
    INSERT INTO manav VALUES( 'Veli', 'Uzum', 4);
    INSERT INTO manav VALUES( 'Ali', 'Armut', 2);
    INSERT INTO manav VALUES( 'Veli', 'Elma', 3);
    INSERT INTO manav VALUES( 'Ayse', 'Uzum', 4);
    INSERT INTO manav VALUES( 'Ali', '', 2);
/* ----------------------------------------------------------------------------
  ORNEK 1 : satilan farkl? meyve turlerinin sayisini  listeyen sorguyu yaziniz.
-----------------------------------------------------------------------------*/
    SELECT DISTINCT COUNT(urun_adi) AS urun_sayisi
    FROM manav;
    
/* ----------------------------------------------------------------------------
  ORNEK 2 : satilan meyve ve isimlerin farkli olanlarini  listeyen sorguyu yaziniz.
-----------------------------------------------------------------------------*/    
    SELECT DISTINCT urun_adi, isim -- 2 sutun icin beraber olarak benzerli olanlari cikariyor.
    FROM manav;
 
 /* ----------------------------------------------------------------------------
  ORNEK 3 : satilan meyvelerin, urun miktarlarinin benzersiz toplamlarini listeleyen sorguyu yaziniz.
-----------------------------------------------------------------------------*/       
    SELECT SUM(DISTINCT urun_miktari) AS urun_sayisi
    FROM manav;


    
    
    
    
    
    
    
    
    
    