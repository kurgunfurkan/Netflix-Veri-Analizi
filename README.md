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
