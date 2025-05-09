# MEMOIZATION
import time
from functools import cache


@cache
def count_vowels(text: str) -> int:
    print('Counting...')
    time.sleep(3)
    return sum(text.count(vowel) for vowel in 'AEIOUaeiou')


def main() -> None:
    while True:
        user_input: str = input('You: ').lower()

        if user_input == 'info':
            print(f'Bot says: {count_vowels.cache_info()}')

        elif user_input == 'clear':
            count_vowels.cache_clear()
            print(f'Bot says: Cache has been cleared.')

        else:
            print(f'Bot says: That text contains {count_vowels(user_input)} vowels.')


if __name__ == '__main__':
    main()

# CACHED PROPERTY (@cached_property)
import time
from functools import cached_property


class DataSet:
    def __init__(self, data: list[float]) -> None:
        self._data = data

    def show_data(self) -> None:
        print('Current data:', self._data)

    @cached_property
    def sum(self) -> float:
        print('Calculating sum...')
        time.sleep(2)
        return sum(self._data)

    @cached_property
    def mean(self) -> float:
        print('Calculating mean...')
        time.sleep(2)
        return sum(self._data) / len(self._data)


def main() -> None:
    ds: DataSet = DataSet([1.5, 2.5, 10, 7])
    ds.show_data()

    while True:
        user_input: str = input('You: ').lower()

        if user_input == 'clear sum':
            del ds.sum
            print('Sum cache cleared.')

        elif user_input == 'clear mean':
            del ds.mean
            print('Mean cache cleared.')

        elif user_input == 'sum':
            print(ds.sum)

        elif user_input == 'mean':
            print(ds.mean)

        else:
            print('Unknown command.')


if __name__ == '__main__':
    main()

# MONKEY PATCHING
import time
import logging


class Internet:
    def __init__(self, provider: str) -> None:
        self.provider = provider

    def connect(self) -> None:
        print(f'[{self.provider}] Connecting...')
        time.sleep(2)
        print(f'[{self.provider}] You are now connected.')


def test_connect(self) -> None:
    print(f'{self.provider} says: You are now connected.')


if __name__ == '__main__':
    internet: Internet = Internet('Verizon')
    internet.connect()

    Internet.connect = test_connect
    print('\n[Monkey Patching Active]\n')
    internet.connect()


    def new_print(text: str) -> None:
        logging.warning(text)


    print = new_print
    print('Hello World')

    print('Hi Bob')

# TIMING CODE
import timeit

a: str = 'list(range(1000))'
b: str = 'set(range(1000))'

timeit.timeit(stmt=a, number=1000)
timeit.timeit(stmt=b, number=1000)

a_time = timeit.timeit(stmt=a, number=100_000)
b_time = timeit.timeit(stmt=b, number=100_000)

print(f'a: {a_time:.6f} s')

print(f'b: {b_time:.6f} s')

repeat_count = 5
number = 100_000

list_times = min(timeit.repeat(stmt=a, repeat=repeat_count, number=number))
set_times = min(timeit.repeat(stmt=b, repeat=repeat_count, number=number))

print(f'List creation (repeated): {list_times:.6f} s')

print(f'Set creation (repeated): {set_times:.6f} s')

setup_code = 'a, b = 10, 3'
power_time = timeit.timeit(stmt='a ** b', setup=setup_code, number=1_000_000)

print(f'Power (a ** b): {power_time:.6f} s')

setup_code_math = 'from math import pow; a, b = 10, 3'
pow_time = timeit.timeit(stmt='pow(a, b)', setup=setup_code_math, number=1_000_000)

print(f'Power (math.pow): {pow_time:.6f} s')