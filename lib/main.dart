
import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app_splash_screen/Details.dart';
import 'package:http/http.dart' as http;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIOverlays(
      [SystemUiOverlay.bottom, SystemUiOverlay.top]);
  runApp(HomePage());
}

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => new HomePageState();
}

class HomePageState extends State<HomePage> {

  List data;

  Future<String> getData() async {
  var response = await http.get(('http://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=921dfa03539246f28c1f24bcc5e1ca7e'),
  headers: {
  "Accept": "application/json"
  }
  );
  var fetchdata = json.decode(response.body);
  this.setState(() {
  data = fetchdata["articles"];
  });
  print(data[0]["title"]);

  return "Success!";
  }
  @override
  void initState(){
    super.initState();
    this.getData();
  }

  @override
  Widget build(BuildContext context){
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Flutter REST API ',
    home: new Scaffold(
    appBar: new AppBar(title: new Text("Listviews"),),
    body: new ListView.builder(
      itemCount: data == null ? 0 : data.length,
      itemBuilder: (BuildContext context, int index){
      final item = data[index];
      return Dismissible(
          // Show a red background as the item is swiped away.
          background: Container(color: Colors.red),
        key: Key(item.toString()),
        onDismissed: (direction) {
        setState(() {
        data.removeAt(index);
        });
        Scaffold.of(context).showSnackBar(SnackBar(content: Text("Item Deleted")));
        },
       child: GestureDetector(
        child: new Card(
        child: Row(
          children: [
            Column(
              children: [
                Container(child: Image.network(data[index]['urlToImage'],
                        width: 100,height: 100,),),
              ],
            ),
            SizedBox(width:5,),
            Expanded(
              child: Column(
                children: [
                  Container(child: new Text(data[index]["title"],style: TextStyle(fontWeight: FontWeight.bold),)),
                ],
              ),
            ),],
        ),
        ),
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => DetailsPage(
            title: data[index]["title"],
            urlToImage: data[index]["urlToImage"],
          )));
        },
      ),
      );
      },
      ),
    ),
  );
  }
}

