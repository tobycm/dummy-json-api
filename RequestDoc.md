# how to request
## Get Method

```GET /random?data=<name>[;number],...```

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
            looping:[number]
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