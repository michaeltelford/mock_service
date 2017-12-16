# Mock Service

Mock API responses using rack. Helpful for development and debugging.

## Prerequisites

- `docker`
- `ruby` (if running locally)

## Mocking Responses

Since this app is just a plain `rack` application, the [rack interface](https://rack.github.io) is your guide to using it; In a nutshell a rack app must return an array of status, headers and body which can be something as simple as `[200, {}, ['Hello world.']]`. That's it.

Edit the `config.ru` file and add a handler which will return the response you give it. Then map an endpoint to the created handler. Clients can then query the endpoint and receive the mock response.

### JSON Responses

The gem [`rack-jsonparser`](https://github.com/michaeltelford/rack_jsonparser) provides the JSON parsing middleware.

The helper method `respond(status, headers: {}, body: [])` can be used to send responses, saving some boiler plate.

A response body consisting of a ruby `Hash` instance will automatically be converted into a JSON string before being sent to the client as long as the response `Content-Type` is correctly set to `application/json`.

Equally a string of JSON can be provided. It's up to you to ensure this JSON is valid however.

You can load a JSON file into a string to be returned using the helper method `file(path)`, again saving some boiler plate.

## Usage

Run `rake` to see the available commands for running the mock server.
