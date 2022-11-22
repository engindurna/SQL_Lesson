--- order by

CREATE TABLE insanlar2
(
ssn char(9),
isim varchar(50),
soyisim varchar(50),
adres varchar(50)
);

INSERT INTO insanlar2 VALUES(123456789, 'Ali','Can', 'Istanbul');
INSERT INTO insanlar2 VALUES(234567890, 'Veli','Cem', 'Ankara');
INSERT INTO insanlar2 VALUES(345678901, 'Mine','Bulut', 'Ankara');
INSERT INTO insanlar2 VALUES(256789012, 'Mahmut','Bulut', 'Istanbul');
INSERT INTO insanlar2 VALUES (344678901, 'Mine','Yasa', 'Ankara');
INSERT INTO insanlar2 VALUES (345678901, 'Veli','Yilmaz', 'Istanbul');

select * from insanlar2

-- Insanlar tablosundaki ismi Mine olanlari SSN sirali olarak listeleyin
select * from insanlar2 order by adres

-- Insanlar tablosundaki ismi Mine olanlari SSN sirali olarak listeleyin
select * from insanlar2 where isim='Mine' order by ssn;


-- Insanlar tablosundaki soyismi Bulut olanlari adres sirali olarak listeleyin
select * from insanlar2 where soyisim='Bulut' order by adres;

--Insanlar tablosundaki tum kayitlari SSN numarasi buyukten kucuge olarak siralayin

select * from insanlar2 order by ssn desc;

--Insanlar tablosundaki tum kayitlari SSN numarasi kucukten buyuge olarak siralayin ---dogal sıralama

select * from insanlar2 order by ssn asc;

--Insanlar tablosundaki tum kayitlari isimleri  natural sırala soy isimleri terstten  olarak siralayin
select * from insanlar2 order by isim asc, soyisim desc;


-- İsim ve soyisim değerlerini isim kelime uzunluklarına göre sıralayınız

select isim,soyisim from insanlar2 order by  length(isim)


-- Tüm isim ve soyisim değerlerini aynı sutunda çağırarak her bir sütun değerini uzunluğuna göre sıralayınız
select concat (isim,' ',soyisim) as isim_soyisim from insanlar2
order by length(isim)+length(soyisim)
--veya
select isim||' '||soyisim as isim_soyisim from insanlar2
order by length(isim||soyisim)

CREATE TABLE manav
(
isim varchar(50), Urun_adi varchar(50), Urun_miktar int
);

INSERT INTO manav VALUES( 'Ali', 'Elma', 5);
INSERT INTO manav VALUES( 'Ayse', 'Armut', 3);
INSERT INTO manav VALUES( 'Veli', 'Elma', 2);
INSERT INTO manav VALUES( 'Hasan', 'Uzum', 4);
INSERT INTO manav VALUES( 'Ali', 'Armut', 2);
INSERT INTO manav VALUES( 'Ayse', 'Elma', 3);
INSERT INTO manav VALUES( 'Veli', 'Uzum', 5);
INSERT INTO manav VALUES( 'Ali', 'Armut', 2);
INSERT INTO manav VALUES( 'Veli', 'Elma', 3);
INSERT INTO manav VALUES( 'Ayse', 'Uzum', 2);

select * from manav


--- Isme gore alinan toplam urunleri bulun

select isim,sum(urun_miktar) as toplam_urun_miktar from manav 
group by isim order by isim

--- urun adına gore alinan toplam urunleri bulun
select urun_adi, sum(urun_miktar) as toplam_urun_miktar from manav group by urun_adi


-- Urun ismine gore urunu alan toplam kisi sayisi

select urun_adi, count(isim) as urun_alan_kisi_sayisi from manav
group by urun_adi; 


-- Alinan kilo miktarina gore musteri sayisi
SELECT urun_miktar,COUNT(isim) AS alinan_urunler_kisi_sayisi FROM manav
GROUP BY urun_miktar


CREATE TABLE personel2
(
id int,
isim varchar(50),
sehir varchar(50),
maas int,
sirket varchar(20)
);


INSERT INTO personel2 VALUES(123456789, 'Ali Yilmaz', 'Istanbul', 5500, 'Honda');
INSERT INTO personel2 VALUES(234567890, 'Veli Sahin', 'Istanbul', 4500, 'Toyota');
INSERT INTO personel2 VALUES(345678901, 'Mehmet Ozturk', 'Ankara', 3500, 'Honda');
INSERT INTO personel2 VALUES(456789012, 'Mehmet Ozturk', 'Izmir', 6000, 'Ford');
INSERT INTO personel2 VALUES(567890123, 'Mehmet Ozturk', 'Ankara', 7000, 'Tofas');
INSERT INTO personel2 VALUES(456789012, 'Veli Sahin', 'Ankara', 4500, 'Ford');
INSERT INTO personel2 VALUES(123456710, 'Hatice Sahin', 'Bursa', 4500, 'Honda');


select * from personel2



-- isme  gore toplam maasları bulun

select isim , sum(maas) as isme_göre_toplam_maas from personel2
group by isim

-- sehre gore toplam personel sayisini bulun

select sehir,count(isim) as toplam_kisi from personel2
group by sehir;

-- Sirketlere gore maasi 5000 liradan fazla olan personel sayisini bulun

select sirket ,count(*) as calisan_sayisi from personel2
where maas > 5000
group by sirket;


--Her sirket icin Min ve Max maasi bulun
select sirket ,min(maas) as en_az_maas,max(maas) as en_yuksek_maas from personel2
group by sirket


---HAVİNG KOMUTU
--Her sirketin MIN maaslarini eger 3500’den buyukse goster

SELECT sirket,min(maas) as en_dusuk_maas FROM personel2
GROUP BY sirket
HAVING min(maas)>3500


----Ayni isimdeki kisilerin aldigi toplam gelir 10000 liradan fazla ise ismi ve toplam maasi gosteren sorgu yaziniz

select isim, sum(maas) as toplam_maas from personel2
group by isim
having sum(maas) > 10000

--Eger bir sehirde calisan personel sayisi 1’den coksa sehir ismini ve personel sayisini veren sorgu yaziniz

select sehir, count(isim) as toplam_insan_sayisi from personel2
group by sehir
having count(isim) > 1