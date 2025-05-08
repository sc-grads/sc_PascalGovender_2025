import sys

#Try - Except
try:
    result = 10/0

    print(result)
except Exception as e:
    print(e)

while True:
    try:
        user_input: str = input('Enter a number: ')
        print(f'10 / {user_input} = {10 / float(user_input)}')
    except ZeroDivisionError:
        print('You cannot divide by 0')
    except ValueError:
        print('Please enter a valid number...')
    except Exception as e:
        print(f'Something went wrong : {e}')

    #else-finally
    else:
        print("Success!")
    finally:
        print("Finally: I am always excuted")


total: float = 0
while True:
    user_input: str = input('Enter a number: ')

    if user_input == '0':
        print(f'Total: {total}')
        sys.exit()

    try:
        total += float(user_input)
    except ValueError:
        print('Please enter a valid number...')

#Raise
def check_age(age: int) -> bool:
    if age < 0:
        raise ValueError('Not a valid age...')
    elif age >= 21:
        print('You are old enough!')
        return True
    else:
        print('You are not old enough...')
        return False

#Unknown errors
while True:
    user_input: str = input("Enter a number: ")
    try:
            number: float = float(user_input)
            print(f'You entered: {number}')
    except ValueError:
            print(f'The value you entered ("{user_input}") is invalid.')
    except Exception as e:
            print('Program encountered a new exception!')
            print(f'Type: {type(e)}')
            print(f'Error: {e}')
