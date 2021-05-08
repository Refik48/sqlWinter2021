/*==================== SET OPERATORLERI: UNION, UNION ALL======================
    UNION, UNION ALL, INTERSECT, ve MINUS gibi SET operatorleri yardimiyla coklu sorgular birlestirilebilirler.
    
    UNION :  Bir SET operatorudur. 2 veya daha fazla Sorgu ifadesinin sonuc kumelerini birlesitirerek tek bir sonuc kumesi olusturur.    
   
    NOT:  Birlesik olan olan Sorgu ifadesinin veri turu diger sorgulardaki ifadelerin veri turu ile uyumlu olmalidir.
    
    Syntax:
    ----------
    SELECT sutun_adi,sutun_adi2, .. FROM tablo_adi1
    UNION
    SELECT sutun_adi1, sutun_adi2, .. FROM tablo_adi2;
    
    NOT : UNION operatoru SADECE benzersi degerleri alir. Benzerli verileri almak icin UNION ALL kullanilir.
    NOT : Sutun birlestirmek icin => SET / Tablo birlestirmek icin JOIN komutu kullanilir.
     
    Birlestirilen sutunlarin veri tipleri ayni olmak zorunda. varchar ise varchar olmali gibi.
    Secilenlerden birinin uzunlugu 9 digerinin 2 ise SQL buyuk olanin uzunlugunu kullanir ve 9 kabul eder.
==============================================================================*/ 
  
    CREATE TABLE personel 
    (
        id NUMBER(9), 
        isim VARCHAR2(50), 
        sehir VARCHAR2(50), 
        maas NUMBER(20), 
        sirket VARCHAR2(20),
        CONSTRAINT personel_pk PRIMARY KEY(id)
    );
    
    INSERT INTO personel VALUES(123456789, 'Ali Yilmaz', 'Istanbul', 5500, 'Honda');
    INSERT INTO personel VALUES(234567890, 'Veli Sahin', 'Istanbul', 4500, 'Toyota');
    INSERT INTO personel VALUES(345678901, 'Mehmet Ozturk', 'Ankara', 3500, 'Honda'); 
    INSERT INTO personel VALUES(456789012, 'Mehmet Ozturk', 'Izmir', 6000, 'Ford');
    INSERT INTO personel VALUES(567890123, 'Mehmet Ozturk', 'Ankara', 7000, 'Tofas');
    INSERT INTO personel VALUES(453445611, 'Veli Sahin', 'Ankara', 4500, 'Ford');
    INSERT INTO personel VALUES(123456710, 'Hatice Sahin','Bursa', 4200, 'Honda');
    
    SELECT * FROM personel;
    
/* -----------------------------------------------------------------------------
  ORNEK 1 : Maasi 4000’den cok olan isci isimlerini ve 5000 liradan fazla maas 
  alinan sehirleri gosteren sorguyu yaziniz
------------------------------------------------------------------------------*/
    
    SELECT isim AS isim_veya_sehir, maas -- isimler ile sehirleri birlestirdi ve tek sutun halini getirdi. 
    FROM personel                                     -- Birlestirilen sutunlarin veri tipleri ayni olmak zorunda. varchar ise varchar olmali gibi.
    WHERE maas > 4000                           -- Secilenlerden birinin uzunlugu 9 digerinin 2 ise SQL buyuk olanin uzunlugunu kullanir ve 9 kabul eder.
    UNION ALL                  -- UNION ALL kullanilirsa tekrarli veriler elenmez.
    SELECT sehir, maas  
    FROM personel
    WHERE maas > 5000;

/* -----------------------------------------------------------------------------
  ORNEK2: Mehmet Ozturk ismindeki kisilerin aldigi maaslari ve Istanbul’daki 
  personelin maaslarini yüksekten asagi dogru siralayarak bir tabloda gosteren 
  sorguyu yaziniz.    
------------------------------------------------------------------------------*/  
    SELECT maas,isim AS isim_veya_sehir -- Her iki select kisminda da birlestirilecek elemanlar 
    FROM personel
    WHERE isim = 'Mehmet Ozturk'
    UNION
    SELECT maas,sehir
    FROM personel
    WHERE sehir = 'Istanbul'
    ORDER BY maas DESC;
    
/*======================== FARKLI TABLOLARDAN BIRLESTIRME ====================*/   
    CREATE TABLE personel_bilgi 
    (
        id NUMBER(9), 
        tel char(10) UNIQUE , 
        cocuk_sayisi NUMBER(2), 
        CONSTRAINT fk_personel FOREIGN KEY (id) REFERENCES personel(id) 
    ); 
    
    INSERT INTO personel_bilgi VALUES(123456789, '5302345678' , 5);
    INSERT INTO personel_bilgi VALUES(234567890, '5422345678', 4);
    INSERT INTO personel_bilgi VALUES(345678901, '5354561245', 3); 
    INSERT INTO personel_bilgi VALUES(456789012, '5411452659', 3);
    INSERT INTO personel_bilgi VALUES(567890123, '5551253698', 2);
    INSERT INTO personel_bilgi VALUES(453445611, '5524578574', 2);
    INSERT INTO personel_bilgi VALUES(123456710, '5537488585', 1);

    SELECT * FROM personel_bilgi;

