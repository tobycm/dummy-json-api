# how to request
## Get Method

```GET /random?data=<name>[;numberOfDoc],...```

example :

```
    GET /random?data=phone_number;10,siuu
```

## Post Method

``POST /random``

```
body:
    [
        {
            name:<name>,
            looping:[number] (optional)
        }
    ]
```

example :
```
POST /random
body:
    [
        {
            "name":"phone_number",
            "looping":100
        }
    ]
```