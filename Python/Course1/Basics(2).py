#Comparing Floats
from math import isclose

a: float = 0.999
b: float = 1.000

#absolute difference - it is different by
print(f'{a} == {b}:', isclose(a, b, abs_tol=0.002))

a: float = 99.5
b: float = 100

#relative difference - if atleast it isn't different by
print(f'{a} == {b}:', isclose(a, b, rel_tol=.01))

#Scopes
number = 999

def change_num() -> None:
    number =10
    print(number)

change_num()
print(number)

#Global Variables
globalVar = 10

def change_number() -> None:
    global globalVar
    globalVar =12
