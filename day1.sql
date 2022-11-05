create table ogrenciler
(
id char(4),
isim_soyisim varchar(30),
not_ort real,
kayit_tarih date
);
-- var olan bir tablodan yeni bir tablo oluşturma
create table ogrenci_ortalama
as
select isim_soyisim,not_ort
from ogrenciler;
--select dql
select *from ogrenciler  -- bir tablodaki tüm verileri cagırmak için * kullanırız sonda ki ; şart değil 
select * from ogrenci_ortalama; 
select isim_soyisim from ogrenciler-- bir tablodan sadece bir veya birkaç field cagırmak için
select isim_soyisim,kayit_tarih from ogrenciler