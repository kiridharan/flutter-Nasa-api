import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'dart:math' as math;
import 'error.dart';
import 'package:Nasa_api/api/apod.dart';
import 'package:Nasa_api/nasacard.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<List<Apod>> apod;
  final String uri =
      "https://api.nasa.gov/planetary/apod?api_key=YOURKEY&start_date=2021-01-12&end_date=2021-01-30&hd=true";

  Future<List<Apod>> fetchData() async {
    var reponse = await http.get(uri);
    if (reponse.statusCode == 200) {
      final jsonList = jsonDecode(reponse.body);
      if (jsonList is List) {
        return jsonList.map((json) => Apod.fromJson(json)).toList();
      }
    }
    throw Exception("Http didnt work");
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    apod = fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'NasaViewer',
          style: TextStyle(
            letterSpacing: 10,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.autorenew),
            onPressed: () {
              setState(() {
                fetchData();
              });
            },
          )
        ],
      ),
      body: FutureBuilder(
        future: apod,
        builder: (BuildContext context, AsyncSnapshot<List<Apod>> snapshot) {
          if (snapshot.hasData) {
            return ListView(
              padding: EdgeInsets.all(13.0),
              children:
                  snapshot.data.map((apod) => NasaCard(apod: apod)).toList(),
            );
          } else if (snapshot.hasError) {
            return Error(error: snapshot.error);
          } else {
            return Center(
              child: CircularStepProgressIndicator(
                child: Center(
                    child: Text(
                  "Loading",
                  style: TextStyle(color: Colors.white),
                )),
                totalSteps: 20,
                currentStep: 12,
                stepSize: 20,
                selectedColor: Colors.red,
                unselectedColor: Colors.purple[400],
                padding: math.pi / 80,
                width: 150,
                height: 150,
                startingAngle: -math.pi * 2 / 3,
                arcSize: math.pi * 2 / 3 * 2,
                gradientColor: LinearGradient(
                  colors: [Colors.white, Colors.grey],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
