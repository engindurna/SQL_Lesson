--SUBQURIES

select * from calisanlar2
select * from markalar

-- Her markanin ismini, calisan sayisini ve o markaya ait calisanlarin toplam maaşini listeleyiniz

select marka_isim,calisan_sayisi,
(select sum(maas) from calisanlar2 where marka_isim=isyeri) as calisanalr_toplam_maas from markalar

-- Her markanin ismini, calisan sayisini ve o markaya ait calisanlarin maksimum ve minumum maaşini listeleyen bir Sorgu yaziniz.

select marka_isim,calisan_sayisi,
(select max(maas) from calisanlar2 where marka_isim=isyeri) as max_maas,
(select min(maas) from calisanlar2 where marka_isim=isyeri) as min_maas from markalar;


--EXISTS CONTIDION

CREATE TABLE mart
(
urun_id int,
musteri_isim varchar(50), urun_isim varchar(50)
);

INSERT INTO mart VALUES (10, 'Mark', 'Honda');
INSERT INTO mart VALUES (20, 'John', 'Toyota');
INSERT INTO mart VALUES (30, 'Amy', 'Ford');
INSERT INTO mart VALUES (20, 'Mark', 'Toyota');
INSERT INTO mart VALUES (10, 'Adam', 'Honda');
INSERT INTO mart VALUES (40, 'John', 'Hyundai');
INSERT INTO mart VALUES (20, 'Eddie', 'Toyota');

CREATE TABLE nisan
(
urun_id int ,
musteri_isim varchar(50), urun_isim varchar(50)
);

INSERT INTO nisan VALUES (10, 'Hasan', 'Honda');
INSERT INTO nisan VALUES (10, 'Kemal', 'Honda');
INSERT INTO nisan VALUES (20, 'Ayse', 'Toyota');
INSERT INTO nisan VALUES (50, 'Yasar', 'Volvo');
INSERT INTO nisan VALUES (20, 'Mine', 'Toyota');

SELECT * from mart
select * from nisan


--MART VE NİSAN aylarında aynı URUN_ID ile satılan ürünlerin URUN_ID’lerini listeleyen ve aynı zamanda bu ürünleri MART ayında alan
--MUSTERI_ISIM 'lerini listeleyen bir sorgu yazınız.
 
select urun_id,musteri_isim from mart 
where exists (select urun_id from nisan where mart.urun_id=nisan.urun_id)

--Her iki ayda birden satılan ürünlerin URUN_ISIM'lerini ve bu ürünleri
--NİSAN ayında satın alan MUSTERI_ISIM'lerini listeleyen bir sorgu yazınız

select urun_isim,musteri_isim from nisan 
where exists (select urun_isim from mart where mart.urun_isim=nisan.urun_isim )


---UPDATE 


CREATE TABLE tedarikciler -- parent
(
vergi_no int PRIMARY KEY,
firma_ismi VARCHAR(50),
irtibat_ismi VARCHAR(50)
);

INSERT INTO tedarikciler VALUES (101, 'IBM', 'Kim Yon');
INSERT INTO tedarikciler VALUES (102, 'Huawei', 'Çin Li');
INSERT INTO tedarikciler VALUES (103, 'Erikson', 'Maki Tammen');
INSERT INTO tedarikciler VALUES (104, 'Apple', 'Adam Eve');

CREATE TABLE urunler -- child
(
ted_vergino int,
urun_id int,
urun_isim VARCHAR(50),
musteri_isim VARCHAR(50),
CONSTRAINT fk_urunler FOREIGN KEY(ted_vergino) REFERENCES tedarikciler(vergi_no)
on delete cascade
);

INSERT INTO urunler VALUES(101, 1001,'Laptop', 'Ayşe Can');
INSERT INTO urunler VALUES(102, 1002,'Phone', 'Fatma Aka');
INSERT INTO urunler VALUES(102, 1003,'TV', 'Ramazan Öz');
INSERT INTO urunler VALUES(102, 1004,'Laptop', 'Veli Han');
INSERT INTO urunler VALUES(103, 1005,'Phone', 'Canan Ak');
INSERT INTO urunler VALUES(104, 1006,'TV', 'Ali Bak');
INSERT INTO urunler VALUES(104, 1007,'Phone', 'Aslan Yılmaz');

select * from tedarikciler
select * from urunler

-- vergi_no’su 102 olan tedarikcinin firma ismini 'Vestel' olarak güncelleyeniz.
update tedarikciler
set firma_ismi='Vestel' where vergi_no=102;

-- vergi_no’su 101 olan tedarikçinin firma ismini 'casper' ve irtibat_ismi’ni 'Ali Veli' olarak güncelleyiniz.
update tedarikciler 
set firma_ismi='casper',irtibat_ismi='Ali Veli' where vergi_no = 101;

--  vergi_no’su 102 olan tedarikcinin firma ismini 'Vestel' olarak güncelleyeniz.
update tedarikciler 
set firma_ismi='Vestel' where vergi_no = 102;

-- urunler tablosundaki 'Phone' değerlerini 'Telefon' olarak güncelleyiniz.

update urunler 
set urun_isim='Telefon' where urun_isim='Phone';

-- urunler tablosundaki urun_id değeri 1004'ten büyük olanların urun_id’sini 1 arttırın.
update urunler
set urun_id=urun_id+1 where urun_id> 1004;


-- urunler tablosundaki tüm ürünlerin urun_id değerini ted_vergino sutun değerleri ile toplayarak güncelleyiniz.
update urunler
set urun_id=urun_id+ted_vergino;



delete from urunler
select * from urunler

delete from tedarikciler
select * from tedarikciler

-- urunler tablosundaki tüm ürün isim'lerini, müşteri isimleri ile birleştirerek update edelim
UPDATE urunler
SET urun_isim = CONCAT(urun_isim,'-',musteri_isim)

-- Tabloda iki string field'i bir biri ile birleştirmek için bu yolu kullanabiliriz
UPDATE urunler4
SET urun_isim = urun_isim || '-' || musteri_isim



delete from urunler
select * from urunler

delete from tedarikciler
select * from tedarikciler


--urunler tablosundan Ali Bak’in aldigi urunun ismini, tedarikci tablosunda irtibat_ismi
--'Adam Eve' olan firmanın ismi (firma_ismi) ile degistiriniz.  

UPDATE urunler						
SET urun_isim= (SELECT firma_ismi from tedarikciler WHERE irtibat_ismi = 'Adam Eve') --> Apple						
WHERE musteri_isim = 'Ali Bak'

--Urunler tablosunda laptop satin alan musterilerin ismini, firma_ismi Apple’in irtibat_isim'i ile degistirin.

UPDATE urunler						
SET musteri_isim = (SELECT irtibat_ismi FROM tedarikciler WHERE firma_ismi = 'Apple')						
WHERE urun_isim = 'Laptop'


---IS NULL CONTIDION    ----  IS NOT NULL 


CREATE TABLE insanlar
(
ssn char(9),
isim varchar(50), adres varchar(50)
);


INSERT INTO insanlar VALUES(123456789, 'Ali Can', 'Istanbul');
INSERT INTO insanlar VALUES(234567890, 'Veli Cem', 'Ankara');
INSERT INTO insanlar VALUES(345678901, 'Mine Bulut', 'Izmir');
INSERT INTO insanlar (ssn, adres) VALUES(456789012, 'Bursa');
INSERT INTO insanlar (ssn, adres) VALUES(567890123, 'Denizli');

SELECT * from insanlar

SELECT * FROM insanlar WHERE isim IS NULL
SELECT * FROM insanlar WHERE  isim IS NOT NULL






