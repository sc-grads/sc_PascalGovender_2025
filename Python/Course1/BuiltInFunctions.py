# PRINT FUNCTION (print())
print('Hello, Bob')

print(1, 2, True, ['a', 'b'])

print('A', 'B', 'C', sep='-')

print('A', 'B', 'C', sep=' . ')

print('Hello', end='!!!\n')

print('Hello', end='')
print('Bob')

print('A', 'B', 'C', sep=', ', end='.')

people = ['Alice', 'Bob', 'Charlie']
print(people)

print(*people, sep=', ', end='.')

# ENUMERATE (enumerate())
elements: list[str] = ['A', 'B', 'C']
enumeration: enumerate = enumerate(elements)

for i, element in enumerate(elements, start=1):
    print(f'{i}: {element}')

# ROUND (round())
a: float = 200.3123399
b: float = 18.12132
c: float = 47.12312
result: float = a + b + c

print(result)

print(round(result, 1))

print(round(result, 0))

print(round(result, -1))

print(round(result, -2))

# RANGE (range())
my_range: range = range(1, 6)
print(my_range)

print(list(my_range))

my_range = range(1, 101)
print(list(my_range))

my_range = range(5)
print(list(my_range))

my_range = range(0, 10, 2)
print(list(my_range))

my_range = range(0, -5, -1)
print(list(my_range))

for i in range(3):
    print(i)

# SLICE (slice())
text: str = 'Hello World'
first_three: slice = slice(0, 3)
print(text[first_three])

reverse_slice: slice = slice(None, None, -1)
print(text[reverse_slice])

step_two: slice = slice(None, None, 2)
print(text[step_two])

second_text: str = 'Python Programming'
print(second_text[first_three])

print(second_text[reverse_slice])

print(second_text[step_two])

# GLOBAL (global())
from typing import Any

print(globals())

text: str = 'Bob'
my_list: list[int] = [1, 2, 3]


def function() -> None:
    pass


print(globals())

my_globals: dict[str, Any] = dict(globals())
for k, v in my_globals.items():
    print(f'{k}: {v}')

# LOCALS

def add(a: int, b: int) -> None:
    result: int = a + b
    print(f' {a} + {b} = {result}')

    print('add() has:', locals())

    print('add() can see:', globals())

add(1, 1)

# ALL (all())
wifi_enabled: bool = True
has_electricity: bool = True
has_subscription: bool = True

requirements: list[bool] = [wifi_enabled, has_electricity, has_subscription]
if all(requirements):
    print('Connected to the internet')

people_voted = [1, 1, 0, 1]
if all(people_voted):
    print('Everyone voted')
else:
    print('Some people did not vote')

# ANY (any())
people_voted = [0, 1, 0, 0, 0]

if any(people_voted):
    print('At least one person voted')
else:
    print('No one voted')

# IS INSTANCE (isinstance())
num: int = 42
pi: float = 3.14
text: str = 'Hello World'
my_list: list[int] = [1, 2, 3]

print(isinstance(num, int))

print(isinstance(num, str))

print(isinstance(num, float))

print(isinstance(pi, float))

print(isinstance(pi, int))

print(isinstance(pi, int | float))

print(isinstance(text, str))

print(isinstance(my_list, list))

print(isinstance(my_list, tuple))


class Animal:
    pass


class Cat(Animal):
    pass


print(isinstance(Cat(), Animal))
print(isinstance(Animal(), Cat))