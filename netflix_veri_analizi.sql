-- database oluşturarak projeme başladım!
create database netflix_data_analyze;
use netflix_data_analyze;

-- her şeyin öncesinde bir adet tablo oluşturdum. 
CREATE TABLE netflix_raw_data (
show_id varchar(50) PRIMARY KEY,
icerigin_turu varchar(100),
film_adi varchar(300),
yonetmen varchar(500),
oyuncular varchar(MAX),
ulke varchar(300),
eklenilen_tarih date,
yayin_tarihi int,
yas_siniri varchar(300),
uzunluk varchar(50),
kategoriler varchar(300),
ozet varchar(MAX)
);
-- ardından kaggle'dan buldugum datayı import ederek düzenleyip incelemeye başladım

-- Veride ne var ne yok diye ilk 50 satıra baktım
select top 50 * from netflix_raw_data

-- icerik turlerinin sayısını inceledim
select count(distinct icerigin_turu) as farkli_icerik_turu from netflix_raw_data;

-- toplam veri sayısına göz attım
select count (*) from netflix_raw_data;

-- yonetmeni boş değerli gözüken icerikleri inceledim
select * from netflix_raw_data where yonetmen is null;

--yayınlanma tarihine gore sayısına baktım
select yayin_tarihi, count(*) as toplam_icerik from netflix_raw_data group by yayin_tarihi order by yayin_tarihi;

-- icerigin turune gore sayısına baktım
select icerigin_turu, count(*) as toplam_icerik from netflix_raw_data group by icerigin_turu;

-- farklı reytinglerde içerik sayısına baktım
select yas_siniri, count(*) as toplam_icerik from netflix_raw_data group by yas_siniri order by toplam_icerik desc;

-- filmlerin uzunluklarına göre içerik sayısına baktım
select uzunluk, count(*) as toplam_icerik from netflix_raw_data group by uzunluk order by toplam_icerik desc;

-- farklı kategorilerin sayısını buldum
select trim(value) as tur, count(*) as toplam_icerik from netflix_raw_data

cross apply string_split(kategoriler, ',')
where kategoriler is not null group by trim(value) order by toplam_icerik desc;

--veri temizleme ve normalleştirme işlemleri 

--yayın tarihi mantıksız verileri sil
update netflix_raw_data set yayin_tarihi = null where yayin_tarihi <= 1800 OR yayin_tarihi > year(getdate());

--tekrar eden verileri öncelikle görmek istedim.
select film_adi, yayin_tarihi, count (*) as tekrar_sayisi from netflix_raw_data group by film_adi, yayin_tarihi having count(*) > 1;

--ardından ise tekrar eden verileri temizledim.
with tekrar_eden_veri as (
select *, row_number() over(PARTITION BY film_adi,yayin_tarihi ORDER BY show_id) AS sira from netflix_raw_data
)
delete from tekrar_eden_veri where sira > 1;

-- null degerleri türkçeleştirmeye ve anlamlandırmaya çalıştım.
update netflix_raw_data set yonetmen = 'Bilinmiyor' where yonetmen is null;
update netflix_raw_data set ulke = 'Bilinmiyor' where ulke is null;
update netflix_raw_data set oyuncular = 'Bilinmiyor' where oyuncular is null;
update netflix_raw_data set yas_siniri = 'Bilinmiyor' where yas_siniri is null;
update netflix_raw_data set uzunluk = 'Bilinmiyor' where uzunluk is null;

select count(*) as toplam_icerik,
sum(case when yonetmen = 'Bilinmiyor' then 1 else 0 end) as bilinmeyen_yonetmen,
sum(case when ulke = 'Bilinmiyor' then 1 else 0 end) as bilinmeyen_ulke,
sum(case when oyuncular = 'Bilinmiyor' then 1 else 0 end) as bilinmeyen_oyuncular,
sum(case when yas_siniri = 'Bilinmiyor' then 1 else 0 end) as bilinmeyen_yas_siniri,
sum(case when uzunluk = 'Bilinmiyor' then 1 else 0 end) as bilinmeyen_uzunluk,
sum(case when kategoriler is null then 1 else 0 end) as bilinmeyen_kategori from netflix_raw_data;

