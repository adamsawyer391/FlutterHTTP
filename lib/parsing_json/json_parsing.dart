
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
//import 'package:http/http.dart';
import 'package:networking/model/post.dart';

class JsonParsingSimple extends StatefulWidget {
  @override
  _JsonParsingSimpleState createState() => _JsonParsingSimpleState();
}

class _JsonParsingSimpleState extends State<JsonParsingSimple> {

  // late Future<Post> data;
  late Future data;
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    data = getData();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("HTTP Networking - JSON"),
      ),
      body: Center(
        child: Container(
          child: FutureBuilder(
            future: getData(),
            builder: (context, AsyncSnapshot<dynamic> snapshot){
              if(snapshot.hasData){
                return createListView(snapshot.data, context);
                // return Padding(
                //   padding: const EdgeInsets.all(16.0),
                //   child: Text(snapshot.data[0]['title'].toString(), style: TextStyle(
                //     fontSize: 18.0
                //   ),),
                // );
              }
              return CircularProgressIndicator();
            }),
        ),
      ),
    );
  }

  // Future<Post> getData() async {
  //   var data;
  //   String url = "https://jsonplaceholder.typicode.com/posts";
  //   Network network = Network(url);
  //   data = network.fetchData();
  //   print(data);
  //   return data;
  // }

  Future getData() async {
    var data;
    String url = "https://jsonplaceholder.typicode.com/posts";
    Network network = Network(url);
    data = network.fetchData();
    // data.then((value){
    //   print(value[0]['title']);
    // });
    print(data);
    return data;
  }

  Widget createListView(List data, BuildContext context) {
    return Container(
      child: ListView.builder(
        itemCount: data.length,
          itemBuilder: (context, int index){
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Divider(
              height: 1.0,
            ),
            ListTile(
              tileColor: (index % 2 == 0) ? Colors.grey : Colors.white,
              title: Text("${data[index]['title']}", style: TextStyle(
                color: (index % 2 == 0) ? Colors.white : Colors.black ,
              )),
              subtitle: Text("${data[index]["body"]}", style: TextStyle(
                color: (index % 2 == 0) ? Colors.white : Colors.black)),
              leading: Column(
                children: <Widget>[
                  CircleAvatar(
                    backgroundColor: Colors.red,
                    radius: 23,
                    child: Text("${data[index]["id"]}", style: TextStyle(
                      color: Colors.black
                    ),),
                  )
                ],
              ),
            )
          ],
        );
      }),
    );
  }

}

class Network{
  final String url;

  Network(this.url);

  Future fetchData() async {
    final response = await http.get(Uri.parse(url));
    if(response.statusCode == 200){
      print("$url");
      return json.decode(response.body);
      //return Post.fromJson(jsonDecode(response.body));
    }else{
      throw Exception('Failed to load');
    }
  }

  // Future<Post> fetchData() async {
  //   final response = await http.get(Uri.parse(url));
  //   if(response.statusCode == 200){
  //     print("$url");
  //     return json.decode(response.body);
  //     //return Post.fromJson(jsonDecode(response.body));
  //   }else{
  //     throw Exception('Failed to load');
  //   }
  // }

  // Future fetchData() async {
  //   print("$url");
  //   Response response = await get(Uri.encodeFull(url));
  //   if(response.statusCode == 200){
  //     print(response.body);
  //     return response.body;
  //   }else{
  //     print(response.statusCode);
  //   }
  // }

}

