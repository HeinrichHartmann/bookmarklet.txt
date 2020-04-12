# -*- python -*-

import asyncio
from aiohttp import web
from pathlib import Path
import datetime
app = web.Application()

async def handle_bookmark(request):
    data = await request.json()
    date = datetime.date.today().isoformat()
    line = "{date} {url} - {title}\n".format(date = date, **data)
    # print(line)
    with open(Path("~/bookmarks.txt").expanduser(), "a") as fh:
        fh.write(line)

app.router.add_post("/bookmark", handle_bookmark)

if __name__ == "__main__":
    web.run_app(app)
