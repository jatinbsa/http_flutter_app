import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(new HomePage());

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final String url="https://swapi.co/api/person";
  List data;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.getJsonData();
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Http Json"),
      ),
      body: new ListView.builder(
        itemCount: data==null ? 0:data.length,
        itemBuilder: (BuildContext context,int index){
          return new Container(
            child: new Center(
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  new Card(
                    child:new Container(
                      child: new Text(data[index]['name']),
                      padding: const EdgeInsets.all(20.0),
                    )
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Future<String> getJsonData() async{
         var response=await http.get(
            Uri.encodeFull(url),
           headers: {"Accept":"application/json"}
         );
         print(response.body);

         setState(() {
            var convertDataToJson=JSON.decode(response.body);
            data=convertDataToJson['results'];
         });

         return "success";
  }
}

