## Jumpapi

### Summary

This is a simple api that handle protected routes. A lot is WIP

### Installation

```bash
$ pip3 install -r requirements.txt
```
#### Development

- Launch the api
```bash
$ python3 main.py
```

- Generate Credentials

```bash
$ curl -H "Content-Type: application/json" -X POST \
 -d '{"username":"test","password":"test"}' http://localhost:5000/login
 ```

 - use credentials on protected route

 ```bash
$ export ACCESS="<TOKEN_FROM_PREVIOUS_COMMAND>"
$ curl -H "Authorization: Bearer $ACCESS" http://localhost:5000/protected
 ```


#### TODO

- [] Store users
- [] Finish automation
- [] Query db on loging.
