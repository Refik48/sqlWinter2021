/*===================== IS NULL, IS NOT NULL, COALESCE ========================
    IS NULL, ve IS NOT NULL BOOLEAN operatörleridir. Bir ifadenin NULL olup olmad???n? kontrol ederler.  
    
    COALESCE ise bir fonksiyondur ve içerisindeki parameterelerden NULL olmayan 
    ilk ifadeyi döndürür. E?er ald??? tüm ifadeler NULL ise NULL döndürürür.

    COALESCE(ifade1, ifade2, .....ifadeN)
==============================================================================*/
CREATE TABLE insanlar 
    (
        ssn CHAR(9),
        isim VARCHAR2(50), 
        adres VARCHAR2(50) 
    );
    INSERT INTO insanlar VALUES('123456789', 'Ali Can', 'Istanbul');
    INSERT INTO insanlar VALUES('234567890', 'Veli Cem', 'Ankara');
    INSERT INTO insanlar VALUES('345678901', 'Mine Bulut', 'Izmir');
    INSERT INTO insanlar (ssn, adres) VALUES('456789012', 'Bursa');
    INSERT INTO insanlar (ssn, adres) VALUES('567890123', 'Denizli');
    INSERT INTO insanlar (adres) VALUES('Sakarya');
    INSERT INTO insanlar (ssn) VALUES('999111222');
    
    SELECT * FROM insanlar;
    DELETE FROM insanlar;
/*----------------------------------------------------------------------------
  ORNEK 1 : isim'i NULL olanlari sorgulayin.
-----------------------------------------------------------------------------*/
    SELECT * FROM insanlar
    WHERE isim IS NULL;

/*----------------------------------------------------------------------------
  ORNEK 2 : isim'i NULL olmayanlari sorgulayin.
-----------------------------------------------------------------------------*/
    SELECT * FROM insanlar
    WHERE isim IS NOT NULL;
    
/*----------------------------------------------------------------------------
  ORNEK 3 : isim'i NULL olanlara NO NAME yaziniz.
-----------------------------------------------------------------------------*/
    UPDATE insanlar 
    SET isim = 'NO NAME'
    WHERE isim IS NULL;
    SELECT * FROM insanlar;

/*----------------------------------------------------------------------------
  ORNEK 4 : isim'i NULL olanlara 'Henuz isim girilmedi'
                     adres'i NULL olanlara 'Henuz Adres girilmedi'
                     ssn'i NULL olanlara 'NO SSN' atayalim. => ssn kismi 9 karakter aldigi icin boyle ufak yaziyoruz
-----------------------------------------------------------------------------*/
    -- 1. YOL => Tek tek update edebiliriz
    UPDATE insanlar
    SET isim = 'Henuz isim girilmedi'
    WHERE isim IS NULL;
    
    UPDATE insanlar
    SET adres = 'Henuz isim girilmedi'
    WHERE adres IS NULL;
    
    UPDATE insanlar
    SET ssn = 'NO SSN'
    WHERE ssn IS NULL;

    -- 2. YOL => COALESCE komutu ile update etme. Daha fazla NULL olan veriler icin kullanilmasi daha pratiktir. (isim,adres,soyad,tel,ssn...)
    UPDATE insanlar -- Null olmayan ilk degerin parametresini donduruyor.
    SET isim = COALESCE (isim, 'Henuz isim girilmedi'),
            adres = COALESCE (adres, 'Henuz adres girilmedi'),
            ssn = COALESCE (ssn, 'NO SSN');











