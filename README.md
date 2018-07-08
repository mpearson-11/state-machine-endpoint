# StateMachineEndpoint

To start your Phoenix app:

  * Install dependencies with `mix deps.get`
  * Start Phoenix endpoint with `mix phoenix.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

# To Use

`iex -S mix phoenix.server`

## Creating an application mock

`POST /push-state`

with `JSON` body:

```json
{
	"app": "APP",
	"path": "/[ROUTE]",
	"method": "[HTTP METHOD]",
	"json": {
		"data": {}
	}
}
```

### Example

```json
{
	"app": "app",
	"path": "/hello-world",
	"method": "GET",
	"json": {
		"message": "Hello World"
	}
}
```

Exposes route `/api/app/hello-world`

with `JSON` return data of

```json
{
	"message": "Hello World"
}
```

## Deleting a mock application

`POST /pull-state`

with `JSON` body:

```json
{
	"app": "APP"
}
```

### Example

```json
{
	"app": "app"
}
```


