###### Data Class (@dataclass)
from dataclasses import dataclass


@dataclass
class Coin:
    name: str
    value: float
    id: str


def main() -> None:
    bitcoin: Coin = Coin('Bitcoin', 10000, 'BTC')
    bitcoin2: Coin = Coin('Bitcoin', 10000, 'BTC')
    ripple: Coin = Coin('Ripple', 200, 'XRP')

    print(bitcoin)

    print(ripple)

    print(bitcoin == ripple)

    print(bitcoin == bitcoin2)

    class CoinRegular:
        def __init__(self, name: str, value: float, coin_id: str) -> None:
            self.name = name
            self.value = value
            self.coin_id = coin_id


if __name__ == '__main__':
    main()

########## Fields
from dataclasses import dataclass, field
from typing import List


@dataclass
class Fruit:
    name: str
    grams: float
    price_per_kilo: float
    edible: bool = True
    related_fruits: List[str] = field(default_factory=list)


def main() -> None:
    apple: Fruit = Fruit('Apple', 100, 5)
    print(apple)

    pear = Fruit('Pear', 250, 10, related_fruits=['Apple', 'Orange'])
    print(pear)

    print(pear.related_fruits)


if __name__ == '__main__':
    main()

########### Post Init (__post_init__)
from dataclasses import dataclass, field


@dataclass
class Fruit:
    name: str
    grams: float
    price_per_kilo: float
    total_price: float = field(init=False)

    def __post_init__(self) -> None:
        self.total_price = (self.grams / 1000) * self.price_per_kilo

    def describe(self) -> None:
        print(f'{self.grams}g of {self.name} costs ${self.total_price}')


def main() -> None:
    apple: Fruit = Fruit('Apple', 1500, 5)
    orange: Fruit = Fruit('Orange', 2500, 10)

    print(apple)

    print(orange)

    apple.describe()

    orange.describe()

    apple.price_per_kilo = 100
    apple.describe()


if __name__ == '__main__':
    main()

###### INITVAR (InitVar)
from dataclasses import dataclass, field, InitVar


@dataclass
class Fruit:
    name: str
    grams: float
    price_per_kilo: float
    is_rare: InitVar[bool | None] = None
    total_price: float = field(init=False)

    def __post_init__(self, is_rare: bool | None) -> None:
        if is_rare:
            self.price_per_kilo *= 2
        self.total_price = (self.grams / 1000) * self.price_per_kilo

    def describe(self):
        print(f'{self.grams}g of {self.name} costs ${self.total_price}.')


def main() -> None:
    apple: Fruit = Fruit('Apple', 1500, 5)
    orange: Fruit = Fruit('Orange', 2500, 10)
    passion: Fruit = Fruit('Passion Fruit', 100, 50, is_rare=True)

    apple.describe()

    orange.describe()

    passion.describe()

    print(apple)

    print(orange)

    print(passion)


if __name__ == '__main__':
    main()

# Property (@property)
from dataclasses import dataclass


@dataclass
class Fruit:
    name: str
    grams: float
    price_per_kilo: float

    @property
    def total_price(self) -> float:
        return (self.grams / 1000) * self.price_per_kilo

    def describe(self):
        print(f'{self.grams}g of {self.name} costs ${self.total_price}.')


def main() -> None:
    apple: Fruit = Fruit('Apple', 1500, 5)
    print(apple)

    apple.describe()

    apple.price_per_kilo = 20
    print(apple)

    apple.describe()


if __name__ == '__main__':
    main()