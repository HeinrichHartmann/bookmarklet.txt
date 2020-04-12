# Bookmarklet.txt

This repository contains two components:

1. A tiny python-based server, that takes in bookmark request via a HTTP api, and writes them to ~/bookmarks.txt

2. A bookmarklet, that you can store use in your browser to send a bookmark request for the current page to the HTTP endpoint.

In effect this will allow you to store pages in ~/bookmarks.txt from any browser, with a single click.

## Usage

Start the server:
```
make venv run
```

On OSX you can you use the following command to install the bookmarklet server as launchd service:
```
make osx-launch-agent
```

## Bookmarklet

GitHub does not allow to share Bookmarklet links directly ([source](https://github.com/github/markup/issues/79)).
So you have to do this the manual way. 

Either, create a new bookmark and paste the following text into the "Location" field:
```
javascript:(function()%7Bvar%20req%20%3D%20new%20XMLHttpRequest()%3B%20req.open(%22POST%22%2C%20%22http%3A%2F%2Flocalhost%3A8080%2Fbookmark%22%2C%20true)%3B%20req.send(JSON.stringify(%7B%20%22title%22%20%3A%20document.title%2C%20%22url%22%20%3A%20location.href%20%7D))%7D)()
```

OR, paste the following code into a bookmarklet generator (e.g. https://mrcoles.com/bookmarklet/)
```js
var req = new XMLHttpRequest();
req.open("POST", "http://localhost:8080/bookmark", true);
req.send(JSON.stringify({ "title" : document.title, "url" : location.href }))
```

Catch-1: We won't be able to read and data that is sent back to us from the server, like a HTTP
Response code, because of CORS. So it's not possible for us to give feedback about success/failure
of the bookmark operation.

Catch-2: It looks like Firefox is blocking requests from bookmarklets, if some CSP headers are set.
https://bugzilla.mozilla.org/show_bug.cgi?id=866522
