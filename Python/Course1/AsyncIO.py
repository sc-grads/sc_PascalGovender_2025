# GETTING STARTED
import asyncio
from datetime import datetime


async def fetch_data(input_data: str) -> dict:
    print('Fetching data...')

    start_time = datetime.now()

    await asyncio.sleep(3)

    end_time = datetime.now()

    print('Data retrieved.')

    return {
        'input': input_data,
        'start_time': start_time.strftime('%H:%M:%S'),
        'end_time': end_time.strftime('%H:%M:%S')
    }


async def main():
    task1 = asyncio.create_task(fetch_data('1'))
    task2 = asyncio.create_task(fetch_data('2'))

    data1 = await task1
    data2 = await task2

    print(f'Data 1: {data1}')

    print(f'Data 2: {data2}')


if __name__ == '__main__':
    asyncio.run(main())

# TASKS
import asyncio
from datetime import datetime


async def fetch_data(input_data: str, delay: int) -> dict:
    print(f'Fetching data for {input_data}...')

    start_time = datetime.now()

    await asyncio.sleep(delay)

    end_time = datetime.now()

    print(f'Data retrieved for {input_data}.')

    return {
        'input': input_data,
        'start_time': start_time.strftime('%H:%M:%S'),
        'end_time': end_time.strftime('%H:%M:%S')
    }


async def main():
    try:
        task1 = asyncio.create_task(fetch_data('1', 3))
        task2 = asyncio.create_task(fetch_data('2', 10))

        await asyncio.sleep(1)
        print('Running other code...')

        task2.cancel(msg='Took too long...')

        try:
            data1 = await task1
            data2 = await task2
        except asyncio.CancelledError:
            print('Task 2 was cancelled.')

        print(f'Data 1: {data1}')

    except Exception as e:
        print(f'An error occurred: {e}')


if __name__ == '__main__':
    asyncio.run(main())


# GATHER
import asyncio
from datetime import datetime


async def fetch_data(input_data: str, delay: int, fail: bool = False) -> dict:
    print(f'Fetching data for {input_data}...')

    start_time = datetime.now()

    if fail:
        raise Exception(f'Task {input_data} failed.')

    await asyncio.sleep(delay)

    end_time = datetime.now()

    print(f'Data retrieved for {input_data}.')

    return {
        'input': input_data,
        'start_time': start_time.strftime('%H:%M:%S'),
        'end_time': end_time.strftime('%H:%M:%S')
    }


async def main() -> None:
    try:
        tasks = await asyncio.gather(
            fetch_data('1', 2),
            fetch_data('2', 4),
            fetch_data('3', 3, fail=True),
            fetch_data('4', 1),
            return_exceptions=True
        )

        print('\nResults:')
        for result in tasks:
            if isinstance(result, Exception):
                print(f'Error: {result}')
            else:
                print(result)

    except Exception as e:
        print(f'An unexpected error occurred in main: {e}')


if __name__ == '__main__':
    asyncio.run(main())