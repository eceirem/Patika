---INNER JOIN

---Müþterinin adresleri ile sipariþlerine bakalým. Müþteriler daha çok hangi bölgede oturuyor?

---tablolara bakalým
select * from [dbo].ADDRESS
select * from [dbo].ORDERS
---ortak olan hangi sütunumuz var? USERID
---tablolarý baðlayalým

SELECT DISTINCT STATUS_ FROM ORDERS

SELECT * FROM ORDERS O
INNER JOIN [ADDRESS] A ON O.ADDRESSID = A.ID


---LEFT JOIN
SELECT * FROM ORDERS O 
LEFT JOIN [ADDRESS] A ON O.ADDRESSID = A.ID


---bu müþterinin adresi yok
---user komple getir, ikinci tablodaki eþleþenleri de getir, eþleþmeyenleri null yap.
---left deðil inner dersen müþteriyi göremezsin bu sorguda.
---left join bu yüzden daha güvenli

SELECT * FROM USERS U
LEFT JOIN [ADDRESS] AD ON AD.USERID = U.ID
WHERE U.ID = 9347


SELECT * FROM ORDERS O 
INNER JOIN [ADDRESS] A ON O.ADDRESSID = A.ID AND A.ID=18770

---SORGULAR

--- SORU 1: En fazla alýþveriþ hangi kategoride yapýlmýþtýr?
--- Hangi tabloda kategori var, hangisinde kaç adet spiariþ edildiði yzýyor analizi

SELECT * FROM ITEMS ---kategori burada
SELECT * FROM ORDERDETAILS ---miktar burada
SELECT * FROM ORDERS ---burada item baðlayamýyorum user ve adres bilgiler var
--- bana kategori lazým bu yüzden ilk 2 tabo iþime yarar.


SELECT CATEGORY1, SUM(LINETOTAL) AS TOPLAM_SATIÞ
FROM ORDERDETAILS O
INNER JOIN [ITEMS] IT ON O.ITEMID = IT.ID 
GROUP BY CATEGORY1
ORDER BY 2 DESC---ÝKÝNCÝ KOLONA GÖRE ÇOKTAN AZA GÖRE SIRALA

---Soru 2: En fazla alýþveriþ hangi markada yapýlmýþtýr?
SELECT CATEGORY1 AS ANA_KATEGORÝ, BRAND AS MARKA, SUM(LINETOTAL) AS TOPLAM_SATIÞ
FROM ORDERDETAILS O
INNER JOIN [ITEMS] IT ON O.ITEMID = IT.ID 
GROUP BY CATEGORY1, BRAND
ORDER BY 3 DESC

---Soru 3: Ev ana kategorisinde, 
---kitap-dergi-kýrtasiye üst kategorisinde,
---kitap alt kategorisinde, en fazla satýþ yapan kitaplar?
---kitaplarýn satýþ miktarlarýna göre (adet bak) sýralamam lazým

SELECT CATEGORY1,CATEGORY2,CATEGORY3, IT.ITEMNAME, SUM(AMOUNT)
FROM ORDERDETAILS O
INNER JOIN [ITEMS] IT ON O.ITEMID = IT.ID 
WHERE CATEGORY1 = 'EV' AND CATEGORY2 = 'KITAP-DERGI-KIRTASIYE' AND CATEGORY3='KITAP'
GROUP BY CATEGORY1,CATEGORY2,CATEGORY3, ITEMNAME
ORDER BY 5 DESC


---Soru 4: Oyuncak kategorisinde ürünlerin ortalama fiyatý nedir?
SELECT CATEGORY1, AVG(IT.UNITPRICE) AS ORTALAMA FROM ORDERDETAILS O
INNER JOIN [ITEMS] IT ON O.ITEMID = IT.ID
WHERE CATEGORY1 = 'OYUNCAK'
GROUP BY CATEGORY1
---eðer unit price deðiþmiþ ve kampanyada indirim vs olmuþsa  unit price ortalamda çok düþer. 
---en mantýklýsý total kazaným/adet yapmak


