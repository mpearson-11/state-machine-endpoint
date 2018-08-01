# StateMachineEndpoint

To start your Phoenix app:

  * Install dependencies with `mix deps.get`
  * Start Phoenix endpoint with `mix phoenix.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

---
## Push State Request Example [1]
| url         | method | body | response | information |
|-------------|--------|------|----------|-------------|
| /state/push | POST | `{ "app": "app1", "path": "/hello", "method": "GET", "json": { "message": "Hello World!!" }}` | `{ "message": "Application now running on url: /api/app1/hello, method: GET" }` | Creates response for `/api/app1/*` with path `/hello` when request sent using `GET` http request method.
| /state/push | POST | `{ "app": "app2", "path": "/bye", "method": "POST", "json": { "message": "Bye World!!" }}` | `{ "message": "Application now running on url: /api/app2/bye, method: POST" }` | Creates response for `/api/app2/*` with path `/bye` when request sent using `POST` http request method.

## Pull State Request Example [2]
| url         | method | body | response | information |
|-------------|--------|------|----------|-------------|
| /state/pull    | POST   | `{ "app": "app1" }` | `{ "message": "Endpoint for app: app1 was deleted !!" }` | Deletes app1 from served endpoints.
| /state/pull    | POST   | `{ "app": "app2" }` | `{ "message": "Endpoint for app: app2 was deleted !!" }` | Deletes app2 from served endpoints.
| /state/pull    | POST   | `{ "app": "app1", "hash": .... }` | `{ "message": "Endpoint for app: app1 with hash .... was deleted !!" }` | Deletes path for app1 with hash.
| /state/pull    | POST   | `{ "app": "app2", "hash": .... }` | `{ "message": "Endpoint for app: app2 with hash .... was deleted  !!" }` | Deletes path for app2 with hash.

## Reset State Request Example [3]
| url         | method | body | response |
|-------------|--------|------|----------|
| /state/reset    | POST   | `{ "message": "Cleared" }` |

## Responses from [1]
| url             | method   | response                          |
|-----------------| -------- | --------------------------------- |
| /api/app1/hello | GET      | `{ "message": "Hello World!!" }`  |
| /api/app2/bye   | POST     | `{ "message": "Bye World!!" }`    |

## Page routes

- **/**
  - View all Application endpoints with UI

- **/add**
  - Create an Application with endpoints with UI

- **/delete-app**
  - Remove an Application with namespace /:app

- **/delete-path**
  - Remove an Application's path associated with its hash
  

## Running the Application in Docker

### Build The Application image
- `docker-compose build`

### Start the Application
- `docker-compose up phoenix`
