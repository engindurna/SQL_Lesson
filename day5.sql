--Eger bir sehirde alinan MAX maas 5000’den dusukse sehir ismini ve MAX maasi veren sorgu yaziniz

 select sehir, max(maas) as en_yuksek_maas from personel2
 group by sehir
 having max(maas) < 5000
 
select * from personel2



 --UNION OPERATÖRÜ	iki tabloyu tek tabloda gösterir
 
 --Maasi 4000’den cok olan isci isimlerini ve 5000 liradan fazla maas alinan sehirleri gosteren sorguyu yaziniz
 
SELECT isim as isim_sehir FROM personel2 WHERE maas>4000
UNION
SELECT sehir FROM personel2 WHERE maas>5000

--Mehmet Ozturk ismindeki kisilerin aldigi maaslari ve Istanbul’daki personelin maaslarini
--bir tabloda gosteren sorgu yaziniz

SELECT isim as isim_sehir,maas FROM personel2 WHERE isim='Mehmet Ozturk'
UNION
SELECT sehir,maas FROM personel2 WHERE sehir='Istanbul'

--Sehirlerden odenen ucret 4500’den fazla olanlari ve personelden ucreti 5000’den az
--olanlari bir tabloda maas miktarina gore sirali olarak gosteren sorguyu yaziniz
SELECT sehir as sehir_isim,maas FROM personel2 WHERE maas>4500
UNION
SELECT isim,maas FROM personel2 WHERE maas<5000


CREATE TABLE personel6
(
id int,
isim varchar(50),
sehir varchar(50),
maas int,
sirket varchar(20),
CONSTRAINT personel_pk PRIMARY KEY (id)
);


INSERT INTO personel6 VALUES(123456789, 'Ali Yilmaz', 'Istanbul', 5500, 'Honda');
INSERT INTO personel6 VALUES(234567890, 'Veli Sahin', 'Istanbul', 4500, 'Toyota');
INSERT INTO personel6 VALUES(345678901, 'Mehmet Ozturk', 'Ankara', 3500, 'Honda');
INSERT INTO personel6 VALUES(456789012, 'Mehmet Ozturk', 'Izmir', 6000, 'Ford');
INSERT INTO personel6 VALUES(567890123, 'Mehmet Ozturk', 'Ankara', 7000, 'Tofas');
INSERT INTO personel6 VALUES(456715012, 'Veli Sahin', 'Ankara', 4500, 'Ford');
INSERT INTO personel6 VALUES(123456710, 'Hatice Sahin', 'Bursa', 4500, 'Honda');


CREATE TABLE personel_bilgi  (
id int,
tel char(10) UNIQUE ,
cocuk_sayisi int,
CONSTRAINT personel_bilgi_fk FOREIGN KEY (id) REFERENCES personel6(id)
);


INSERT INTO personel_bilgi VALUES(123456789, '5302345678', 5);
INSERT INTO personel_bilgi VALUES(234567890, '5422345678', 4);
INSERT INTO personel_bilgi VALUES(345678901, '5354561245', 3);
INSERT INTO personel_bilgi VALUES(456789012, '5411452659', 3);
INSERT INTO personel_bilgi VALUES(567890123, '5551253698', 2);
INSERT INTO personel_bilgi VALUES(456789012, '5524578574', 2);
INSERT INTO personel_bilgi VALUES(123456710, '5537488585', 1);

select * from personel6 
select * from personel_bilgi

--id’si 123456789 olan personelin Personel tablosundan sehir ve maasini,
--personel_bilgi  tablosundan da tel ve cocuk sayisini yazdirin

SELECT id,sehir as sehir_tel,maas as cocuk_sayisi_maas FROM personel6 WHERE id=123456789
UNION
SELECT id,tel,cocuk_sayisi FROM personel_bilgi WHERE id=123456789

-- Personel tablosunda maasi 5000’den az olan tum sehirleri ve maaslari bulunuz
SELECT sehir,maas FROM personel6 WHERE maas<5000
UNION ALL
SELECT sehir,maas FROM personel6 WHERE maas<5000

--Tabloda personel maasi 4000’den cok olan tum sehirleri ve maaslari yazdirin
--Tabloda personel maasi 5000’den az olan tum isimleri ve maaslari yazdirin
SELECT sehir as sehir_isim,maas FROM personel6 WHERE maas>4000
UNION
SELECT isim,maas FROM personel6 WHERE maas<5000
--UNION ALL kullanımı
SELECT sehir as sehir_isim,maas FROM personel6 WHERE maas>4000
UNION ALL
SELECT isim,maas FROM personel6 WHERE maas<5000


-- İNTERSECT KOMUTU   sorgu sonuclarında ki ortak sonucları lısteler

--1)Personel tablosundan Istanbul veya Ankara’da calisanlarin id’lerini yazdir
--2)Personel_bilgi tablosundan 2 veya 3 cocugu olanlarin id lerini yazdirin

select id from personel6 where sehir in ('Istanbul','Ankara')
intersect
select id from personel_bilgi where cocuk_sayisi in (2,3)


--3)Honda,Ford ve Tofas’ta calisan ortak isimde personel varsa listeleyin
select isim from personel6 where sirket = 'Honda'
intersect
select isim from personel6 where sirket= 'Ford'
intersect
select isim from personel6 where sirket= 'Tofas'

--EXCETP OPERATÖRÜ

--EXCEPT KOMUTU
--5000’den az maas alip Honda’da calismayanlari yazdirin
SELECT isim,sirket FROM personel6 WHERE maas<5000
EXCEPT
SELECT isim,sirket FROM personel6 WHERE sirket='Honda'

--Ismi Mehmet Ozturk olup Istanbul’da calismayanlarin isimlerini ve sehirlerini listeleyin

select isim,sehir from personel6 where isim= 'Mehmet Ozturk'
except
select isim,sehir from personel6 where sehir='Istanbul'

-- INNERS JOIN KOMUTU

CREATE TABLE sirketler (
sirket_id int,
sirket_isim varchar(20)
);

INSERT INTO sirketler VALUES(100, 'Toyota');
INSERT INTO sirketler VALUES(101, 'Honda');
INSERT INTO sirketler VALUES(102, 'Ford');
INSERT INTO sirketler VALUES(103, 'Hyundai');

CREATE TABLE siparisler  (
siparis_id int, 
sirket_id int, 
siparis_tarihi date
);


INSERT INTO siparisler VALUES(11, 101, '2020-04-17');
INSERT INTO siparisler VALUES(22, 102, '2020-04-18');
INSERT INTO siparisler VALUES(33, 103, '2020-04-19');
INSERT INTO siparisler VALUES(44, 104, '2020-04-20');
INSERT INTO siparisler VALUES(55, 105, '2020-04-21');

SELECT * FROM sirketler
select * from siparisler

--Iki Tabloda sirket_id’si ayni olanlarin sirket_ismi, siparis_id ve
--siparis_tarihleri ile yeni bir tablo olusturun

select sirketler.sirket_isim,siparisler.siparis_id,siparisler.siparis_tarihi
from sirketler inner join siparisler
on sirketler.sirket_id = siparisler.sirket_id










 