/// day 1 *****************************************************
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:learning_tutorials_day_by_day/product_details.dart';

int? id;
class ApiSetState extends StatefulWidget {
  const ApiSetState({super.key});

  @override
  State<ApiSetState> createState() => _ApiSetStateState();
}

class _ApiSetStateState extends State<ApiSetState> {
  /// first create a list and the type is dynamic means list is find any data like string, int, double even bool
   dynamic? data ;   ///  when you have no data in list format
   ///  when data is list format then use "List<dynamic>? data;"
   ///  and doesn't change anything in this code ....
  
  /// you know that api response me from server side means data find in future and when use future 
  /// then async and await is necessary for future method 
  Future<void>? getData() async {
    var response = await http.get(Uri.parse('https://dummyjson.com/products'));
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

    /// I can show my data after few second so
    Future.delayed(Duration(seconds: 2),(){
      getData();
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Using SetState"),
        actions: [
          Row(
            children: [
              Text("Using Provide Click"),
              IconButton(onPressed: (){
                // Navigator.push(context, MaterialPageRoute(builder: (context)=>GetDataUsingProvider()));
              }, icon: CircleAvatar(
                  radius: 20,backgroundColor: Colors.black,
                  child: Icon(Icons.forward,color: Colors.white,size: 17,))),
            ],
          )
        ],
      ),
      body: data == null ?
      Center(child: CircularProgressIndicator()):
      ListView.builder(
          itemCount: data!['products'].length,
          itemBuilder: (context,index){
        return GestureDetector(
          onTap: (){
            id = data!['products'][index]['id'];
            Navigator.push(context, MaterialPageRoute(builder: (context)=>ProductDetails(id:id!)));
          },
          child: Container(
            padding: EdgeInsets.all(4),
            margin: EdgeInsets.all(6),
            decoration: BoxDecoration(
                color: Colors.black38,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                width: 1,color: Colors.black
              )
            ),
            child: ListTile(
              title: Text(data['products'][index]['title'].toString().toUpperCase()),
              subtitle:  Text(data['products'][index]['description'].toString().toLowerCase(),
              overflow: TextOverflow.ellipsis,),
              leading: Container(
                height: 50,width: 60,padding: EdgeInsets.all(2),
                  child: Image.network(data['products'][index]['images'][0].toString(),fit: BoxFit.cover,)),
            ),
          ),
        );
      }),
    );
  }
}
