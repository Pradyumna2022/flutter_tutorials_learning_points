
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class ApiSetState extends StatefulWidget {
  const ApiSetState({super.key});

  @override
  State<ApiSetState> createState() => _ApiSetStateState();
}

class _ApiSetStateState extends State<ApiSetState> {
  /// first create a list and the type is dynamic means list is find any data like string, int, double even bool
  List<dynamic>? data ;
  
  /// you know that api response me from server side means data find in future and when use future 
  /// then async and await is necessary for future method 
  Future<void>? getData() async {
    var response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
    if(response.statusCode == 200){
      /// You're using setState() to update the data variable with the decoded JSON response.
      /// By doing this within setState(), you're informing Flutter that the state of the widget
      /// has changed and that it needs to rebuild with the updated data.
       setState(() {
         data = jsonDecode(response.body);
       });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    data =[];

    /// I can show my data after few second so
    Future.delayed(Duration(seconds: 2),(){
      getData();
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Data show only use SetState"),
      ),
      body: data!.isEmpty ?
      Center(child: CircularProgressIndicator()):
      ListView.builder(
          itemCount: data!.length,
          itemBuilder: (context,index){
        return Container(
          padding: EdgeInsets.all(4),
          margin: EdgeInsets.all(6),
          decoration: BoxDecoration(
              color: Colors.white38,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              width: 1,color: Colors.black
            )
          ),
          child: ListTile(
            title: Text(data![index]['title'].toString().toUpperCase()),
            subtitle:  Text(data![index]['body'].toString().toLowerCase()),
          ),
        );
      }),
    );
  }
}
