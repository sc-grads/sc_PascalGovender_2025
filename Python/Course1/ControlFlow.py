
age : int = 10

if age >= 21:
    print("Adult")
elif age >= 18:
    print("Young Adult")
elif age >= 13:
    print("Teenager")
else:
    print("Child")

#IfElse shorthand
number : int = 0
result : str = "Zero" if number == 0 else "Not Zero"
print(result)

#expanded version of above shorthand code
if number==0:
    result: str = "Zero"
else:
    result: str = "Not Zero"

#For loop
people : list[str] = ["Bob","James","Maria"]

for person in people:
    if len(person) > 4:
        print(f"{person} has a long name")
    else:
        print(f"{person} has a short name")


#while loop
import time #imports a time pack for timer etc

connected : bool = True
while connected:
    print("Using internet...")
    time.sleep(5)
    connected = False
print("Connection ended...")

#Break & Continue
total : int = 0
print("Welcome to Calc+! Add positive numbers, or insert '0' to exit")
while True:
    user_input : int = int(input("Enter a number: "))

    if user_input < 0:
        print("Enter a POSITIVE number ONLY")
        continue
    if user_input == 0:
        print(f'Total: {total}')
        break
    total += user_input

#Loop...Else
for i in range(3):
    print(f'Iteration: {i}')
    break
else:
    print("success")