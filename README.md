# gchan flutter mobile app

This is the repository for the offi

## Development environment

You can run the server and database locally using docker.

        docker-compose -f .docker/docker-compose.yml up -d

This will clone the [gchan-backend](https://github.com/gchan-board/gchan-backend) repository into a node.js container, and start a separate postgresql container with dummy data for testing.

You can then access the API via <http://localhost:4450>, and the documentation at <http://localhost:4450/api-docs>.

Please check the .docker directory for more information.

## Running Flutter

To start Flutter in debug mode be sure to have an Android or iOS device
available and then simply run:

```sh
flutter run
```
