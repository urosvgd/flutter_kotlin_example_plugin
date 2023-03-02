# Platform channel in Flutter between Dart and Native Code
Flutter allows us to call platform-specific APIs available in Java or Kotlin code on Android and in Objective C or Swift code on iOS.

Flutter’s platform-specific API works with message passing.

From Flutter app, we have to send messages to a host on iOS or Android parts of the app over a platform channel. The host listens on the platform channel and receives the message. It then uses any platform-specific APIs using the native programming language and sends back a response to the Flutter portion of the app.


## Architecture overview

![Diagram](/assets/diagram.webp 'Architecture diagram')

## Data types supported by Platform Channel
The standard platform channel uses standard message codec that supports efficient binary serialization of simple JSON-like values of types boolean, number, String, byte buffer, list, and map. The serialization and deserialization of these values to and from messages happen automatically when we send and receive values.

![Diagram](/assets/datatypes.webp 'Architecture diagram')

### Whats happening?
#### 1. Create a platform Channel
The client and host sides of the channel are connected through the channel name passed in the channel constructor. All channel names used in a single app must be unique. In our example, we are creating the channel name com.flutter.epic/epic

```
class _MyHomePageState extends State<MyHomePage> {
  static const platform = MethodChannel("com.flutter.epic/epic");
```

#### 2. Invoke method on platform Channel
Invoke a method on the method channel, specifying the concrete method to call via the String identifier. In the code below, it is TurnFlashLightOn

```
void turnOnFlashLight() async {
    late var value;
    try {
        value = await platform.invokeMethod("TurnFlashLightOn");
    } catch (e) {
        print(e);
    }
}
```
#### 3. Create method implementation in Android using kotlin
In code editor of your choosing open Flutter app and select the android folder inside it. Open the file MainActivity.kt

Now we have to create a MethodChannel with the same name that we have created in Flutter App.
``` 
class MainActivity: FlutterActivity() {
    private val CHANNEL = "com.flutter.epic/epic" 
``` 

We have to create and configure MethodChannel 
```
override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
                call, result ->
            if(call.method == "Printy") {
                result.success("Hello from the Kotlin World")
            }
            if(call.method == "TurnFlashLightOn") {
                openFlashLight()
            }
        }
    }
```

#### Results
Run the code on Android. Click on the button + and it should toggle your torchlight