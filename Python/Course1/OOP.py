from zipapp import create_archive


class Car:
    def __init__(self, brand: str, wheels: int) -> None:
        self.brand = brand
        self.wheels = wheels

    def turn_on(self) -> None:
        print(f'Turning on: {self.brand}')

    def turn_off(self) -> None:
        print(f'Turning off: {self.brand}')

    def drive(self, km: float) -> None:
        print(f'Driving: {self.brand} for {km}km')

    def describe(self) -> None:
        print(f'{self.brand} is a car with {self.wheels} wheels')

def main() -> None:
        bmw : Car = Car("BMW",4)
        bmw.turn_on()
        bmw.drive(10)
        bmw.turn_off()
        bmw.describe()

if __name__ == '__main__':

        main()

###_init_()###
class Connection:
    def __init__(self, connection_type: str, cost: float) -> None:
        print(f'{connection_type} connection established! (Cost: ${cost}/h)')
        self.connection_type = connection_type
        self.cost = cost

    def close_connection(self) -> None:
        print(f'Closing {self.connection_type} connection...')

def main() -> None:
        internet: Connection = Connection('Internet', 2)
        satellite: Connection = Connection('Satellite', 20)

if __name__ == '__main__':
    main()

####SELF##
class Fruit:
    def __init__(self, name: str, grams: float) -> None:
        self.name = name
        self.grams = grams

    def eat(self) -> None:
        print(f'Eating {self.grams}g of {self.name}.')

def main() -> None:
    apple: Fruit = Fruit('Apple', 25)
    print(apple.name)
    apple.eat()

    banana: Fruit = Fruit('Banana', 10)
    print(banana.name)
    banana.eat()

if __name__ == '__main__':
    main()

###Attributes
class Animal:

    def __init__(self, name: str):
        self.name = name
        self.tricks: list[str] = []

    def teach_trick(self, trick_name: str):
        self.tricks.append(trick_name)

def main() -> None:
    cat: Animal = Animal('Helios')
    dog: Animal = Animal('Boomer')

    cat.teach_trick('Wash dishes')
    cat.teach_trick('Get a Job')
    print(cat.tricks)

    dog.teach_trick('Do finances')
    dog.teach_trick('Invest in socks')
    print(dog.tricks)

if __name__ == 'main':
    main()

#Dunder Methods
from typing import Self

class Book:
    def __init__(self, title: str, pages: int) -> None:
        self.title = title
        self.pages = pages

    def __len__(self) -> int:
        return self.pages

    def __add__(self, other: Self) -> Self:
        combined_title: str = f'{self.title} & {other.title}'
        combined_pages: int = self.pages + other.pages
        return Book(combined_title, combined_pages)

def main() -> None:
    py_daily: Book = Book('PyDaily', 100)
    harry_potter: Book = Book('Harry Potter', 340)

    print(len(py_daily))
    print(len(harry_potter))

    combined_books: Book = py_daily + harry_potter
    print(combined_books.title)
    print(combined_books.pages)

if __name__ == '__main__':
    main()

### __str__() & __repr__() ###
class Person:
    def __init__(self, name: str, age: int) -> None:
        self.name = name
        self.age = age

    def __str__(self) -> str:
        return f'{self.name}, {self.age} years old'

    def __repr__(self) -> str:
        return f'Person(name={self.name!r}, age={self.age!r})'

def main() -> None:
    manio: Person = Person('Manio', 27)
    print(manio)          # Using __str__
    print(repr(manio))    # Using __repr__

if __name__ == '__main__':
    main()

#__eq__()###
from typing import Self

class Car:
    def __init__(self, brand: str, car_id: int, colour:str) -> None:
        self.brand = brand
        self.car_id=car_id
        self.colour = colour

    def __eq__(self, other:Self)->bool:
        print('Current:',self.__dict__)
        print('Other',other.__dict__)
        return  self.__dict__ == other.__dict__

def main() -> None:
    car1:Car = ('BMW',1,'red')
    car2:Car = ('BMW', 1, 'red')

    print(car1 == car2)

if __name__ == '__main__':
    main()