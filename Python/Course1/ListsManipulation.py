#List Comprehensions
numbers: list[int] = [1, 2, 3]

doubled: list[int] = []
for number in numbers:
    doubled.append(number * 2)

#shortand
doubled_lc: list[int] = [number * 2 for number in numbers]
print(doubled_lc)

names: list[str] = ['Mario', 'James', 'Luigi', 'John']
j_names: list[str] = []

for name in names:
    if name.startswith('J'):
        j_names.append(name)

#shortand
j_names_lc: list[str] = [name for name in names if name.startswith('J')]
print(j_names_lc)

#SLICING
numbers = [1,2,3,4,5,6]
print(numbers[0:4])
print(numbers[-5])
print(numbers[0:4:1])