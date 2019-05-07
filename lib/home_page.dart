import 'package:flutter/material.dart';
import 'auth.dart';
import 'package:sensors/sensors.dart';
import 'dart:math' as math;

class HomePage extends StatelessWidget {
  HomePage({this.auth, this.onSignOut});
  final BaseAuth auth;
  final VoidCallback onSignOut;
  
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> {

  List<double> _accelerometerValues;
  List<double> _userAccelerometerValues;

  double _userAx;
  double _userAy;
  double _userAz;
  double _ax;
  double _ay;
  double _az;

  List<StreamSubscription<dynamic>> _streamSubscriptions = 
      <StreamSubscription<dynamic>>[];

  @override
  Widget build(BuildContext context) {
    final List<String> accelerometer = _accelerometerValues?.map((double v) => v.toStringAsFixed(1))?.toList();
    final List<String> userAccelerometer = _userAccelerometerValues ?.map((double v) => v.toStringAsFixed(1)) ?.toList();


    void _signOut() async {
      try {
        await auth.signOut();
        onSignOut();
      } catch (e) {
        print(e);
      }

    }


    return new Scaffold(
      appBar: new AppBar(
        actions: <Widget>[
          new FlatButton(
              onPressed: _signOut,
              child: new Text('Logout', style: new TextStyle(fontSize: 17.0, color: Colors.white))
          )
        ],
      ),
      body: new Center(
        child: new Text(
          'Accelerometer: $_accelerometerValues',
          style: new TextStyle(fontSize: 32.0),
        ),
      )
    );
  }

  @override
  void dispose() {
    super.dispose();
    for (StreamSubscription<dynamic> subscription in _streamSubscriptions) {
      subscription.cancel();
    }
  }

  @override
  void initState() {
    super.initState();
    _streamSubscriptions
        .add(accelerometerEvents.listen((AccelerometerEvent event) {
      setState(() {
        _accelerometerValues = <double>[event.x, event.y, event.z];
        _ax = event.x;
        _ay = event.y;
        _az = event.z;
      });
    }));
    _streamSubscriptions
        .add(userAccelerometerEvents.listen((UserAccelerometerEvent event) {
      setState(() {
        _userAccelerometerValues = <double>[event.x, event.y, event.z];
        _userAx = event.x;
        _userAy = event.y;
        _userAz = event.z;
      });
    }));
  }


}