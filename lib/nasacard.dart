import 'package:Nasa_api/api/apod.dart';
import 'package:Nasa_api/detailedpage.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_ink_well/image_ink_well.dart';

class NasaCard extends StatelessWidget {
  final Apod apod;

  const NasaCard({Key key, this.apod}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final no =
        "https://i.pinimg.com/originals/f4/fb/96/f4fb96c7bd35ae0554e0154c1b99e8d2.jpg";
    return Container(
      color: Colors.black,
      margin: EdgeInsets.all(16),
      child: Column(
        children: [
          Stack(
            children: [
              Card(
                child: Container(
                  width: 00,
                  height: 300,
                  child: CircularProgressIndicator(
                    strokeWidth: 10,
                    valueColor: AlwaysStoppedAnimation(
                      Colors.white,
                    ),
                  ),
                ),
              ),
              Hero(
                tag: apod.date,
                child: RoundedRectangleImageInkWell(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailedPage(apod: apod),
                      ),
                    );
                  },
                  borderRadius: BorderRadius.circular(12.0),
                  height: 300,
                  width: 400,
                  fit: BoxFit.cover,
                  backgroundColor: Colors.transparent,
                  image: CachedNetworkImageProvider(
                      apod.url.contains(".jpg?") || apod.url.contains(" ")
                          ? no
                          : apod.url),
                ),
              ),
            ],
          ),
          Text(
            apod.url == null ? null : apod.title,
            style: TextStyle(color: Colors.white),
          ),
          Text(
            apod.date == null ? null : apod.date,
            style: TextStyle(color: Colors.white),
          )
        ],
      ),
    );
  }
}
