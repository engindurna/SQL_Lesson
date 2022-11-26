--FETCH NEXT (SAYI) ROW ONLY - OFFSET Kullanımı
select * from musteri_urun
--Sirali tablodan ilk 3 kaydi listeleyin
SELECT * FROM musteri_urun
ORDER BY urun_id
FETCH NEXT 3 ROW ONLY
--Sirali tablodan 4. kayittan 7.kayida kadar olan kayitlari listeleyin
SELECT * FROM musteri_urun
ORDER BY urun_id
OFFSET 3 ROW -- 3 satır atla
FETCH NEXT 4 ROW ONLY -- Sonra 4 satırı getir



-- ALTER TABLE -- Tablodaki sutun ekleme field'daki veri tipini değiştirme,
--tablo adını değiştirme gibi tablodaki güncelleme işlemleri için kullanılır


CREATE TABLE personel3  (
id int,
isim varchar(50),
sehir varchar(50),
maas int,
sirket varchar(20)
);


INSERT INTO personel3 VALUES(123456789, 'Ali Yilmaz', 'Istanbul', 5500, 'Honda');
INSERT INTO personel3 VALUES(234567890, 'Veli Sahin', 'Istanbul', 4500, 'Toyota');
INSERT INTO personel3 VALUES(345678901, 'Mehmet Ozturk', 'Ankara', 3500, 'Honda');
INSERT INTO personel3 VALUES(456789012, 'Mehmet Ozturk', 'Izmir', 6000, 'Ford');
INSERT INTO personel3 VALUES(567890123, 'Mehmet Ozturk', 'Ankara', 7000, 'Tofas');
INSERT INTO personel3 VALUES(456715012, 'Veli Sahin', 'Ankara', 4500, 'Ford');
INSERT INTO personel3 VALUES(123456710, 'Hatice Sahin', 'Bursa', 4500, 'Honda');
DROP TABLE if exists personel; -- Eğer tablo varsa siler

select * from personel3

--1) ADD default deger ile tabloya bir field ekleme
ALTER TABLE personel3
ADD ulke_ismi varchar(20)

-- DEFAULT değer olarak atama yapmak
ALTER TABLE personel3
ADD sehir_ismi varchar(20) DEFAULT 'Istanbul'

--Tabloya birden fazla field ekleme
ALTER TABLE personel3
ADD gender char(1), ADD okul varchar(10);

--3) DROP tablodan sutun silme
ALTER TABLE personel3
DROP COLUMN gender

--4) RENAME COLUMN sutun adi degistirme
ALTER TABLE personel3
RENAME COLUMN ulke_ismi TO ulke_adi
select * from isciler

--RENAME tablonun ismini degistirme
ALTER TABLE personel3
RENAME TO isciler

--TYPE/SET sutunlarin ozelliklerini degistirme
ALTER TABLE isciler
ALTER COLUMN sehir_ismi TYPE varchar(15)
ALTER TABLE isciler
ALTER COLUMN sirket SET NOT NULL
ALTER TABLE isciler
ALTER COLUMN ulke_adi TYPE int USING(ulke_adi::int) --String bir data tipini int. yapmak için bu şekilde kullanırız



---TRANSACTION  (BEGIN  SAVEPOINT ROLLBACK COMMIT)

CREATE TABLE ogrenciler2
(
id serial,
isim VARCHAR(50),
veli_isim VARCHAR(50),
yazili_notu real
);


BEGIN;
INSERT INTO ogrenciler2 VALUES(default, 'Ali Can', 'Hasan',75.5);
INSERT INTO ogrenciler2 VALUES(default, 'Merve Gul', 'Ayse',85.3);
savepoint x;
INSERT INTO ogrenciler2 VALUES(default, 'Kemal Yasa', 'Hasan',85.6);
INSERT INTO ogrenciler2 VALUES(default, 'Nesibe Yilmaz', 'Ayse',95.3);
savepoint y;
INSERT INTO ogrenciler2 VALUES(default, 'Mustafa Bak', 'Can',99);
INSERT INTO ogrenciler2 VALUES(default, 'Can Bak', 'Ali', 67.5);

ROLLBACK to x;

COMMIT;

select * from ogrenciler2



--practıse

CREATE TABLE personel9(
id int,
isim varchar(50), sehir varchar(50), maas int,
sirket varchar(20)
);

INSERT INTO personel9 VALUES(123456789, 'Johnny Walk', 'New Hampshire', 2500, 'IBM');
INSERT INTO personel9 VALUES(234567891, 'Brian Pitt', 'Florida', 1500, 'LINUX');
INSERT INTO personel9 VALUES(245678901, 'Eddie Murphy', 'Texas', 3000, 'WELLS FARGO');
INSERT INTO personel9 VALUES(456789012, 'Teddy Murphy', 'Virginia', 1000, 'GOOGLE');
INSERT INTO personel9 VALUES(567890124, 'Eddie Murphy', 'Massachuset', 7000, 'MICROSOFT'); 
INSERT INTO personel9 VALUES(456789012, 'Brad Pitt', 'Texas', 1500, 'TD BANK');
INSERT INTO personel9 VALUES(123456719, 'Adem Stone', 'New Jersey', 2500, 'IBM');

CREATE TABLE isciler
(
id int,
isim varchar(50),
sehir varchar(50),
maas int,
sirket varchar(20)
);

INSERT INTO isciler VALUES(123456789, 'John Walker', 'Florida', 2500, 'IBM'); 
INSERT INTO isciler VALUES(234567890, 'Brad Pitt', 'Florida', 1500, 'APPLE'); 
INSERT INTO isciler VALUES(345678901, 'Eddie Murphy', 'Texas', 3000, 'IBM');
INSERT INTO isciler VALUES(456789012, 'Eddie Murphy', 'Virginia', 1000, 'GOOGLE'); 
INSERT INTO isciler VALUES(567890123, 'Eddie Murphy', 'Texas', 7000, 'MICROSOFT'); 
INSERT INTO isciler VALUES(456789012, 'Brad Pitt', 'Texas', 1500, 'GOOGLE');
INSERT INTO isciler VALUES(123456710, 'Mark Stone', 'Pennsylvania', 2500, 'IBM');

--1)Her iki tablodaki ortak id’leri ve personel tablosunda bu id’ye sahip isimleri listeleyen query yaziniz
select isim,id from personel9
where id in (select id from isciler where isciler.id=personel9.id)


--Personel tablosunda id’si cift sayi olan personel’in tum bilgilerini listeleyen Query yaziniz
SELECT * FROM personel9 WHERE MOD(id,2)=0