/* -----------------------------------------------------------------------------
  ORNEK4: id’si 123456789 olan personelin Personel tablosundan sehir ve 
  maasini, personel_bilgi tablosundan da tel ve cocuk sayisini yazdirin  
------------------------------------------------------------------------------*/    
    SELECT sehir AS sehir_tel, maas AS maas_cocukSayisi
    FROM personel
    WHERE id = 123456789
    UNION
    SELECT tel, cocuk_sayisi
    FROM personel_bilgi
    WHERE id = 123456789;
    
    -- sehir ile tel, maas ile cocuk ayni sutunda birlestigi icin veri tipleri uygun olmalidir.
     
/*========================= SET OPERATORLERI INTERSECT ========================
    INTERSECT operarotu 2 veya daha fazla Sorgu ifadesinin sonuclarini 
    dondurmek icin kullanilir. Ancak, intersect SADECE tum sorgularin ortak 
    verilerini (kesimlerini) dondurur. 
    
    Syntax:
    ----------
    SELECT sutun_adi,sutun_adi2, .. FROM tablo_adi1
    INTERSECT
    SELECT sutun_adi1, sutun_adi2, .. FROM tablo_adi2;
==============================================================================*/

/* -----------------------------------------------------------------------------
  ORNEK5: Personel tablosundan Istanbul veya Ankara’da calisanlarin id’lerini
  sorgulayiniz. 
  Personel_bilgi tablosundan 2 veya 3 cocugu olanlarin id lerini sorgulayiniz.
  Bu iki sorguyu INTERSECT ile birlesitiriniz.
------------------------------------------------------------------------------*/
    SELECT id FROM personel
    WHERE sehir IN('Istanbul','Ankara')
    INTERSECT
    SELECT id FROM personel_bilgi
    WHERE cocuk_sayisi IN (2,3);

/* -----------------------------------------------------------------------------
  ORNEK6: Honda,Ford ve Tofas’ta calisan ortak isimde personel varsa listeleyin
------------------------------------------------------------------------------*/  
    SELECT isim -- Eger ben burada WHERE sirket IN( 'Honda', 'Ford', 'Tofas');  olsaydi butun isimleri listelerdi. Ortak olanlar icin INTERSECT kullanmaliyim.
    FROM personel
    WHERE sirket = 'Honda'
    INTERSECT
    SELECT isim
    FROM personel
    WHERE sirket = 'Ford'
    INTERSECT
    SELECT isim
    FROM personel
    WHERE sirket = 'Tofas';
  
/* -----------------------------------------------------------------------------
  ORNEK7: Toyota ve Ford sirketlerinde ayni maasi alan personel isimlerini listeleyin
------------------------------------------------------------------------------*/    
    SELECT isim, maas
    FROM personel
    WHERE sirket = 'Toyota'
    INTERSECT
    SELECT isim, maas
    FROM personel
    WHERE sirket = 'Ford';
   
/*========================= SET OPERATORLERI: MINUS ============================
    MINUS operatoru ilk Sorgu ifadesinde olup da diger sorgu ifadesinde olmayan verileri dondurur. 
    Yani 1. sorgu ile 2. sorgu arasindaki farkli olanlari dondurur.
    
    A ve B kumemiz olsun. A'nin B'den farklarini bulmak icin MINUS kullaniriz.
    A
    MINUS
    B seklinde yazilir.
    
    Syntax:
    ----------
    SELECT sutun_adi,sutun_adi2, .. FROM tablo_adi1
    MINUS
    SELECT sutun_adi1, sutun_adi2, .. FROM tablo_adi2;
==============================================================================*/
/* -----------------------------------------------------------------------------
  ORNEK8: 5000’den az maas alan ve Honda calisani olmayanlarin bilgilerini
  listeleyen bir sorgu yaziniz. 
------------------------------------------------------------------------------*/ 
    -- 1.YONTEM (maasi 5000 den az olanlar ile sirketi Honda olmayanlari (!=) sec)
    SELECT isim,maas, sirket 
    FROM personel
    WHERE maas < 5000 
    INTERSECT
    SELECT isim, maas ,sirket
    FROM personel
    WHERE sirket != 'Honda'; -- MINUS yerine bu sekilde de kullanabilirdik.
    
    -- 2.YONTEM (maasi 5000 den az olanlar ile sirketi Honda'dan farkli olanlari sec)
    
    SELECT isim,maas,sirket 
    FROM personel
    WHERE maas < 5000 
    MINUS
    SELECT isim, maas ,sirket
    FROM personel
    WHERE sirket = 'Honda';
    
/* -----------------------------------------------------------------------------
  ORNEK 8 : Ismi Mehmet Ozturk olup Istanbul’da calismayanlarin isimlerini ve 
  sehirlerini listeleyen sorguyu yaziniz.
------------------------------------------------------------------------------*/
    SELECT isim, sehir  FROM personel
    WHERE isim = 'Mehmet Ozturk'
    MINUS                           -- Sehiri Istanbul olmayan
    SELECT isim,sehir FROM  personel
    WHERE sehir='Istanbul';
    
    -- MINUS'da UNION gibi tekrarli satirlardan sadece bir tanesi listeler.
    
    
    
    
    
    