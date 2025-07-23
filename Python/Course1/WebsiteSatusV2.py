from datetime import datetime
import asyncio
import requests


async def check_status(url: str) -> dict[str, int | str]:
    start_time = datetime.now()

    response = await asyncio.to_thread(requests.get, url, None)

    end_time = datetime.now()

    return {
        'website': url,
        'status': response.status_code,
        'start_time': start_time.strftime('%H:%M:%S'),
        'end_time': end_time.strftime('%H:%M:%S')
    }


async def main() -> None:
    print('Fetching results: ')

    tasks = asyncio.gather(
        check_status('https://www.google.com'),
        check_status('https://www.apple.com'),
        check_status('https://www.bing.com'),
        check_status('https://www.youtube.com'),
        check_status('https:lol'),
        return_exceptions=True
    )

    results: list[dict] = await tasks

    print(results)

    for result in results:
        print(result)


if __name__ == '__main__':
    asyncio.run(main())