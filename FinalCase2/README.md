# 📊 Nestlé Satış ve Müşteri Analiz Dashboard'u

Bu Power BI projesi, Nestlé markası özelinde satış ve müşteri verilerinin analizini yapmak, üç farklı bakış açısından içgörüler sunmak ve veriye dayalı kararlar desteklemek amacıyla geliştirilmiştir.

> 🔗 [Rapor Dosyaları - Google Drive Klasörü](https://drive.google.com/drive/folders/19FpTMjQR0jMATgAhumqUW4CNmBRXaPAL?usp=sharing)  
> `.pbix` dosyası ve görseller bu klasörde yer almaktadır.  
> Erişim: Herkese açık (görüntüleme)

---

## 🎯 Proje Amacı

Bu proje; kullanıcı, sipariş ve ürün verilerinin temizlenip modellenmesiyle birlikte Nestlé markasına özel üç ana perspektifte analiz sağlamayı hedeflemektedir:

- Özet satış görünümü
- Müşteri davranışları
- Ürün kategorilerine göre ciro dağılımı

---

## 🗂️ Veri Kaynağı ve Hazırlık Adımları

### `Users` → **kullanıcılar**
- Doğum tarihinden yaş hesaplandı.
- Cinsiyet verisi E/K → KADIN/ERKEK olarak değiştirildi.
- Ad ve soyad ayrıştırıldı.
- Gereksiz kolonlar silindi veya gizlendi.

### `Address` → **adres**
- Şehir ve kullanıcı ID birleştirildi.
- Bölge eşleşmesi için ilişki kuruldu.

### `Items` → **ürünler**
- Kategori kolonları Türkçeye çevrildi.
- `YENIANAKATEGORI` adında yeni bir sütun eklendi (içecek gruplaması).

### `OrderDetail` → **siparisdetay**
- Tüm sayısal alanlar kontrol edildi.

### `Orders` → **siparis**
- Saat bilgisi ayrılarak yalnızca tarih tutulan kolon üretildi.

### `Regions` → **bölgeler**
- İnternetten alınarak manuel eklendi.
- `İL` sütunu `adres` tablosuyla ilişkilendirildi.

---

## 🔄 Veri Modeli

Kurulan anahtar ilişkiler:
- kullanıcılar → siparis → siparisdetay
- siparis → adres
- siparisdetay → ürünler
- adres → bölgeler

Gizlenmesi gereken alanlar (id gibi) model ekranında kullanıcıdan gizlendi.

---

## 📋 Ölçüler (DAX)

### Genel Ölçüler
- Toplam Satış Adedi  
- Toplam Ciro  
- Toplam Müşteri Sayısı  
- Toplam Sipariş Sayısı  
- Müşteri Başına Ciro  
- Müşteri Başına Adet  
- Ortalama Sipariş Tutarı  
- Saatlik Satış  (grafikle hesaplandı)
- Haftaiçi/Haftasonu Satışı  (grafikle hesaplandı)

### Müşteri Bazlı Ölçüler
- Kadın Sayısı (CALCULATE + FILTER)
- Erkek Sayısı
- Yaş Grubu Sütunu (Koşullu: 0–20, 21–35, 36–55, 55+) 

---

## 📊 Dashboard Sayfaları

### 🏠 Giriş Sayfası
- Nestlé logosu, sade başlık
- Butonlarla yönlendirme: sadece bu sayfa görünür, diğerlerine tıklanarak geçilir
- Bu proje özelindeki kazanımlarım ve önemli noktalara değinilmiştir

### 📈 Özet Sayfa
- Haftaiçi / haftasonu satış grafiği
- Saatlik satış grafiği
- Bölgelere göre satış
- Kartlarda temel KPI’lar

### 👥 Müşteri Perspektifi
- Tekil, kadın ve erkek müşteri sayısı (kart)
- Bölgelere göre müşteri dağılımı
- İstanbul’daki top 10 müşteri
- Yaş grubuna göre satış grafiği

### 🧱 Kategori Perspektifi
- İstanbul’da yaşayan orta yaşlı müşterilerin cirosu 
- Ciro dağılımı kategori bazlı **ağaç haritası** ile gösterildi
- Kategori bazlı bölge cirosu
- Üst kategoriye göre satış adedi

---

## 💡 Notlar

- Tüm sayfalar sade ve kullanıcı dostu olacak şekilde tasarlanmıştır.
- Giriş sayfası dışındaki sayfalar gizlidir, sadece butonlarla erişilir.
- Ölçüler ve sütunlar DAX fonksiyonları ile profesyonel şekilde hazırlanmıştır.

---

## 📁 Dosya Boyutu Hakkında

Power BI `.pbix` dosyası boyutu yüksek olduğu için GitHub’a doğrudan yüklenememiştir. Bunun yerine Google Drive bağlantısı sağlanmıştır:

> 📎 [Raporu ve ilgili dosyaları görüntülemek için tıklayın](https://drive.google.com/drive/folders/19FpTMjQR0jMATgAhumqUW4CNmBRXaPAL?usp=sharing)

---
