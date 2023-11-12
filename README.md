# README

Demo API services written in different languages using microframeworks.

Requirements for application instances:
- Utilize a microframework to showcase dependency handling in the programming language.
- Implement a payload controller that returns the programming language, hostname, timestamp, and UUID.
- Implement a health controller that returns 'ok' and an HTTP status of 200.
- Configure the server port through the environment variable 'PORT.'

Requirements for Deployment:
- Newly created services should be easily added to the list of existing ones."

# demo

[![asciicast](https://asciinema.org/a/SnYv2zz2hM01wEZ7gQDm1d0ON.svg)](https://asciinema.org/a/SnYv2zz2hM01wEZ7gQDm1d0ON)

# test locally

See [Taskfile](Taskfile.yml)

To build containers locally use:
```shell
task dc-up
# docker compose up
```
