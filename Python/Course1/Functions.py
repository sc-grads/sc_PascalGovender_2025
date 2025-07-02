#Creating a Function
from datetime import datetime
import time

def show_time():
    now : datetime = datetime.now()
    print(f'Time: {now:%H:%M:%S}')

show_time()
time.sleep(5)
show_time()

#Use 'pass' in a function to skip that function when running

#Parameters & Arguments
def greet(name: str, language: str, default: str):
    if language == 'it':
        print(f'Ciao, {name}!')
    else:
        print(f'{default}, {name}!')

greet('Mario', 'it', 'Hello')

#Return Functions
def get_length(text: str) -> int:
    print(f"Getting the length of: {text}...")
    return len(text)

name:str = "Mario"
length:int = get_length(name)
print(f"Length of {name} is: {length}")

#Recursive Functions
# def func() -> None:
#     print('Recursion')
#     func()
#
# func()
######
import time
def connect_to_internet(signal: bool, delay: int):
    if delay > 5:
        signal = True

    if signal:
        print('Connected')
    else:
        print(f'Connection failed. Trying again in: {delay}s..')
        time.sleep(delay)
        connect_to_internet(signal, delay+2)

connect_to_internet(False, 0)

#*Arguments and **Keyword Args
def add(*args: int) -> int:
    print(args)
    return sum(args)

print(add(1,2,3))

##ARGS##
def greet(greeting: str, *people:str, ending: str)-> None:
    for person in people:
        print(f'{greeting},{person}{ending}')

greet('Hello','Bob','James','Maria',ending='!')

##Kwargs
def pin_position(**kwargs: int) -> None:
    print(kwargs)

pin_position(x=10, y=20)

# * and /

# Use of / , means everything before must be passed as a positional argument

def func(var_a: str, /,var_b: str ) -> None:
    print(var_a)
    print(var_b)

func('a','b')

#Use of * , everything after the * must be passed as a keyword argument

def func(var_a: str, *,var_b: str ) -> None:
    print(var_a)
    print(var_b)

func('a',var_b='b')