class Node:
    def __init__(self, value):
        self.value = value
        self.left = None
        self.right = None

def insert(root, value):
    if root is None:
        return Node(value)
    
    if value < root.value:
        root.left = insert(root.left, value)
    else:
        root.right = insert(root.right, value)
    
    return root

def print_tree(node, level=0, prefix="Root: "): #inital değer root
    if node is not None:
        print(" " * (level * 4) + prefix + f"{node.value} (level {level})") #burada level manuel arttırıldı
        print_tree(node.left, level + 1, "L--- ")
        print_tree(node.right, level + 1, "R--- ")


# Verilen dizi
values = [7, 5, 1, 8, 3, 6, 0, 9, 4, 2]

# Ağacı oluştur
root = None
for val in values:
    root = insert(root, val)

# Ağacı yazdır
print("Binary Search Tree yapısı:")
print_tree(root)
