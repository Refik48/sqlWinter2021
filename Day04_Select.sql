/*======================= SELECT - REGEXP_LIKE ================================
    Daha karma??k pattern ile sorgulama i?lemi için REGEXP_LIKE kullan?labilir. 
    Syntax:
    --------
    REGEXP_LIKE(sutun_ad?, ‘pattern[] ’, ‘c’ ] )    Sutun adi , pattern , varsa ekstradan veri  
========================================================================== */
CREATE TABLE kelimeler
    (
        id NUMBER(10) UNIQUE,
        kelime VARCHAR2(50) NOT NULL,
        harf_sayisi NUMBER(6)
    );
    
    INSERT INTO kelimeler VALUES (1001, 'hot', 3);
    INSERT INTO kelimeler VALUES (1002, 'hat', 3);
    INSERT INTO kelimeler VALUES (1003, 'hit', 3);
    INSERT INTO kelimeler VALUES (1004, 'hbt', 3);
    INSERT INTO kelimeler VALUES (1005, 'hct', 3);
    INSERT INTO kelimeler VALUES (1006, 'adem', 4);
    INSERT INTO kelimeler VALUES (1007, 'selim', 5);
    INSERT INTO kelimeler VALUES (1008, 'yusuf', 5);
    INSERT INTO kelimeler VALUES (1009, 'hip', 3);
    INSERT INTO kelimeler VALUES (1010, 'HOT', 3);
    INSERT INTO kelimeler VALUES (1011, 'hOt', 3);
    INSERT INTO kelimeler VALUES (1012, 'h9t', 3);
    INSERT INTO kelimeler VALUES (1013, 'hoot', 4);
    INSERT INTO kelimeler VALUES (1014, 'haaat', 5);
    INSERT INTO kelimeler VALUES (1015, 'harfiyat', 8);
    INSERT INTO kelimeler VALUES (1015, 'OT', 7);
     
    SELECT * FROM kelimeler;
    
    SELECT * FROM kelimeler
    WHERE REGEXP_LIKE (kelime, 'hi'); -- hi yanana olanlari sorguluyor.
    
    SELECT * FROM kelimeler
    WHERE REGEXP_LIKE (kelime, '[hi]'); -- Koseli parantez kullanimi ; bir nevi veya demektir . Icerisinde h veya i bulunan kelimeler nelerdir diye sorgular.
    
    -- Icerisinde ot veya at harfleri olan kelimeleri sorgulayin. VEYA islem | karakteri ile yapilir.
    
    SELECT * FROM kelimeler
    WHERE REGEXP_LIKE (kelime, 'ot|at'); -- Tirnak icerisinde olmazsa calismaz
    
    SELECT * FROM kelimeler
    WHERE REGEXP_LIKE (lower(kelime),'ot|at');  -- Case Sensitive'i ortadan kaldirir.
    
     SELECT * FROM kelimeler
    WHERE REGEXP_LIKE (kelime, 'ot|at', 'i');
    -- c sensitive
    -- i insensitive icin kullaniliyor.
    
    -- hi veya ho ile baslayan kelimeleri sorgulayin
    -- Baslama icin ^ karakteri kuillanilir.
    SELECT * FROM kelimeler
    WHERE REGEXP_LIKE(kelime, '^hi|^ho', 'i');
    
    -- t veya m ile biten kelimeleri Buyuk kucuk harf duyarsiz bir sekilde listeleyin. 
    -- Bitis icin $ isareti kullanilir.
    
    SELECT * FROM kelimeler
    WHERE REGEXP_LIKE (kelime, 't$|m$', 'i');
    
    -- h ile baslayin t ile biten 3 harfli kelimeleri case sensitive duyarsiz bir sekilde listeleyin.
    
    SELECT * FROM kelimeler -- [ ] koseli parantez bir harf gosterir
    WHERE REGEXP_LIKE (kelime, 'h[a-z0-9]t', 'i'); -- h ile basliyor t ile bitiyor ve aradaki her sey onemsiz ise [] kullanabiliriz.
    -- 'h[a-z]t' veya 'h[a-z0-9]t' seklinde de yazilir. Yani - (tire) karakteri bir aralik verir. 3 harfli bunlar.
    
     SELECT * FROM kelimeler
    WHERE REGEXP_LIKE (kelime, 'h[ao]t', 'i'); -- [ ] icine ao yazildiginda ; kelime icinde a veya o olanlari getir anlaminda kullaniliyor.
    
    -- Ilk harfi h, son harfi t olup 2.harfi a veya i olan 3 harfli kelimelerin tum bilgilerini sorgulayim.
    SELECT * FROM kelimeler
    WHERE REGEXP_LIKE (kelime, 'h[ai]t', 'i'); -- [ ] koseli parantez bir harf gosterir
    
     -- ?çinde m veya i veya e olan kelimelerin tüm bilgilerini listeleyiniz.
    SELECT * FROM kelimeler
    WHERE REGEXP_LIKE(kelime,'h[mie](*)');
    
    -- içerisinde en az 2 adet oo bar?nd?ran kelimelerin tüm bilgilerini listeleyiniz.
    -- {2}
    SELECT * FROM kelimeler
    WHERE REGEXP_LIKE(kelime,'[o]{2}','i'); 
  
    SELECT * FROM kelimeler
    WHERE REGEXP_LIKE(kelime,'[a]{2}','i'); 
    
    
    