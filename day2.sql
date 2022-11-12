-- DML DATA MANUPULATIN LANG.
-- INSERT
select * from ogrenciler;

--Bir tabloda tüm field lara veri eklemek için kullanırız
insert into ogrenciler values ('1234','Engin Durna',95.75,'2020-05-05')

-- Bir tabloya parçalı field lara veri ekleme için kullanırız 
insert into ogrenciler (id,isim_soyisim) values ('2345','Aslı Durna');


create table tedarikciler
(
	tedarikci_id int,
	tedarikci_ismi varchar(30),
	tedarikci_adres varchar(50),
	ulasım_tarihi date
);

create table tedarikci_ziyaret
as
select tedarikçi_ismi,ulasım_tarihi
from tedarikciler;

select * from tedarikciler
select * from tedarikci_ziyaret



CREATE TABLE personel
(
id char(10),
isim varchar(50) NOT NULL,
soyisim varchar(50),
email varchar(50),
ise_baslama_tar date,
maas int
);

select * from personel



CREATE TABLE calisanlar
(
id varchar(10) Primary Key,
isim varchar(30) Unique,
maas int not null,
ise_baslama date
)
CREATE TABLE adresler
(
adres_id char(10),
sokak varchar(10),
cadde varchar(10),
sehir varchar(10),
CONSTRAINT adrsfk FOREIGN KEY (adres_id) REFERENCES calisanlar(id)
)
INSERT INTO calisanlar VALUES('10002', 'Mehmet Yılmaz' ,12000, '2018-04-14');
INSERT INTO calisanlar VALUES('10008', null, 5000, '2018-04-14');
INSERT INTO calisanlar VALUES('10012', 'Mehmet Sahin', 5000, '2018-04-14'); 
INSERT INTO calisanlar VALUES('10004', 'Veli Han', 5000, '2018-04-14');
INSERT INTO calisanlar VALUES('10005', 'Mustafa Ali', 5000, '2018-04-14');
INSERT INTO calisanlar VALUES('10006', 'Canan Yaş', NULL, '2019-04-12'); -- Not null olduğu için kabul etmez
INSERT INTO calisanlar VALUES('10003', 'CAN', 5000, '2018-04-14');
INSERT INTO calisanlar VALUES('10007', 'CAN', 5000, '2018-04-14'); -- Unique olduğu için kabul etmez
INSERT INTO calisanlar VALUES('10009', 'cem', '', '2018-04-14'); -- Not null olduğu için kabul etmez
INSERT INTO calisanlar VALUES('', 'osman', 2000, '2018-04-14');
INSERT INTO calisanlar VALUES('', 'osman can', 2000, '2018-04-14');  -- Unique olduğu için kabul etmez
INSERT INTO calisanlar VALUES( '10002', 'ayse Yılmaz' ,12000, '2018-04-14'); -- Primary Key
INSERT INTO calisanlar VALUES( null, 'filiz ' ,12000, '2018-04-14'); -- Primary Key
INSERT INTO adresler VALUES('10003','Mutlu Sok', '40.Cad.','IST');
INSERT INTO adresler VALUES('10003','Can Sok', '50.Cad.','Ankara');
INSERT INTO adresler VALUES('10002','Ağa Sok', '30.Cad.','Antep');
-- Parent tabloda olmayan id ile child a ekleme yapamayiz
INSERT INTO adresler VALUES('10012','Ağa Sok', '30.Cad.','Antep');
-- FK'ye null değeri atanabilir.
INSERT INTO adresler VALUES(NULL,'Ağa Sok', '30.Cad.','Antep');
INSERT INTO adresler VALUES(NULL,'Ağa Sok', '30.Cad.','Maraş');
SELECT * from calisanlar
SELECT * from adresler



-- CHECK Constraint Kullanımı
CREATE TABLE sehirler2
(
alan_kodu int PRIMARY KEY,
isim varchar(20) NOT NULL,
nufus int CHECK (nufus>0)
);
INSERT INTO sehirler2 VALUES (123,'erol',50)
SELECT * from sehirler2

-- WHERE KULLANIMI
--- cALISANLAR TABLOSUNDAN SADECE MAAS I 5000 DEN BUYUK
---olanların isim field ında ki dataları getrir

select isim from calisanlar
WHERE maas>5000;

select * from calisanlar where maas>5000;


