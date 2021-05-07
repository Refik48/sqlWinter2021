/* ============================= SUBQUERIES ====================================
    SORGU icinde calisan SORGUYA SUBQUERY (ALT SORGU) denilir.
    Bir tablodan veri alirkan baska bir tablodan da veri almak istiyorsak kullaniriz.
==============================================================================*/

    CREATE TABLE personel 
    (
        id NUMBER(9), 
        isim VARCHAR2(50), 
        sehir VARCHAR2(50), 
        maas NUMBER(20), 
        sirket VARCHAR2(20)
    );
    INSERT INTO personel VALUES(123456789, 'Ali Seker', 'Istanbul', 2500, 'Honda');
    INSERT INTO personel VALUES(234567890, 'Ayse Gul', 'Istanbul', 1500, 'Toyota');
    INSERT INTO personel VALUES(345678901, 'Veli Yilmaz', 'Ankara', 3000, 'Honda');
    INSERT INTO personel VALUES(456789012, 'Veli Yilmaz', 'Izmir', 1000, 'Ford');
    INSERT INTO personel VALUES(567890123, 'Veli Yilmaz', 'Ankara', 7000, 'Hyundai');
    INSERT INTO personel VALUES(456789012, 'Ayse Gul', 'Ankara', 1500, 'Ford');
    INSERT INTO personel VALUES(123456710, 'Fatma Yasa', 'Bursa', 2500, 'Honda');
    
    CREATE TABLE sirketler
    (
        sirket_id NUMBER(9), 
        sirket_adi VARCHAR2(20), 
        personel_sayisi NUMBER(20)
    );
    INSERT INTO sirketler VALUES(100, 'Honda', 12000);
    INSERT INTO sirketler VALUES(101, 'Ford', 18000);
    INSERT INTO sirketler VALUES(102, 'Hyundai', 10000);
    INSERT INTO sirketler VALUES(103, 'Toyota', 21000);

    SELECT * FROM sirketler;
    SELECT * FROM personel;
/* -----------------------------------------------------------------------------
  ORNEK 1 : Personel sayisi 15.000’den cok olan sirketlerin isimlerini ve bu 
  sirkette calisan personelin isimlerini ve maaslarini listeleyin
 -----------------------------------------------------------------------------*/ 

SELECT isim,maas,sirket FROM personel
WHERE sirket IN (SELECT sirket_adi FROM sirketler 
                                WHERE personel_sayisi > 15000); -- Birden fazla veri olabilecegi icin IN ile bagladim. 

/* 
Soruda Personel Sayisi 15.000'den fazla olanlarin sirketlerini, isimlerini, maaslarini istiyor.
1) isim,sirket,maas verileri PERSONEL tablosunda oldugu icin FROM kismina PERSONEL yazdik.
2) Iki tablonun ortak noktasi "sirket" oldugu icin WHERE kisminda sirket kullandik.
3) Soruda Personel Sayisi 15.000'den fazla olanlar dedigi icin bunu sorgulayacagimiz yer olan sirketler tablosuna bakmamiz gerekiyor,
bu yuzden IN icinde yeniden sorgulama yapiyoruz.
*/

 /* ----------------------------------------------------------------------------
  ORNEK 2 : sirket_id’si 101’den büyük olan sirket calisanlarinin isim, maas ve 
  sehirlerini listeleyiniz. 
 -----------------------------------------------------------------------------*/
 SELECT isim,maas,sehir FROM personel
 WHERE sirket IN (SELECT sirket_adi FROM sirketler
                                WHERE sirket_id > 101);
/* -----------------------------------------------------------------------------
  ORNEK 3 :  Ankara’da personeli olan sirketlerin sirket id'lerini ve personel 
  sayilarini listeleyiniz 
 -----------------------------------------------------------------------------*/ 
 SELECT sirket_id,personel_sayisi FROM sirketler
 WHERE sirket_adi IN (SELECT sirket FROM personel 
                                    WHERE sehir = 'Ankara');

/* ===================== AGGREGATE METOT KULLANIMI ===========================
    Aggregate Metotlari (SUM,COUNT, MIN,MAX, AVG) Subquery icinde kullanilabilir.
    Ancak, Sorgu tek bir deger donduruyor olmalidir.
==============================================================================*/  
/* -----------------------------------------------------------------------------
  ORNEK 4 : Her sirketin ismini, personel sayisini ve o sirkete ait personelin 
  toplam maasini listeleyen bir Sorgu yaziniz.
 -----------------------------------------------------------------------------*/
SELECT sirket_adi, personel_sayisi, (SELECT SUM (maas) FROM personel
                                                        WHERE sirket_adi = sirket) AS toplam_maas -- AS ile topladigimiz bu degere toplam_maas ismini verdim.
FROM sirketler;

/* -----------------------------------------------------------------------------
  ORNEK 5 : Her sirketin ismini, personel sayisini ve o sirkete ait personelin ORTALAMA
  maasini listeleyen bir Sorgu yaziniz.
 -----------------------------------------------------------------------------*/
SELECT sirket_adi, personel_sayisi, (SELECT ROUND(AVG (maas)) FROM personel
                                                        WHERE sirket = sirketler.sirket_adi) AS ort_maas -- ROUND ortalama maasin yuvarlanmasini sagliyor.
FROM sirketler;

/* ----------------------------------------------------------------------------
  ORNEK 6 : Her sirketin ismini, personel sayisini ve o sirkete ait personelin
  maksimum ve minumum maasini listeleyen bir Sorgu yaziniz.
 -----------------------------------------------------------------------------*/   
SELECT sirket_adi, personel_sayisi, (SELECT MAX(maas) FROM personel WHERE sirket_adi = sirket) AS max_maas,
                                                         (SELECT MIN(maas) FROM personel WHERE sirket_adi = sirket) AS min_maas
FROM sirketler;                -- SELECT'leri yazdigimiz sira farketmez istersem MIN'li kismini en basa yazardim, sadece sonuc ekraninda sutun sirasi degisiyor.

/* ----------------------------------------------------------------------------
 ORNEK 7 : Her sirketin id’sini, ismini ve toplam kac sehirde bulundugunu listeleyen bir sorgu yaziniz.
 -----------------------------------------------------------------------------*/   

SELECT sirket_id, sirket_adi, (SELECT COUNT(sehir) FROM personel
                                                 WHERE sirket=sirketler.sirket_adi) AS sehir_sayisi
FROM sirketler;



DROP TABLE sirketler;
DROP TABLE personel;






