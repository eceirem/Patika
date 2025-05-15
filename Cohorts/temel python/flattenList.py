#1- Bir listeyi düzleştiren (flatten) fonksiyon yazın. 
# Elemanları birden çok katmanlı listelerden ([[3],2] gibi) oluşabileceği gibi,
# non-scalar verilerden de oluşabilir. 
#input: [[1,'a',['cat'],2],[[[3]],'dog'],4,5]
#output: [1,'a','cat',2,3,'dog',4,5]

def isList(obj):
    return isinstance(obj, list)
def flatten(lst):
    result = [] # Sonucu tutacak liste
    for item in lst: # Listeyi döngü ile gez
        if isList(item): # Eğer eleman bir liste ise
            result.extend(flatten(item)) # Elemanı düzleştir ve sonuca ekle
        else: # Eğer eleman bir liste değilse
            result.append(item) # Elemanı sonuca ekle
    return result # Sonucu döndür

lst = [[1,'a',['cat'],2],[[[3]],'dog'],4,5] # Test listesi
print(flatten(lst)) # Sonucu yazdır