-- id'si 10004 olan kişinin id,isim ve maas field'larını sorgulayalım
SELECT id ,isim ,maas FROM 	calisanlar WHERE id='10004';



-- DML   - DELETE KULLANIMI
CREATE TABLE ogrenciler6
(
id int,
isim VARCHAR(50),
veli_isim VARCHAR(50),
yazili_notu int
);


INSERT INTO ogrenciler6 VALUES(123, 'Ali Can', 'Hasan',75);
INSERT INTO ogrenciler6 VALUES(124, 'Merve Gul', 'Ayse',85);
INSERT INTO ogrenciler6 VALUES(125, 'Kemal Yasa', 'Hasan',85);
INSERT INTO ogrenciler6 VALUES(126, 'Nesibe Yilmaz', 'Ayse',95);
INSERT INTO ogrenciler6 VALUES(127, 'Mustafa Bak', 'Can',99);
INSERT INTO ogrenciler6 VALUES(127, 'Mustafa Bak', 'Ali', 99);

select * from ogrenciler6;

delete from ogrenciler6; ---TABLONUN İCERİĞİNİ SİLER

delete from ogrenciler6 where id=124 ; -- id si 124 olan ı siler
delete from ogrenciler6 where isim ='Kemal Yasa'; -- Kemal Yasa yı siler




-- on delete cascade kullanımı

CREATE TABLE talebeler
(
id CHAR(3) primary key,
isim VARCHAR(50),
veli_isim VARCHAR(50),
yazili_notu int
);

CREATE TABLE notlar(
talebe_id char(3),
ders_adi varchar(30),
yazili_notu int,
CONSTRAINT notlar_fk FOREIGN KEY (talebe_id) REFERENCES talebeler(id)
on delete cascade
);

INSERT INTO talebeler VALUES(123, 'Ali Can', 'Hasan',75);
INSERT INTO talebeler VALUES(124, 'Merve Gul', 'Ayse',85);
INSERT INTO talebeler VALUES(125, 'Kemal Yasa', 'Hasan',85);
INSERT INTO talebeler VALUES(126, 'Nesibe Yılmaz', 'Ayse',95);
INSERT INTO talebeler VALUES(127, 'Mustafa Bak', 'Can',99);
INSERT INTO notlar VALUES ('123','kimya',75);
INSERT INTO notlar VALUES ('124', 'fizik',65);
INSERT INTO notlar VALUES ('125', 'tarih',90);
INSERT INTO notlar VALUES ('126', 'Matematik',90);

select * from talebeler;
select * from notlar;

DELETE from notlar where talebe_id='123';-- child
-- child tablodaki veriyi sildiğimiz zaman sadece child'daki veri silinir. parent taki veri silinmez.
DELETE from talebeler where id='126';-- parent
-- parent tablodaki veriyi sildiğimiz zaman child'daki veride silinir.
DELETE FROM talebeler; -- Parent tablo ile birlikte child tablo daki verileride siler


--IN CONDITION
CREATE TABLE musteriler  (
urun_id int,
musteri_isim varchar(50),
urun_isim varchar(50)
);
INSERT INTO musteriler VALUES (10, 'Mark', 'Orange');
INSERT INTO musteriler VALUES (10, 'Mark', 'Orange');
INSERT INTO musteriler VALUES (20, 'John', 'Apple');
INSERT INTO musteriler VALUES (30, 'Amy', 'Palm');
INSERT INTO musteriler VALUES (20, 'Mark', 'Apple');
INSERT INTO musteriler VALUES (10, 'Adem', 'Orange');
INSERT INTO musteriler VALUES (40, 'John', 'Apricot');
INSERT INTO musteriler VALUES (20, 'Eddie', 'Apple');

--Tablodan urun_ismi Orange,Apple,Apricot olan dataları getiriniz
Select * from musteriler WHERE urun_isim='Orange' or urun_isim='Apple' or urun_isim='Apricot'
SELECT * FROM musteriler WHERE urun_isim NOT IN ('Orange','Apple','Apricot')
SELECT * FROM musteriler WHERE urun_isim IN ('Orange','Apple','Apricot')

select * from musteriler where urun_isim = 'Orange' and musteri_isim = 'Mark'

