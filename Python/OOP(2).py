#Inheritance#
class Animal:
    def __init__(self, name: str) -> None:
        self.name = name

    def drink(self) -> None:
        print(f'{self.name} is drinking.')

    def eat(self) -> None:
        print(f'{self.name} is eating.')


class Dog(Animal):
    def __init__(self, name: str) -> None:
        super().__init__(name)

    def bark(self) -> None:
        print(f'{self.name}: woof woof!')

    def routine(self) -> None:
        self.eat()
        self.bark()  # Fixed method name
        self.drink()

class Cat(Animal):
    def __init__(self, name: str) -> None:
        super().__init__(name)

    def meow(self) -> None:
        print(f'{self.name}: meow!')


def main() -> None:
    dog = Animal('Buddy')
    dog.drink()
    dog.eat()

if __name__ == '__main__':
    main()

#Super - super()
class Shape:
    def __init__(self, name: str, sides: int) -> None:
        self.name = name
        self.sides = sides

    def describe(self) -> None:
        print(f'{self.name} ({self.sides} sides)')  # Added missing parenthesis

    def shape_method(self) -> None:
        print(f'{self.name}: shape_method()')

class Square(Shape):
    def __init__(self, size: float) -> None:
        super().__init__('Square', 4)
        self.size = size

    def describe(self) -> None:
        print(f'I am a {self.name} with size of {self.size} units')

class Rectangle(Shape):
    def __init__(self, length: float, height: float) -> None:
        super().__init__('Rectangle', 4)
        self.length = length
        self.height = height

    def describe(self) -> None:
        print(f'{self.name} (height: {self.height}, length: {self.length})')

def main() -> None:
    square = Square(5.0)
    square.describe()
    square.shape_method()
    rect = Rectangle(5.0, 3.0)
    rect.describe()
    rect.shape_method()

if __name__ == '__main__':
    main()

#Static Method - @staticmethod

class Calculator:
    def __init__(self, version: int)-> None:
        self.version =version

    @staticmethod
    def add(*numbers: float) -> float:
        return sum(numbers)
    def get_version(self)-> int:
        return self.version

def main() -> None:
    calc: Calculator = Calculator(version=1)

    result: float = Calculator.add(1,2,3,4)
    print(result)

if __name__ =='__main__':
    main()

#CLASS METHOD - @classmethod

from typing import Self

class Car:
    LIMITER: int = 200

    def __init__(self, brand: str, max_speed: int) -> None:
        self.brand =brand
        self.max_speed = max_speed

    @classmethod
    def change_limit(cls, new_limit: int) -> None:
        cls.LIMITER = new_limit

    @classmethod
    def autogenerate_max_speed(cls, brand: str)-> Self:
        lowered: str = brand.lower()
        max_speed: int = 200

        if lowered =='toyota':
            max_speed =270
        elif lowered =='bmw':
            max_speed =290
        elif lowered =='volvo':
            max_speed =300

        return cls(brand, max_speed)

    def display_info(self)->None:
        print(f'{self.brand} (max={self.max_speed}, limiter={self.LIMITER})')

def main() -> None:
    # bmw: Car = Car('BMW', 240)
    # toyota: Car = Car('Toyota', 190)
    #
    # bmw.display_info()
    # toyota.display_info()
    #
    # Car.change_limit(150)
    # bmw.display_info()
    # toyota.display_info()

    volvo: Car =Car.autogenerate_max_speed('Volvo')
    volvo.display_info()

if __name__ =='__main__':
    main()

#Abrstract Methods - @abstractmethod
from abc import ABC, abstractmethod

class Appliance(ABC):
    def __init__(self, brand: str, version_no: int) -> None:
        self.brand = brand
        self.version_no = version_no
        self.is_turned_on: bool = False

    @abstractmethod
    def turn_on(self) -> None:
        ...

    @abstractmethod
    def turn_off(self) -> None:
        ...


class Lamp(Appliance):
    def __init__(self, brand: str, version_no: int) -> None:
        super().__init__(brand, version_no)

    def turn_on(self) -> None:
        if self.is_turned_on:
            print(f'{self.brand} is already turned on!')
        else:
            self.is_turned_on = True
            print(f'{self.brand} turned on.')

    def turn_off(self) -> None:
        if not self.is_turned_on:
            print(f'{self.brand} is already turned off!')
        else:
            self.is_turned_on = False
            print(f'{self.brand} turned off.')

def main() -> None:
    lamp: Lamp = Lamp('Z-Lite', 1)

    lamp.turn_on()
    lamp.turn_on()
    lamp.turn_off()
    lamp.turn_off()
    lamp.turn_on()
    lamp.turn_off()

if __name__ == '__main__':
    main()

#Name Mangling
class Car:
    __YEAR: int = 2000

    def __init__(self, brand: str, fuel_type: str) -> None:
        self.__brand = brand
        self.__fuel_type = fuel_type
        self.var: str = 'red'

    def drive(self) -> None:
        print(f'Driving: {self.__brand}')

    def __get_description(self) -> None:
        print(f'{self.__brand}: {self.__fuel_type}')

    def display_colour(self) -> None:
        print(f'{self.__brand} is "{self.var.capitalize()}"')
def main() -> None:
    car: Car = Car('Toyota', 'Electric')
    car.drive()

    print(car._Car__brand)  # Accessing mangled attribute (private)
    car._Car__get_description()  # Calling mangled method (private)

if __name__ == "__main__":
    main()