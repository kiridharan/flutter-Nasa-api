import 'package:Nasa_api/api/apod.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class DetailedPage extends StatelessWidget {
  final Apod apod;

  const DetailedPage({Key key, this.apod}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(apod.title),
        backgroundColor: Colors.black,
      ),
      body: ListView(
        children: [
          Stack(
            children: [
              Container(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
              Hero(
                tag: apod.date,
                child: FadeInImage.memoryNetwork(
                  placeholder: kTransparentImage,
                  image: apod.url,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(15),
            child: Row(
              children: [
                Text(
                  apod.date,
                  style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.normal,
                    fontStyle: FontStyle.italic,
                    fontSize: 12.0,
                  ),
                ),
                Container(
                  width: 300,
                  child: Text(
                    "© ${apod.copyright}",
                    softWrap: true,
                    textAlign: TextAlign.end,
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontStyle: FontStyle.italic,
                      fontSize: 12.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 16.0),
            child: Text(
              apod.explanation,
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