--Between condıtıon
-- urun ıd si 20 ile 40 arasında olan dataları cagıralım
select * from musteriler where urun_id>=20 and urun_id<=40
select * from musteriler where urun_id between 20 and 40
select * from musteriler where urun_id not between 20 and 40;


--Practise 6 ödev

---Practice 6
--id'si 1003 ile 1005 arasında olan personel bilgilerini listeleyiniz
--D ile Y arasındaki personel bilgilerini listeleyiniz
--D ile Y arasında olmayan personel bilgilerini listeleyiniz
--Maaşı 70000 ve ismi Sena olan personeli listeleyiniz


CREATE table personel
(
id char(4),
isim varchar(50),
maas int
);

	
insert into personel values('1001', 'Ali Can', 70000);
insert into personel values('1002', 'Veli Mert', 85000);
insert into personel values('1003', 'Ayşe Tan', 65000);
insert into personel values('1004', 'Derya Soylu', 95000);
insert into personel values('1005', 'Yavuz Bal', 80000);
insert into personel values('1006', 'Sena Beyaz', 100000);
	
select * from personel where id between '1003' and '1005'
select * from personel where isim between 'D' and 'Y'
select * from personel where isim not between 'D' and 'Y'
select * from personel where isim='Sena Beyaz' and maas=70000 --- boş cıkar


----SUBQURIES


CREATE TABLE calisanlar2
(
id int,
isim VARCHAR(50),
sehir VARCHAR(50),
maas int,
isyeri VARCHAR(20)
);


INSERT INTO calisanlar2 VALUES(123456789, 'Ali Seker', 'Istanbul', 2500, 'Vakko');
INSERT INTO calisanlar2 VALUES(234567890, 'Ayse Gul', 'Istanbul', 1500, 'LCWaikiki');
INSERT INTO calisanlar2 VALUES(345678901, 'Veli Yilmaz', 'Ankara', 3000, 'Vakko');
INSERT INTO calisanlar2 VALUES(456789012, 'Veli Yilmaz', 'Izmir', 1000, 'Pierre Cardin');
INSERT INTO calisanlar2 VALUES(567890123, 'Veli Yilmaz', 'Ankara', 7000, 'Adidas');
INSERT INTO calisanlar2 VALUES(456789012, 'Ayse Gul', 'Ankara', 1500, 'Pierre Cardin');
INSERT INTO calisanlar2 VALUES(123456710, 'Fatma Yasa', 'Bursa', 2500, 'Vakko');


CREATE TABLE markalar
(
marka_id int,
marka_isim VARCHAR(20),
calisan_sayisi int
);

INSERT INTO markalar VALUES(100, 'Vakko', 12000);
INSERT INTO markalar VALUES(101, 'Pierre Cardin', 18000);
INSERT INTO markalar VALUES(102, 'Adidas', 10000);
INSERT INTO markalar VALUES(103, 'LCWaikiki', 21000);

-- Çalisan sayisi 15.000’den cok olan markalarin isimlerini ve bu markada calisanlarin isimlerini ve maaşlarini listeleyin.
SELECT isim,maas,isyeri from calisanlar2 
where isyeri in (select marka_isim from markalar where calisan_sayisi > 15000);

-- Ankara’da calisani olan markalarin marka id'lerini ve calisan sayilarini listeleyiniz

select marka_isim,marka_id,calisan_sayisi from markalar
where marka_isim in (select isyeri from calisanlar2 where sehir='Ankara')




-- marka_id’si 101’den büyük olan marka çalişanlarinin isim, maaş ve şehirlerini listeleyiniz.
SELECT isim,maas,sehir FROM calisanlar2
WHERE isyeri IN (SELECT marka_isim from markalar WHERE marka_id>101)


--Aggregate Function
Select sum(maas) AS maas_toplam from calisanlar2
select max(maas) AS en_yuksek_maas from calisanlar2
select min(maas) AS en_dusuk_maas from calisanlar2
select avg(maas) AS maas_ortalamalari from calisanlar2
select round(avg(maas)) AS maas_ortalamalri from calisanlar2
select count(maas) AS maas_adedi from calisanlar2


-- Her markanin id’sini, ismini ve toplam kaç şehirde bulunduğunu listeleyen bir SORGU yaziniz.
SELECT marka_id, marka_isim,
(SELECT count(sehir) FROM calisanlar2 WHERE isyeri=marka_isim) AS sehir_sayisi
FROM markalar;