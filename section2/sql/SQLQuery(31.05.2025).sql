---stage tablolar: ara tablolardýr, geçiciler. Dýþ sistemden gelen veriler ilk olarak buraya gelir.
--- stage tablolar tarihsel ya da doldur/boþalt þeklinde tutulabilir.
---fact tablolar: ölçülebilir verileri tutan ve zamanla analiz edilen ana tablolar. kaynaktan ayrýllýyor, biz burada hesaplama ve çýkarýmlar yapýyoruz 
---fact tablolar tarihsel tutulur ve milyonlarca veri demek olabilir
---dimension tablolar: veriye ait bilgiler vs var, string ve açýklamalarýn olduðu tablolardýr. Distinct olmak zorunda
---dimension'da tek veri olmalý. bir þube olsun ama birden fazla ürün satsýn(fact tablo)
---users tablo dimension tablo (1 müþteri ve özellikleri)
---orders tablosu fact tablo, ayný müþteri tekrar ediyor
---datamartlar, veri ambarýnýn küçük özelleþtirilmiþ versiyonudur

---excel örnek açýklamasý
---patika sitesinde API ile veri alacaðým
--- öðrenci ad-soyad, doðum tarihi, cinsiyet, üni, eðitime baþlama tarihi, eðitimi bitirme tarihi, eðitim açýklamasý
---dwh-stg kýsmýnda tüm bilgileri aldým, ister doldur/boþalt ister tarihsel tut. Her gece 12'de çekeyim verileri
---dwh-fact kýsmýnda doðum tarihine göre yaþ hesaplayabilirim.
---ben eðitimi ne kadar sürede bitirdiklerini merak ediyorum öðreencilerin: 
--- dwh-fact kýsmýnda bitirme tarihi - baþlama tarihi yaparým ve bulurum.
--- dwh-fact eðitimleri kategorize etmek isityorum burada eðitim açýklama kýsmýný kullanarak yapabilirim

---dwh-datamart, IK diyecek ki bazý bilgilre lazým, öðrencilere bakarak yeni eðitimler önereceðim.
--- buradaki datamartlar daha özelleþtirilmiþ mesela öðrenci performansý 
--- datamart kullanýlmabilir de þirket, fact'den direkt çekilebilir bilgi ama mesela kupon kullanýmý reklamcýnýn iþi ama yöneticiyi ilgilendirmiyor çok.
---salesorder bir nevi datamart, birçok tablo birleþtirilerek oluþturulmuþ
--- datamartlarda joinlere dikkat, tekrarlama yapmayalým


---veritabaný þemalarý
---yýldýz þemasý: fact tablosu ortada ve ilgili dimension tablolar etrafýnda
---snowflake (kar tanesi) þemasý: ortasý yine yýldýz þemasý ama dimensionlara da tablo ekliyoruz onlar da dallanýyor

select * from [dbo].TOWNS where CITYID=6
select * from [dbo].ORDERDETAILS
select * from [dbo].ORDERS
select * from [dbo].TOWNS
select ID,USERNAME_ from [dbo].SALEORDERS ---bu bir datamart (birçok veri burada toplanmýþ)
---bir tabloda statik bir veri varsa þube bilgisi gibi, dimension 
---orders tablosu sürekli bir sipariþ gelir dinamiktir

select * from ORDERS
select * from ADDRESS
---inner join
select * from ORDERS O
inner join [ADDRESS] A on O.ADDRESSID=A.ID

select * from ORDERS O
inner join [ADDRESS] A on O.ADDRESSID = A.ID
where O.USERID = 2
order by o.ID ---order'daki user id ye göre sýrala


select * from ORDERS O
right join [ADDRESS] A on O.ADDRESSID = A.ID
where A.ID = 25045

select * from USERS

select * from USERS U
left join [ADDRESS] AD on AD.USERID = U.ID
where U.ID = 9367

select * from [ADDRESS] AD where AD.USERID = 9347

select distinct STATUS_ from ORDERS

---categoriye  cirolar
select CATEGORY1,sum(LINETOTAL) as TOTALCIRO from ORDERS O
inner join ORDERDETAILS OD on O.ID = OD.ORDERID
inner join ITEMS IT on IT.ID = OD.ITEMID
group by CATEGORY1 order by 2 DESC


---en fazla alýþveriþ hangi markada yapýlmýþ?

select BRAND, SUM(LINETOTAL) MARKATOPLAMCIRO from ORDERS O
inner join ORDERDETAILS OD on O.ID=OD.ORDERID
inner join ITEMS IT on IT.ID = OD.ITEMID
group by BRAND order by 2 desc

---ev ana kategorisinde, kitap-dergi-kýrtasiye üst kategori, kitap alt en fazla satýþ yapan kitaplar
select IT.ITEMNAME,sum(AMOUNT) from ORDERS O
inner join ORDERDETAILS  OD on O.ID = OD.ORDERID
inner join ITEMS IT on IT.ID = OD.ITEMID
where CATEGORY1 = 'EV' 
and CATEGORY2 = 'KITAP-DERGI-KIRTASIYE' 
and CATEGORY3 = 'KITAP'
group by IT.ITEMNAME order by 2 desc

