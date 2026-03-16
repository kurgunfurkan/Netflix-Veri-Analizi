# Netflix SQL Veri Analizi

Bu proje, Netflix veri seti kullanılarak SQL Server üzerinde veri temizleme, normalizasyon ve temel analiz süreçlerini göstermek amacıyla hazırlanmıştır. Amaç, ham verileri daha anlaşılır ve analiz edilebilir bir formata dönüştürmek ve portfolyo için gösterilebilir bir veri analizi örneği sunmaktır.

## Projenin Amacı
- Ham Netflix verilerini SQL Server üzerinde işleyerek analiz edilebilir hale getirmek.
- Tekrarlayan ve eksik verileri temizlemek, boş alanları anlamlı bir şekilde doldurmak.
- Yönetmenler, ülkeler ve içerik türleri gibi verileri normalize ederek ilişkili tablolar oluşturmak.
- İçeriklerin dağılımını, yayın yılına göre sayısını, yönetmen ve ülke bazlı içerik yoğunluğunu analiz etmek.

## Kullanılan Tablolar
- `netflix_raw_data`: Ham veri seti.
- `Yonetmenler`: Yönetmen bilgileri.
- `Ulkeler`: Ülke bilgileri.
- `Turler`: İçerik türleri.
- `Showlar`: Temizlenmiş ve normalize edilmiş ana içerik tablosu.
- `Show_Turleri`: İçerik ve tür ilişkileri.

## Kullanım
1. SQL Server Management Studio açın.
2. `netflix_veri_analizi.sql` dosyasını çalıştırın.
3. Tablolar oluşturulacak ve veri temizleme işlemleri tamamlanacak.
4. Hazır tablolar üzerinden örnek analiz sorgularını çalıştırabilirsiniz.

## Katkılar
- Veri temizleme ve normalize etme süreci tamamen bana aittir.
- SQL kodları adım adım yorumlarla açıklanmıştır.
- Bu proje, veri analizi ve SQL becerilerimi göstermek için hazırlanmıştır.
Örnek Sorgu Çıktıları

## Sorgularda kullandığım kodların örnek outputları

Ülkelere Göre Toplam İçerik Sayısı:
Ülke	                Toplam İçerik
United States	             2818
India	                      972
United Kingdom	            419
Japan	                      245
South Korea	                199


Yönetmenlere Göre İçerik Sayısı:
  Yönetmen	        Toplam İçerik
Rajiv Chilaka	           19
Raúl Campos	             18
Marcus Raboy	           16
Jay Karas	               14
Cathy Garcia-Molina	     13


Türlere Göre İçerik Dağılımı
Tür	                     Toplam İçerik
International Movies	       2752
Dramas	                     2427
Comedies	                   1674
Documentaries               	869
Action & Adventure          	859


Yayın Yılına Göre İçerik Sayısı
Yayın Yılı	         Toplam İçerik
2018	                    1147
2019	                    1030
2020                      953
2017	                    839
2016	                    726

