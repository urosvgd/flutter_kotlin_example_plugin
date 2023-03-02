# Platform channel in Flutter between Dart and Native Code
Flutter allows us to call platform-specific APIs available in Java or Kotlin code on Android and in Objective C or Swift code on iOS.

Flutter’s platform-specific API works with message passing.

From Flutter app, we have to send messages to a host on iOS or Android parts of the app over a platform channel. The host listens on the platform channel and receives the message. It then uses any platform-specific APIs using the native programming language and sends back a response to the Flutter portion of the app.


## Architecture overview

![Diagram](/assets/diagram.webp 'Architecture diagram')

## Data types supported by Platform Channel
The standard platform channel uses standard message codec that supports efficient binary serialization of simple JSON-like values of types boolean, number, String, byte buffer, list, and map. The serialization and deserialization of these values to and from messages happen automatically when we send and receive values.

![Diagram](/assets/datatypes.webp 'Architecture diagram')
