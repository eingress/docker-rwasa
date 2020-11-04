# docker-rwasa

This image is based on the latest [rwasa](https://2ton.com.au/rwasa/) http server.

Run the container, binding a directory to serve from to `/var/www`.

```sh
docker run -d -p 8080:80 -v /path/to/serve:/var/www eingressio/rwasa
```