-- yonetmen tablosu oluşturarak veriyi daha az göz yoracak şekile getirmeye çalıştım.
create table Yonetmenler (
yonetmen_id int identity(1,1) primary key,
yonetmen_adi varchar(300) 
);
insert into Yonetmenler(yonetmen_adi) select distinct yonetmen from netflix_raw_data where yonetmen is not null;

-- ulke tablosunu da oluşturdum.
create table Ulkeler (
ulke_id int identity(1,1) primary key,
ulke_adi varchar(200) 
);
insert into ulkeler(ulke_adi) select distinct ulke from netflix_raw_data where ulke is not null;

-- showların tablosunuda aynı şekilde oluşturdum.
create table Showlar (
show_id int identity(1,1) primary key,
raw_show_id varchar(20),
icerigin_turu varchar(300) not null,
yayin_tarihi int,
yas_siniri varchar(20),
eklenilen_tarih date,
uzunluk varchar(50),
ozet varchar(MAX),
yonetmen_id INT,
ulke_id int,
foreign key (yonetmen_id) references Yonetmenler(yonetmen_id),foreign key (ulke_id) references Ulkeler(ulke_id)
);
insert into Showlar(raw_show_id, icerigin_turu, yayin_tarihi, yas_siniri,eklenilen_tarih, uzunluk, ozet, yonetmen_id, ulke_id) select ns.show_id,ns.icerigin_turu,ns.yayin_tarihi, ns.yas_siniri,ns.eklenilen_tarih,ns.uzunluk,ns.ozet,ytn.
yonetmen_id,ue.ulke_id from netflix_raw_data ns left join Yonetmenler ytn ON ns.yonetmen = ytn.yonetmen_adi  left join Ulkeler ue on ns.ulke = ue.ulke_adi;

-- kategorileri de tablolaştırarak tablolar arası ilişkilendirmeyi arttırmayı hedefledim.
create table Turler (
tur_id int identity(1,1) primary key,
tur_adi varchar(100) 
);
insert into Turler(tur_Adi) select distinct trim(value) from netflix_raw_data, string_split(kategoriler, ',') where kategoriler is not null;

-- show ve turler arasında ilişki kurmak kolaylaşsın diye show turlerinin tablosunu oluşturdum. id ile daha rahat takip edilebilir.
create table Show_Turleri(
show_id int,
tur_id int,
primary key(show_id,tur_id),
foreign key(show_id) references Showlar(show_id),
foreign key(tur_id) references Turler(tur_id)
);
insert into Show_Turleri(show_id,tur_id) select s.show_id,t.tur_id from netflix_raw_data nr join Showlar s on nr.show_id=s.raw_show_id join Turler t on charindex(t.tur_adi,nr.kategoriler)>0

--ülkelerin toplam içerik sayısı:
select cntry.ulke_adi, count(*) as toplam from Showlar shws join Ulkeler cntry ON shws.ulke_id=cntry.ulke_id group by cntry.ulke_adi order by  toplam desc;

--yonetmenlerin toplam içerik sayısı:
select drctr.yonetmen_adi, count(*) as toplam from Showlar shws join Yonetmenler drctr ON shws.yonetmen_id=drctr.yonetmen_id group by drctr.yonetmen_adi order by toplam desc;

--turlerin toplam içerik sayısı:
select typ.tur_adi, count(*) as toplam from Show_Turleri styp join Turler typ on styp.tur_id=typ.tur_id group by typ.tur_adi order by toplam desc;

--senesine göre toplam içerik sayısı:
select yayin_tarihi, count(*) as toplam_icerik from Showlar where yayin_tarihi is not null group by yayin_tarihi order by toplam_icerik desc;