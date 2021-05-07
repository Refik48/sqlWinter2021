/*============================= GROUP BY =====================================
    GROUP BY cumlecigi bir SELECT ifadesinde satirlari, sutunlarin degerlerine 
    gore ozet olarak gruplamak için kullanilir. WHERE cumlecigi ile kullanilabilir.
   
    GROUP BY cumlecigi her grup basina bir satir dondurur.
    
    GROUP BY genelde, AVG(),COUNT(),MAX(),MIN() ve SUM() gibi aggregate 
    fonksiyonlari ile birlikte kullanilir.
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
    
/* -----------------------------------------------------------------------------
ORNEK 1 : kisi ismine gore satilan toplam meyve miktarlarini gosteren sorguyu yaziniz
------------------------------------------------------------------------------*/
   -- SELECT isim, SUM(urun_miktari) FROM manav; -- Boyle olmaz cunku SUM(urun_miktari) dongusel bir sey,
    -- tek bir veri almayacak verileri alip toplamasi lazim. Bu yuzden gurplayip toplamasi gerekiyor.
    SELECT isim, SUM(urun_miktari)
    FROM manav
    GROUP BY isim; -- Isimlere gore isimleyip gruplandirmasi gerekiyor cunku Veli'nin kac tane urun aldigini Veli'nin verisi seklinde yazmali.

/* ----------------------------------------------------------------------------
  ORNEK 2 : Satilan meyve turune (urun_adi) gore urun alan kisi sayisini gosteren sorguyu yaziniz.
  NULL olarak girilen meyveyi listelemesin.
-----------------------------------------------------------------------------*/
    SELECT urun_adi, COUNT(isim) AS kisi_sayisi
    FROM manav
    WHERE urun_adi IS NOT NULL
    GROUP BY urun_adi -- Soru buraya kadardi normalde fakat bunu siralamak istersek alt'a ORDER BY yazabiliriz.
    ORDER BY COUNT(isim); -- Ama yazilis sirasi degisemez WHERE komutu GROUP BY'in altina yazilamaz.
    -- Once "where" sonra "group by" daha sonra "order by" seklinde olmak zorundadir. Aksi takdirde hata verir.

/* ----------------------------------------------------------------------------
  ORNEK 3 : satilan meyve turune (urun_adi) göre satilan MIN ve MAX urun
  miktarlarini MAX urun miktarina gore siralayarak listeyen sorguyu yaziniz.
-----------------------------------------------------------------------------*/
    SELECT urun_adi, MIN(urun_miktari) min_miktar, MAX(urun_miktari) maks_miktar
    FROM manav
    WHERE urun_adi IS NOT NULL
    GROUP BY urun_adi
    ORDER BY MAX(urun_miktari) DESC;

/* ----------------------------------------------------------------------------
  ORNEK 4 : kisi ismine ve urun adina gore satilan urunlerin toplamini
  gruplandiran ve isime göre ters sirada listeyen sorguyu yaziniz.
-----------------------------------------------------------------------------*/
    SELECT isim,urun_adi, SUM(urun_miktari)
    FROM manav
    GROUP BY isim, urun_adi
    ORDER BY isim DESC;

/* ----------------------------------------------------------------------------
  ORNEK 5 : kisi ismine ve urun adina göre satilan urunlerin toplamini bulan ve
  ve bu toplam degeri 3'den fazla olanlari listeyen sorguyu yaziniz.
-----------------------------------------------------------------------------*/
    /*SELECT isim, urun_adi, SUM(urun_miktari) AS toplam_miktar
    FROM manav
    WHERE SUM(urun_miktari > 3) -- EGER 
    GROUP BY isim, urun_adi
    ORDER BY isim DESC;*/
    -- Eger AGGREGATE fonksiyonlarla ilgili bir kosul koymak icin GROUP BY'dan sonra HAVING cumlecigi kullanilir.
    -- Normalde yukardaki gibi WHERE ile yaziyorduk fakat SELECT icinde AGGREGATE fonksiyon kullandigim icin Where yerine HAVING kullanmam lazim.
    SELECT isim, urun_adi, SUM(urun_miktari) AS toplam_miktar
    FROM manav
    GROUP BY isim, urun_adi
    HAVING SUM(urun_miktari) >= 3
    ORDER BY SUM(urun_miktari);

/* ----------------------------------------------------------------------------
  ORNEK6: satilan urun_adi’na göre MAX urun sayilarini siralayarak listeyen
  sorguyu yaziniz. NOT: Sorgu, sadece MAKS urun_miktari MIN urun_miktarina
  esit olmayan kayitlari listelemelidir.
-----------------------------------------------------------------------------*/
    SELECT urun_adi, MAX(urun_miktari) AS max_urun
    FROM manav
    GROUP BY urun_adi
    HAVING MAX(urun_miktari) <> MIN(urun_miktari)
    ORDER BY MAX(urun_miktari) DESC;

 /*============================= DISTINCT =====================================
    DISTINCT cümlecigi bir SORGU ifadesinde benzer olan satirlari filtrelemek
    icin kullanilir. Dolayisiyla secilen sutun yada sutunlar icin benzersiz veri
    iceren satirlar olusturmaya yarar.
   
    SYNTAX
    -------
    SELECT DISTINCT sutun_adi1, sutun_adi2, satin_adi3
    FROM  tablo_ad?;
==============================================================================*/
/* ----------------------------------------------------------------------------
  ORNEK 1 : satilan farkli meyve turlerinin sayisini listeyen sorguyu yaziniz.
-----------------------------------------------------------------------------*/   
    
    SELECT COUNT(DISTINCT urun_adi) AS urun_sayisi 
    FROM manav;

/* -----------------------------------------------------------------------------
  ORNEK 2 : satilan meyve ve isimlerin farkli olanlarini listeyen sorguyu yaziniz.
------------------------------------------------------------------------------*/
     SELECT DISTINCT urun_adi,isim   -- 2 sutun icin beraber degerlendirirek
                                     -- benzerli olanlar? cikariyor.
     FROM manav; 
     
/* ----------------------------------------------------------------------------
  ORNEK 3 : satilan meyvelerin urun_mikarlarinin benzersiz  olanlarinin 
  toplamlarini listeyen sorguyu yaziniz.
-----------------------------------------------------------------------------*/     
     SELECT SUM(DISTINCT urun_miktari) AS urun_sayisi 
     FROM manav;