---oyuncak kategorisinde ürünlerin ortalama fiyatý nedir
SELECT 
CATEGORY1,
SUM(LINETOTAL) AS CIRO,
SUM(AMOUNT) AS ADET,
SUM(LINETOTAL)/SUM(AMOUNT) AS ORTFÝYAT
FROM ORDERS O
INNER JOIN ORDERDETAILS OD ON O.ID = OD.ORDERID
INNER JOIN ITEMS IT ON IT.ID=OD.ITEMID
WHERE CATEGORY1='OYUNCAK'
GROUP BY CATEGORY1

---kozmetikte þampuan kategorisinde en düþük birim fiyat hangi markanýn
SELECT DISTINCT BRAND,CATEGORY3
FROM ITEMS
WHERE CATEGORY1='KOZMETIK'
AND CATEGORY3 LIKE '%SAMPU%' ORDER BY 1

---þampuan markalarýna göre birim fiyat


SELECT DISTINCT BRAND, MIN(OD.UNITPRICE) AS BIRIMFIYAT
FROM ORDERS O 
INNER JOIN ORDERDETAILS OD ON O.ID = OD.ORDERID
INNER JOIN ITEMS IT ON IT.ID=OD.ITEMID
WHERE CATEGORY1='KOZMETIK' AND CATEGORY3 LIKE '%SAMPUAN%'
GROUP BY BRAND ORDER BY 2 DESC
---mesela ben maaliyetten kýsmak istersem sebamed'den deðil de dove'dan þampuan alcam artýk


---hangi yaþ gruplarý daha fazla alýþveriþ yapmýþ?
SELECT AGE,SUM(AMOUNT) TOPLAMADET FROM ORDERS O 
INNER JOIN ORDERDETAILS OD ON O.ID=OD.ORDERID
INNER JOIN USERS U ON U.ID=O.USERID
GROUP BY AGE
ORDER BY 1 DESC
---demek ki daha çok yaþ grubu yüksek kiþilere satýþ yapýyorum

---PEKÝ YAÞLILAR NE ALMIÞ BENDEN?
SELECT CATEGORY1,CATEGORY2,CATEGORY3,CATEGORY4,SUM(AMOUNT) TOPLAMADET FROM ORDERS O 
INNER JOIN ORDERDETAILS OD ON O.ID=OD.ORDERID
INNER JOIN USERS U ON U.ID=O.USERID
INNER JOIN ITEMS IT ON IT.ID = OD.ITEMID
WHERE AGE=85
GROUP BY CATEGORY1,CATEGORY2,CATEGORY3,CATEGORY4
ORDER BY 5 DESC
---PEKÝ KIRTASÝYE GEREÇLERÝNDEN NE ALMIÞLAR
SELECT ITEMNAME,SUM(AMOUNT) TOPLAMADET FROM ORDERS O 
INNER JOIN ORDERDETAILS OD ON O.ID=OD.ORDERID
INNER JOIN USERS U ON U.ID=O.USERID
INNER JOIN ITEMS IT ON IT.ID = OD.ITEMID
WHERE AGE=85 AND CATEGORY4='KIRTASIYE GERECLERI'
GROUP BY ITEMNAME
ORDER BY 2 DESC

---KADINLAR NE ALMIÞ
SELECT CATEGORY1, CATEGORY2, CATEGORY3,CATEGORY4, SUM(LINETOTAL) FROM ORDERS O 
INNER JOIN ORDERDETAILS OD ON O.ID=OD.ORDERID
INNER JOIN USERS U ON U.ID=O.USERID
INNER JOIN ITEMS IT ON IT.ID = OD.ITEMID
WHERE GENDER='K'
GROUP BY CATEGORY1,CATEGORY2,CATEGORY3,CATEGORY4
ORDER BY 5 DESC

----KADINLAR DAHA ÇOK BEBE OYUNCAKLARI ALMIÞ
SELECT ITEMNAME, SUM(LINETOTAL) FROM ORDERS O 
INNER JOIN ORDERDETAILS OD ON O.ID=OD.ORDERID
INNER JOIN USERS U ON U.ID=O.USERID
INNER JOIN ITEMS IT ON IT.ID = OD.ITEMID
WHERE GENDER='K' AND CATEGORY4='BEBE OYUNCAK'
GROUP BY ITEMNAME
ORDER BY 2 DESC


---- 18-35 YAÞ ARASI GRUBU NELER ALMIÞ?
SELECT CATEGORY1, CATEGORY2, CATEGORY3,CATEGORY4, SUM(LINETOTAL) LINETOTAL 
FROM ORDERS O 
INNER JOIN ORDERDETAILS OD ON O.ID=OD.ORDERID
INNER JOIN USERS U ON U.ID=O.USERID
INNER JOIN ITEMS IT ON IT.ID = OD.ITEMID
WHERE AGE BETWEEN 18 AND 35 AND CATEGORY1='GIDA'
GROUP BY CATEGORY1,CATEGORY2,CATEGORY3,CATEGORY4
ORDER BY 5 DESC