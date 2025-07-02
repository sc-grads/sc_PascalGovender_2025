# FILE HANDLING START
from typing import TextIO

file_path: str = 'info.txt'

with open(file_path, 'w') as f:
    f.write('This is some info.\nHi Bob.')

try:
    file: TextIO = open(file_path, 'r')
    text: str = file.read()
    print(text)

    file.close()
except FileNotFoundError:
    print('Could not find the file.')
except Exception as e:
    print(f'Error: {e}')
finally:
    if not file.closed:
        file.close()
        print('File closed forcefully.')

try:
    with open(file_path, 'r') as f:
        text: str = f.read()
        print(text)
except FileNotFoundError:
    print(f'No file found at {file_path}')

# READING
with open('info.txt', 'r') as f:
    text = f.read()
    print(text)

with open('info.txt', 'r') as f:
    print(f.read())

    print(f.read())

with open('info.txt', 'r') as f:
    print(f.read(5))

    print(f.read(5))

    print(f.read())

with open('info.txt', 'r') as f:
    print(f.readline(), end='')

    print(f.readline(), end='')

with open('info.txt', 'r') as f:
    lines = f.readlines()
    print(lines)

# APPEND
file_path: str = 'info.txt'

with open(file_path, 'a') as text:
    text.write('I am some text.\n')

with open('info.txt', 'a') as f:
    f.writelines(['eggs\n', 'ham\n', 'spam\n'])

with open('test.txt', 'a') as f:
    f.write('This is a newly created file with append mode.\n')

# WRITING
with open('info.txt', 'w') as txt:
    txt.write('Hello\n')

    txt.write('Bob\n')

with open('info.txt', 'w') as txt:
    txt.write('This is a completely new text file.\n')

    txt.write('All previous data has been erased.\n')

# JSON
import json

file_path = 'data.json'

with open(file_path, 'r') as file:
    data: dict = json.load(file)
    print(data)

my_json: str = '''
{
    "name": "Alice",
    "age": 30,
    "job": null
}
'''

data: dict = json.loads(my_json)
print(data)

data: dict = {
    "name": "Bob",
    "age": 43,
    "job": None
}

with open('new_json.json', 'w') as file:
    json.dump(data, file)

print('\nData written to new_json.json')

json_format: str = json.dumps(data)
print('\nJSON String Format:', json_format)
