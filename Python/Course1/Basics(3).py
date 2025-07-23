# DOC STRINGS

class User:
    """Base class for creating users."""

    def __init__(self, user_id: int) -> None:
        self.user_id = user_id

    def show_id(self) -> None:
        """Prints the user ID."""
        print(self.user_id)


def user_exists(user: User, database: set[User]) -> bool:
    """
    Checks if a user is inside a database.

    :param user: The user to check for.
    :param database: The database to check inside
    :return: bool
    """
    return user in database


def main() -> None:
    bob: User = User(0)
    anna: User = User(1)

    database: set[User] = {bob, anna}

    if user_exists(bob, database):
        print("User exists in the database.")
    else:
        print("No user found.")

    print(User.__doc__)

    print(user_exists.__doc__)


if __name__ == '__main__':
    main()

# F-STRINGS (Formatted String Literals)
var: int = 10


def add(a: int, b: int) -> int:
    return a + b


print(f'{var=}')

print(f"{var}")

print(f"{add(5, 10) = }")

big_number: float = 123456789
print(f"{big_number:,}")

print(f"{big_number:_}")

fraction: float = 1234.5678
print(f"{fraction:.2f}")

print(f"{fraction:,.2f}")

percent: float = 0.5555
print(f"{percent:.2%}")

var: str = "BOB"
print(f"{var: <10}")

print(f"{var: >10}")

print(f"{var: ^10}")

print(f"{var:-<10}")

print(f"{var:*>10}")

print(f"{var:@^10}")

numbers = [1, 10, 100, 1000, 10000]
for num in numbers:
    print(f"{num:_>5}: counting!")

path: str = "\\Users\\Username\\Documents\\"
print(path)

user: str = "myusername"
print(fr"C:\Users\{user}\Documents")


# ASSERTIONS
def start_program(db: dict[int, str]) -> None:
    assert db, 'Database is empty'
    print('Database loaded', db)

    print('Program started successfully!')

def main() -> None:
    db1: dict[int, str] = {0: 'A', 1: 'B'}
    start_program(db=db1)

    db2: dict[int, str] = {} #Empty DB - assertion error
    start_program(db=db2)

    var: int = -5
    assert var > 0, f'{var} is not greater than zero'


if __name__ == '__main__':
    main()

# UNPACKING
a, b = 5, 10
print(f'a: {a}, b: {b}')

a, b, c = 5, 10, 15
print(f'a: {a}, b: {b}, c: {c}')

x, y = 'AB'
print(f'x: {x}, y: {y}')

a, *b, c = 'ABCDEF'
print(a, b, c)

*_, last = 'ABCDEF'
print(last)


def add(a: int, b: int) -> None:
    print(f'{a + b= }')


add(5, 10)

numbers: dict[str, int] = {'a': 5, 'b': 10}
add(**numbers)

numbers: list[int] = [1, 2, 3, 4, 5]
params: dict[str, str] = {'sep': ' - ', 'end': '.'}
print(*numbers, **params)

# EQUALITY(==) VS Identity(is)
a: int = 200
b: int = 200
print(a == b)

print(a is b)

a: int = 1000
b: int = int('1000')
print(a == b)

print(a is b)

print(f'{id(a)=}')

print(f'{id(b)=}')

var: int | None = None
if var is None:
    print('There is no var')
else:
    print(f'The var is {var}')


class Animal:
    pass


cat = Animal()
dog = Animal()

print(cat is dog)

print(cat is cat)

print(f'ID of cat: {id(cat)}, ID of dog: {id(dog)}')