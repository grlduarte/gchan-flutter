# gchan flutter mobile app

This is the repository for the offi

## Development environment

You can run the server and database locally using docker.

        docker-compose -f .docker/docker-compose.yml up -d

This will clone the [gchan-backend](https://github.com/gchan-board/gchan-backend) repository into a node.js container, and start a separate postgresql container with dummy data for testing.

You can then access the API via <http://localhost:4450>, and the documentation at <http://localhost:4450/api-docs>.

Please check the .docker directory for more information.

## Running Flutter

Before you run the app for the first time it's important to set the infos on
how to connect to the API server. Copy the example file using 

```sh
cp lib/server_config.example.dart lib/server_config.dart
```

then edit the constants in the newly created file to mimic your setup.

To start Flutter in debug mode be sure to have an Android or iOS device
available and then simply run:

```sh
flutter run
```

## Update auto generated files

This app uses auto generated code to handle json serialization. If you happen
to modify any model file, run: 

```sh
flutter pub run build_runner build
```

For more on this, see
[json_serializable](https://pub.dev/packages/json_serializable).
