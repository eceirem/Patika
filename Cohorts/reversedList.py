# Verilen listenin içindeki elemanları tersine döndüren bir fonksiyon yazın. 
# Eğer listenin içindeki elemanlar da liste içeriyorsa onların elemanlarını da tersine döndürün. 
#input: [[1, 2], [3, 4], [5, 6, 7]]
#output: [[[7, 6, 5], [4, 3], [2, 1]]

def isList(obj):
    return isinstance(obj, list)

def reverse(lst):
    result = []
    for item in lst:
        if isList(item):
            result.append(reverse(item)) # Eğer eleman bir liste ise, recursive olarak çağır.
            # burada iç listeyi tersine çevirmek için reverse(item) kullanıyoruz.
        else:
            result.append(item) # Eğer eleman bir liste değilse, elemanı sonuca ekle
    return result[::-1]  # Listeyi tersine çevir ve döndür

lst = [[1, 2], [3, 4], [5, 6, 7],10] 
print(reverse(lst)) 