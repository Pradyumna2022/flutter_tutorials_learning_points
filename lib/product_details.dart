/// day 1 *****************************************************
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:learning_tutorials_day_by_day/api_call_setstate.dart';
import 'package:learning_tutorials_day_by_day/cart_page.dart';

class ProductDetails extends StatefulWidget {
  final int id;
  const ProductDetails({super.key, required this.id});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  /// first create a list and the type is dynamic means list is find any data like string, int, double even bool
  dynamic? data;
  List<dynamic> cart = [];
  void addToCart() {
    setState(() {
      cart.add(data);
    });
    print(cart);
    // Provide feedback to the user, such as a snackbar notification
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Product added to cart!')),
    );
  }

  ///  when you have no data in list format
  ///  when data is list format then use "List<dynamic>? data;"
  ///  and doesn't change anything in this code ....

  /// you know that api response me from server side means data find in future and when use future
  /// then async and await is necessary for future method
  Future<void>? getData(int id) async {
    var response =
        await http.get(Uri.parse('https://dummyjson.com/products/$id'));
    print(id.toString() + "THIS IS YOUR ID ON THE PRODUCT DETAILS PAGE");
    if (response.statusCode == 200) {
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
    print(cart.toString() + 'FIRST TIME DATA OF THE CART');

    /// I can show my data after few second so
    Future.delayed(Duration(seconds: 2), () {
      print(id.toString() + 'INTI STATE WALA ID + $id');
      getData(id!);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Using SetState"),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CartScreen(cart: cart)));
                },
                icon: CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.black,
                    child: Icon(
                      Icons.shopping_cart,
                      color: Colors.white,
                      size: 17,
                    )))
          ],
        ),
        body: data == null
            ? Center(child: CircularProgressIndicator())
            : Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                        margin: EdgeInsets.only(bottom: 10),
                        height: MediaQuery.sizeOf(context).height * 0.5,
                        child: Image.network(
                          data['images'][0].toString(),
                          fit: BoxFit.cover,
                        )),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "${data['price']}₹",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 30),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          data['title'].toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 25),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: Text(
                        data['description'].toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                            fontSize: 15),
                        textAlign: TextAlign.center,
                      ),
                    ),

                    // add to cart product and also add a direct by button
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 30),
                      child: Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: addToCart,
                              child: Text(
                                "Add to cart",
                                style: TextStyle(color: Colors.white),
                              ),
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                              child: ElevatedButton(
                            onPressed: () {},
                            child: Text(
                              "Buy now",
                              style: TextStyle(color: Colors.red),
                            ),
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white),
                          ))
                        ],
                      ),
                    )
                  ],
                ),
              ));
  }
}
