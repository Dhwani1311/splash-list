import 'package:flutter/material.dart';

class DetailsPage extends StatefulWidget {
  String title, urlToImage;

  DetailsPage(
      {this.title, this.urlToImage});

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
          children: <Widget>[
            Image.network(
              widget.urlToImage,
              fit: BoxFit.cover,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.5,
            ),
            Padding(
              padding: EdgeInsets.only(top: 350),
              child: Container(
                //height: MediaQuery.of(context).size.height,
                //width: MediaQuery.of(context).size.width,
                child: Material(
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(20),
                        child: Text(
                          widget.title,
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
    );
  }
}