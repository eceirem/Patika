# Havayolu Yolcu Memnuniyeti Veri Seti İncelemesi

## İçindekiler

1. [Veri Seti Tanımı](#veri-seti-tanımı)  
2. [Eksik Değer Analizi](#eksik-değer-analizi)  
3. [Aykırı Değer Analizi](#aykırı-değer-analizi)  
4. [Veri Görselleştirme](#veri-görselleştirme)  
5. [Memnuniyet İlişkileri İncelemesi](#memnuniyet-ilişkileri-incelemesi)  
6. [Özel İlişki Analizleri](#özel-ilişki-analizleri)  
7. [Sonuçlar ve Öneriler](#sonuçlar-ve-öneriler)  

---

## Veri Seti Tanımı

- Toplam 25 sütun ve 103,904 kayıt içeren kapsamlı bir havayolu yolcu memnuniyeti veri seti kullanıldı.  
- Sayısal ve kategorik değişkenler mevcut olup, yolcu yaşından uçuş mesafesine, memnuniyet puanlarından seyahat türüne kadar çeşitli bilgiler içeriyor.

## Eksik Değer Analizi

- Veri setinde yalnızca **"Arrival Delay in Minutes"** sütununda eksik değerler tespit edildi (310 satır).
- Eksik değerlerin ortalama ile mi medyan ile mi doldurulacağına karar vermek için [outlier](#aykırı-değer-analizi)  etkisine bakıldı.
- Veri dağılımı çarpık (skewed) ve aykırı, bu yüzden eksik değerler **medyan** ile dolduruldu; böylece veri dağılımının aşırı etkilenmesi önlendi.

## Aykırı Değer Analizi

- Sayısal değişkenlerde özellikle gecikme sürelerinde (Arrival Delay) önemli aykırı değerler gözlemlendi.  
- Aykırı değerlerin etkisi görselleştirmelerle detaylı şekilde incelendi.

## Veri Görselleştirme

- Kategorik değişkenler için **pasta grafiği**, sayısal değişkenler için ise **histogram grafiği** kullanıldı.  
- Verinin dağılımı, yoğunlukları ve merkezi eğilimleri açık şekilde ortaya kondu.

## Memnuniyet İlişkileri İncelemesi

- İki şekilde ele alındı:
### 1) Sayısal Değerler İle  Memnuniyet İlişkileri
- Memnuniyet değişkeni kategorik (satisfied = 1 / neutral or dissatisfied = 0) olarak ikili sayısala dönüştürüldü.  
- Sayısal değişkenler ile memnuniyet arasındaki ilişkiler için **boxplot ve kdeplot** grafikleri ile analiz yapıldı.
- Level Puanlamasına sahip ilişkiler boxplot şeklinde gösterildi.
- Diğer sayısal değerler (Age, Departure Delay, Arrival Delay ve Flight Distance) **kde** (kernel density estimate) yoğunluğa göre ele alındı.
- 
### 2) Kategorik Değerler İle  Memnuniyet İlişkileri
- Kategorik değişkenler (cinsiyet, müşteri tipi, seyahat türü, sınıf) ile memnuniyet ilişkisi **countplot, bar_label grafikleri** ile incelendi.

## Özel İlişki Analizleri

- Business Travel yapan yolcuların çoğunlukla **Business Class'ta** olup olmadıkları incelendi.
- Business Travel yapanların çoğu **erkek** mi? analizi yapıldı.

## Sonuçlar ve Öneriler
### Sonuçlar
- Veri Temizleme aşamasında yalnızca "Arrival Delay in Minutes" sütununda eksik veri olduğu belirlendi ve dağılımın çarpık olması nedeniyle bu değerler medyan ile dolduruldu.
- Aykırı değer analizi, özellikle gecikme verilerinde uç değerlerin bulunduğunu gösterdi. Ancak sadece eksik veri doldurma aşamasında dikkate alındı, modelden çıkarılmadı.
- Sayısal değişkenler ile memnuniyet ilişkisi incelendiğinde, memnun yolcuların yaş ortalaması 45 iken memnun olmayanların ortalaması 35 olarak bulundu. Bu da yaş ilerledikçe memnuniyetin artabileceğini gösteriyor.
- Flight Distance (uçuş mesafesi) arttıkça memnuniyetin de artma eğiliminde olduğu tespit edildi. Bu durum beklentinin karşılanabilmesi adına daha çok süre tanınması ile ilgili olabilir. Çünkü tuvalet/wi-fi/yemek gibi hizmetler yarım saatlik bir uçuşta kullanılmasa da olur.
- Arrival ve Departure Delay değişkenleri üst üste binen dağılımlar gösterdi ve memnuniyet üzerinde belirgin bir etkiye sahip olmadıkları gözlemlendi.
- 0–5 puan arası verilen değerlendirme kriterleri içerisinde; Inflight Wifi Service, Check-in Service, Ease of Online Booking, Food and Drink, Leg Room Service ve Cleanliness memnuniyet üzerinde doğrudan etkili olduğu görüldü. Bu kategorilerde yüksek puan veren yolcular genellikle memnun.
- Cinsiyet değişkeni açısından memnuniyet seviyelerinde belirgin bir fark gözlemlenmedi; erkek ve kadın yolcular benzer düzeyde memnun veya memnuniyetsiz.
- Müşteri tipi değişkeni incelendiğinde, disloyal customers grubunun daha fazla memnuniyetsizlik yaşadığı tespit edildi.
- Seyahat türüne göre analizde, Business Travel yapan yolcuların sayısı daha fazla ve bu grup Personal Travel yapanlara göre daha yüksek memnuniyet seviyelerine sahip.
- Business Travel yapan yolcuların büyük çoğunluğu Business Class’ta uçmakta.
- Business Class yolcuları içinde cinsiyet dağılımı eşit olduğu görüldü.
- Her iki seyahat türünde de sadık müşteri sayısı baskın, ancak disloyal müşteri oranı Business Travel'da daha yüksek.

### Öneriler
- Memnuniyeti artırmak için özellikle yüksek etkili olduğu belirlenen hizmet kalitesi kriterlerine (wifi, yemek, temizlik, bacak mesafesi, kolay rezervasyon vb.) odaklanılmalı ve bu alanlarda sürekli gelişim sağlanmalıdır.
- Business Travel ve Business Class kullanıcıları sadık müşteri kitlesi olma potansiyeline sahip. Bu gruba yönelik özel kampanyalar, sadakat programları geliştirilebilir.
- Genç yolcuların (35 yaş altı) memnuniyetsizlik oranı daha yüksek olduğundan, bu kitlenin beklentilerini anlamaya yönelik *kullanıcı anketleri* yapılabilir.
- Disloyal müşteri segmenti, kaybedilme riski taşıdığı için ayrı bir stratejiyle hedeflenmeli; özel teklifler ve kişiselleştirilmiş iletişim ile memnuniyet artırılabilir.
- Gecikme sürelerinin doğrudan memnuniyetle ilişkisi zayıf olsa da, havalimanı hizmet kalitesi veya süreç yönetimi ile entegre biçimde bu veriler yeniden analiz edilmelidir.
- Uçuş mesafesi uzun olan yolcuların memnuniyet düzeylerinin daha yüksek olması, uzun uçuşlara özel ek hizmetlerle bu memnuniyetin daha da artırılabileceğini göstermektedir.
- Kısa uçuş mesafesi için de bu ek hizmet paketlerinden verilerek memnuniyet arttırılabilir.
- Özellikle disloyal business travel yolcularına odaklanarak memnuniyetsizlik nedenleri derinlemesine incelenmeli.

