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