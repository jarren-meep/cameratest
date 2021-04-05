import 'dart:io';
import 'dart:typed_data';

import 'package:cameratest/main2.dart';
import 'package:flutter/material.dart';
import 'package:camerawesome/camerapreview.dart';
import 'package:camerawesome/camerawesome_plugin.dart';
import 'package:camerawesome/models/capture_modes.dart';
import 'package:camerawesome/models/flashmodes.dart';
import 'package:camerawesome/models/orientations.dart';
import 'package:camerawesome/models/sensors.dart';
import 'package:camerawesome/picture_controller.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image/image.dart' as image;
import 'package:path_provider/path_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _lastPhotoPath;
  ValueNotifier<CameraFlashes> _switchFlash = ValueNotifier(CameraFlashes.NONE);
  ValueNotifier<Sensors> _sensor = ValueNotifier(Sensors.BACK);
  ValueNotifier<CaptureModes> _captureMode = ValueNotifier(CaptureModes.PHOTO);
  ValueNotifier<Size> _photoSize = ValueNotifier(null);
  ValueNotifier<bool> _enableAudio = ValueNotifier(true);
  String imgName;
  int number = 1;
  List files = new List();

  Stream<Uint8List> previewStream;

  PictureController _pictureController = new PictureController();

  /*_takePhoto(String userid) async {
    final Directory extDir = await getApplicationDocumentsDirectory();
    final testDir = await Directory('${extDir.path}/images').create(recursive: true);
    String filePath = "";
    if (number < 6) {
      filePath = '${testDir.path}/$userid${DateFormat('yyyyMMddHHmmss').format(DateTime.now())}_$number.jpg';
      print(filePath);
      number++;
      await _pictureController.takePicture(filePath);
      // lets just make our phone vibrate
      HapticFeedback.mediumImpact();
      _lastPhotoPath = filePath;

      print("----------------------------------");
      print("TAKE PHOTO CALLED");
      final file = File(filePath);
      print("==> hastakePhoto : ${file.exists()} | path : $filePath");
      final img = image.decodeImage(file.readAsBytesSync());
      print("==> img.width : ${img.width} | img.height : ${img.height}");
      print("----------------------------------");
    } else {
      print("You've submitted 5 pictures already.");
    }
  }*/

  _onPermissionsResult(bool granted) {
    if (!granted) {
      print("Not Granted");
      return false;
    } else {
      print("Granted");
      return true;
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text('First Route'),
      ),
      body: Container(
        height: height,
        width: width,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //Button to swap camera side
            Expanded(
              flex: 8,
              child: Container(
                child: InkWell(
                  child: CameraAwesome(
                    testMode: false,
                    selectDefaultSize: (List<Size> availableSizes) {
                      print(availableSizes);
                      return Size(640.0, 480.0);
                    },
                    onPermissionsResult: _onPermissionsResult,
                    onCameraStarted: () {},
                    onOrientationChanged: (CameraOrientations newOrientation) {},
                    sensor: _sensor,
                    switchFlashMode: _switchFlash,
                    captureMode: _captureMode,
                    orientation: DeviceOrientation.portraitUp,
                    fitted: false,
                    enableAudio: _enableAudio,
                    photoSize: _photoSize,
                  ),
                  onTap: () async {
                    await Fluttertoast.showToast(
                      msg: '''Photo Taken''',
                      toastLength: Toast.LENGTH_LONG,
                      gravity: ToastGravity.TOP,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.green,
                      textColor: Colors.white,
                      fontSize: 16.0,
                    );
                  },
                ),
              ),
            ),
            Spacer(flex: 1),
            TextButton(
              child: Text('Login'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Main2()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