SELECT CATEGORY1, 
SUM(LINETOTAL) AS CIRO, 
SUM(AMOUNT) AS ADET, 
SUM(LINETOTAL)/SUM(AMOUNT) AS ORTALAMA 
FROM ORDERDETAILS O
INNER JOIN [ITEMS] IT ON O.ITEMID = IT.ID
WHERE CATEGORY1 = 'OYUNCAK'
GROUP BY CATEGORY1


---Soru 5: Kozmetikte þampuan kategorsinde en düþük fiyat hangi  markanýn?
SELECT DISTINCT BRAND, MIN(IT.UNITPRICE) AS EN_DUSUK_FIYAT
FROM ORDERDETAILS O
INNER JOIN [ITEMS] IT ON O.ITEMID = IT.ID
WHERE CATEGORY1 = 'KOZMETIK' AND CATEGORY3 LIKE '%SAMPU%'
GROUP BY BRAND
ORDER BY EN_DUSUK_FIYAT 
---join kullanmadan yaptýðýmda minimum bir 0 deðeri görüyorum, 
--- sipariþ tablosu ile joinlersem 0 liraya sipraiþ edilmiþ bir þey olamayacaðý için bu sorun ortadan kalkar.


---Soru 6: Hangi yaþ gruplarý daha fazla alýþveriþ yapmýþ? (adet)
SELECT U.AGE AS YAS, SUM(OD.AMOUNT) AS TOPLAM_ADET
FROM ORDERS O
INNER JOIN [USERS] U ON O.USERID = U.ID
INNER JOIN [ORDERDETAILS] OD ON O.ID = OD.ORDERID
GROUP BY U.AGE
ORDER BY 2 DESC 

---Kitlem daha çok yaþlý kesimden, peki neler satýn alýyorlar?
SELECT IT.CATEGORY1, IT.CATEGORY2,IT.CATEGORY3, SUM(OD.AMOUNT) AS TOPLAM_ADET
FROM ORDERS O
INNER JOIN [USERS] U ON O.USERID = U.ID
INNER JOIN [ORDERDETAILS] OD ON O.ID = OD.ORDERID
INNER JOIN ITEMS IT ON IT.ID = OD.ITEMID
WHERE AGE=74
GROUP BY CATEGORY1, CATEGORY2, CATEGORY3
ORDER BY 4 DESC 


---kategori4'e de baktýktan sonra kýrtasiye gereçleri bulduk
---daha detaylý bilgi için
SELECT ITEMNAME, SUM(OD.AMOUNT) AS TOPLAM_ADET
FROM ORDERS O
INNER JOIN [USERS] U ON O.USERID = U.ID
INNER JOIN [ORDERDETAILS] OD ON O.ID = OD.ORDERID
INNER JOIN ITEMS IT ON IT.ID = OD.ITEMID
WHERE AGE=74 AND CATEGORY4='KIRTASIYE GERECLERI'
GROUP BY ITEMNAME
ORDER BY 2 DESC

---Soru 7: Kadýnlar daha çok hangi kategoride alýþveriþ yapmýþ?

SELECT CATEGORY1, CATEGORY2,CATEGORY3,CATEGORY4, SUM(OD.AMOUNT) AS TOTAL 
FROM ORDERS O
INNER JOIN [USERS] U ON O.USERID = U.ID
INNER JOIN [ORDERDETAILS] OD ON O.ID = OD.ORDERID
INNER JOIN ITEMS IT ON IT.ID = OD.ITEMID
WHERE GENDER = 'K'
GROUP BY CATEGORY1, CATEGORY2,CATEGORY3,CATEGORY4
ORDER BY TOTAL DESC

---Soru 8: 18-35 yaþ grubu neler almýþ?
SELECT CATEGORY1, CATEGORY2,CATEGORY3,CATEGORY4, SUM(LINETOTAL) AS TOPLAM
FROM ORDERS O
INNER JOIN [USERS] U ON O.USERID = U.ID
INNER JOIN [ORDERDETAILS] OD ON O.ID = OD.ORDERID
INNER JOIN ITEMS IT ON IT.ID = OD.ITEMID
WHERE AGE BETWEEN 18 AND 35 AND CATEGORY1 = 'GIDA'
GROUP BY CATEGORY1, CATEGORY2,CATEGORY3,CATEGORY4
ORDER BY TOPLAM DESC
