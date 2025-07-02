# Variables
print("Hello" + " James!")
name = "James"
print("Hello " + name)

# Constants (can be reassigned in Python)
PI = 3.1415
print(PI)
PI = 4
print(PI)

# Data Types
# Numeric
number = -100  # int
percent = 1.50  # float
imaginary = 9j  # complex

# Boolean
hasMoney = True
noMoney = False

# String
text = "Hello bob"

# Sequence
numbers = [1, 2, 3]  # list (mutable)
coordinates = (2.5, 1.0)  # tuple (immutable)

# Mapping
users = {'Mario': 1, 'Luigi': 2}  # dict

# Set
raffle = {1, 2, 10, 25}  # set (mutable)
frozen = frozenset({1, 2, 3})  # frozenset (immutable)

# Type Checking
number = 10
print(number)
print(type(number))

number = "10"
print(number)
print(type(number))

# Type Hints (for clarity, not enforced)
number: int = 10
print(number)

number: str = 10
print(number)

# Integers
age: int = 30
a: int = 5
b: int = 10
print(a + b)  # Addition
print(a - b)  # Subtraction

# Floats
PI: float = 3.1415
a: float = 0.5
b: float = 2.5
print(a + b)  # Addition

# Operators (Arithmetic)
a: int = 2
b: int = 4
print(a + b)  # Add
print(a - b)  # Subtract
print(a * b)  # Multiply
print(a / b)  # Divide
print(a // b)  # Floor division
print(a ** b)  # Exponent
print(3 % 2)  # Modulus (remainder)

# Assignment Operators
x: int = 2
x = x + 2
print(x)
x += 2  # Shorthand for x = x + 2
print(x)  # Also supports -=, *=, /=, //=, **=, %=

# Comparison Operators
a: int = 1
b: int = 5
c: int = 10
d: int = 10
print(a == b)  # Equal
print(a != b)  # Not equal
print(c == d)  # Equal
print(a > b)  # Greater than
print(a < b)  # Less than
print(a >= b)  # Greater or equal
print(b <= a)  # Less or equal
print(c >= d)  # Greater or equal
print(c <= d)  # Less or equal

# Logical Operators
print(c == d and b > a)  # True if both true
print(c == d or a > b)  # True if at least one true
print(not(a > b))  # Negates result
print(a != b)  # Similar to not

# Strings
name: str = 'Mario'
fruit: str = "Banana"
name: str = "James \"Smith\""  # Escape quotes

# Type Conversion
txt_value: str = "100"
int_value: int = 50
print(int(txt_value) + int_value)  # Cast string to int

# Simple Adder Project
print("Welcome to your Simple Adder")
print("---------------------------")
a: str = input("Enter a value for a: ")
b: str = input("Enter a value for b: ")
print("---------------------------")
print("The result is: ", int(a) + int(b))

# Boolean
is_connected = True
has_money = False

# Lists
myList: list = [1, True, 'text', [1, 2, 3]]
people: list[str] = ['Bob', 'James', 'Tom']
print(people[0])  # Access first element
print('Original', people)
people.append('Jeremy')  # Add element
print(people)
people.remove('Bob')  # Remove element
print(people)
people.pop()  # Remove last element
print(people)
people[0] = 'Charlotte'  # Update element
print(people)
people.insert(1, 'Timothy')  # Insert at index
print(people)
people.clear()  # Clear list
print(people)

# Tuples (immutable)
items: tuple = (1, True, 'text')
coordinates: tuple[float, float] = 1.5, 2.5

# Sets (unordered, unique)
elements: set = {99, True, 'Bob'}
print(elements)
elements.add('James')  # Add
elements.remove('Bob')  # Remove
elements.pop()  # Remove random
elements.clear()  # Clear
empty: set = set()  # Empty set

# Frozensets (immutable)
things: frozenset = frozenset({1, 1, 2, 3})
print(things)

# Dictionaries
users: dict = {'Bob': 1, 'James': 2}
empty: dict = {}
weather: dict = {'time': '12:00', 'weather': {'morning': 'rain', 'evening': 'more rain'}}
print(weather['time'])  # Access value