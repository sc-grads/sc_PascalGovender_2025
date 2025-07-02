import sys

def welcome_message() -> None:
    print('Welcome to Groceries!')
    print('Enter: ')
    print('----------------------')
    print('1 - To add an item')
    print('2 - To remove an item')
    print('3 - To list all items')
    print('0 - To exit the program')
    print('----------------------')

def add_item(item: str, groceries: list[str]) -> None:
    groceries.append(item)
    print(f'"{item}" has been added!')

def remove_item(item: str, groceries: list[str]) -> None:
   try:
        groceries.remove(item)
        print(f'"{item}" has been removed!')
   except ValueError:
        print(f'NO "{item}" found in {groceries}')

def display_groceries(groceries: list[str]) -> None:
    print("___LIST___")
    for i,item in enumerate(groceries,1):
        print(f'{i}. {item.capitalize()}')
    print('_'*10)

def is_an_option(text: str) -> bool:
    return text in ['1', '2', '3', '0']

def main() -> None:
    groceries : list[str] = []
    welcome_message()
    while True:
        user_input = input('Choose: ').lower()
        if not is_an_option(user_input):
            print('Invalid input. Try again.')
            continue

        if user_input == '1':
            new_item: str  = input('What item would you like to add?  >>: ').lower()
            add_item(new_item, groceries)
        if user_input == '2':
            delete_item: str = input('What item would you like to remove?  >>: ').lower()
            remove_item(delete_item, groceries)
        if user_input == '3':
            display_groceries(groceries)
        if user_input == '0':
            print("Exiting program...")
            sys.exit()

if __name__ == '__main__':
    main()
