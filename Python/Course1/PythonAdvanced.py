# MYPY
var: str = 123

items: list[str] = ["apple", "banana", True]
#Above is for use of MyPy

# WALRUS OPERATOR (:=)
def description(numbers: list[int]) -> dict:
    details: dict = {
        'length': (n_len := len(numbers)),
        'sum': (n_sum := sum(numbers)),
        'mean': n_sum / n_len if n_len > 0 else 0
    }
    return details


def main() -> None:
    print(description([1, 10, 5, 200, -4, 7]))

    print(x := 1 > 0)


if __name__ == '__main__':
    main()

# LAMBDAS
from typing import Callable

p = lambda x: print(x)

p(10)

p("Hello")

add = lambda a, b: a + b
print(add(4, 12))


def use_all(f: Callable, values: list[int]) -> None:
    for value in values:
        f(value)


use_all(lambda value: print(f"{value * 'X'}"), [2, 4, 10])


def multiply_x(value: int) -> None:
    print(f"{value * 'X'}")


use_all(multiply_x, [2, 4, 10])

names: list[str] = ["Bob", "James", "Samantha", "Luigi", "Joe"]
sorted_names: list[str] = sorted(names, key=lambda x: len(x))
print(sorted_names)

names = ["bob", "James", "samantha", "luigi", "Joe"]
sorted_names = sorted(names, key=lambda x: len(x.lower()))
print(sorted_names)

# GENERATORS
from typing import Generator


def five_numbers() -> Generator:
    for i in range(1, 6):
        yield i


numbers: Generator = five_numbers()
print(next(numbers))

print(next(numbers))

print(next(numbers))

print(list(numbers))


def huge_data() -> Generator:
    for i in range(100_000_000_000):
        yield i


data: Generator = huge_data()

for i in range(5):
    print(next(data))


def generate_vowels() -> Generator[str, None, None]:
    vowels = 'aeiou'
    for vowel in vowels:
        yield vowel


vowels = generate_vowels()

print(next(vowels))

print(next(vowels))

print(next(vowels))

for vowel in vowels:
    print(vowel)

try:
    print(next(vowels))
except StopIteration:
    print('Generator is empty.')

# MATCH CASE
status: int = 200

match status:
    case 200:
        print("Connected")
    case 403:
        print("Forbidden")
    case 404:
        print("Not Found")
    case _:
        print("Unknown")

while True:
    user_input: str = input("Enter a command: ")
    command: list[str] = user_input.split()

    match command:
        case ["find", *images]:
            print(f"Finding images: {images}")

        case ["enlarge", image, amount]:
            print(f"You enlarged {image} by {amount}x")

        case ["rename", image, new_name] if len(new_name) > 3:
            print(f"{image} was renamed to {new_name}")

        case ["download", *images]:
            print(f"Downloading images: {images}")

        case ["delete" | "x", *images]:
            print(f"Deleting images: {images}")

        case _:
            print("Command not found.")

# DECORATORS
import time
from typing import Callable
from functools import wraps


def get_time(func: Callable) -> Callable:
    @wraps(func)
    def wrapper(*args, **kwargs) -> None:
        start_time: float = time.perf_counter()
        func(*args, **kwargs)
        end_time: float = time.perf_counter()

        print(f'Time: {end_time - start_time:.3f} s')

    return wrapper


@get_time
def calculate():
    print('Calculating...')
    for i in range(20_000_000):
        pass
    print("Done")


def main() -> None:
    calculate()


if __name__ == '__main__':
    main()

#ENUMS
from enum import Enum

class State(Enum):
    OFF = 0
    ON = 1

state: State = State.OFF

if state == State.ON:
    print('The device is turned on.')
elif state == State.OFF:
    print('The device is turned off.')
else:
    print('Unknown input...')

class Colour(Enum):
    RED: str = 'R'
    GREEN: str = 'G'
    BLUE: str = 'B'

red: Colour = Colour.RED
print(red)

print(red.value)

print(red.name)

print(Colour('R'))

def buy_car(brand: str, colour: Colour) -> None:
    if colour == Colour.RED:
        print(f'You bought a smoking hot red {brand}.')
    elif colour == Colour.GREEN:
        print(f'You bought an eco-friendly green {brand}.')
    elif colour == Colour.BLUE:
        print(f'You bought a cool blue {brand}.')
    else:
        print('Unknown color.')

def main() -> None:
    buy_car('BMW', Colour.BLUE)
    
    buy_car('Volvo', Colour.RED)
    
    buy_car('Toyota', Colour.GREEN)

if __name__ == '__main__':
    main()