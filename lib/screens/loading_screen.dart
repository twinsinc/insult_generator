import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:insult_generator/screens/insult_screen.dart';
import 'package:insult_generator/services/insult_model.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  void getInsultData() async {
    var insultData = await InsultModel().getEvilInsult('en');
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return InsultScreen(
        insultData: insultData,
      );
    }));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getInsultData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: SpinKitPumpingHeart(
        color: Colors.red[200],
        size: 100.0,
      )),
    );
    ;
  }
}
