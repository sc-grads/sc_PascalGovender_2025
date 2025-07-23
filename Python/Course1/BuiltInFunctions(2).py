# CALLABLE (callable())
fruit: str = 'apple'
number: int = 10

def func() -> None:
    print('func() was called!')

print(f'callable(): {callable(fruit)}')

print(f'callable(): {callable(number)}')

print(f'callable(): {callable(func)}')

print(f'callable(): {callable(range)}')

print(f'callable(): {callable(str)}')

if callable(func):
    func()
else:
    print('The object is not callable.')


# FILTER (filter())
numbers: list[int] = list(range(1, 21))
print(numbers)

def is_even(number: int) -> bool:
    return number % 2 == 0

even_numbers: filter = filter(is_even, numbers)
print(list(even_numbers))

even_numbers: filter = filter(lambda n: n % 2 == 0, numbers)
print(list(even_numbers))

people: list[str] = ['Anna', 'Bob', 'Betty', 'James', 'John']
long_names: filter = filter(lambda name: len(name) > 4, people)
print(list(long_names))

ln: list[str] = [name for name in people if len(name) > 4]
print(ln)


# MAP (map())
numbers: list[int] = [1, 2, 3, 4, 5]

def double(number: int) -> int:
    return number * 2

doubled: map = map(double, numbers)
print(list(doubled))

doubled: map = map(lambda n: n * 2, numbers)
print(list(doubled))

doubled: list[int] = [double(n) for n in numbers]
print(doubled)

numbers: list[int] = [1, 2, 3, 4, 5]
letters: list[str] = ['A', 'B', 'C']

def combine_elements(numbers: int, letters: str) -> tuple[int, str]:
    return numbers, letters

combined: map = map(combine_elements, numbers, letters)
print(list(combined))

combined: map = map(lambda numbers, letters: (numbers, letters), numbers, letters)
print(list(combined))


# SORTED (sorted())
numbers: list[int] = [1, 10, 5, 3]
sorted_numbers: list[int] = sorted(numbers)
print(sorted_numbers)

people: list[str] = ['Anna', 'Mario', 'James', 'Tom']
sorted_names: list[str] = sorted(people)
print(sorted_names)

sorted_names_reverse: list[str] = sorted(people, reverse=True)
print(sorted_names_reverse)

sorted_by_length: list[str] = sorted(people, key=lambda x: len(x))
print(sorted_by_length)

class Animal:
    def __init__(self, name: str, weight: int):
        self.name = name
        self.weight = weight

    def __repr__(self):
        return f'{self.name} ({self.weight}kg)'

cat = Animal('Cat', 10)
dog = Animal('Dog', 5)
kangaroo = Animal('Kangaroo', 30)

animals = [cat, dog, kangaroo]
sorted_animals = sorted(animals, key=lambda animal: animal.weight)
print(sorted_animals)


# EVAL (eval())
result: int = eval('1 + 10 + 100')
print(result)

x: int = 5
y: int = 10
result_vars: int = eval('x + y')
print(result_vars)


# EXEC (exec())
code = '''
x = 5
y = 10
z = x + y
print('Hello World!')
for i in range(3):
    print(i)
'''
exec(code)


# ZIP (zip())
numbers: list[int] = [1, 2, 3, 4]
letters: list[str] = ['A', 'B', 'C', 'D']
symbols: list[str] = ['!', '@', '#']

zipped: zip = zip(numbers, letters)
print(list(zipped))

for n, l in zip(numbers, letters):
    print(n, l, sep=': ')

zipped_symbols = zip(numbers, symbols)
print(list(zipped_symbols))

zipped_all: zip = zip(numbers, symbols, letters)
print(list(zipped_all))
