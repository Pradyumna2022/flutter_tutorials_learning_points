import 'package:flutter/material.dart';

class CartScreen extends StatefulWidget {
  final List<dynamic> cart;

  const CartScreen({super.key, required this.cart});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shopping Cart'),
      ),
      body: widget.cart.isEmpty
          ? Center(child: Text('No items in your cart'))
          : ListView.builder(
              itemCount: widget.cart.length,
              itemBuilder: (context, index) {
                final product = widget.cart[index];
                return ListTile(
                    leading: Image.network(
                      product['images'][0].toString(),
                      fit: BoxFit.cover,
                      width: 60,
                      height: 60,
                    ),
                    title: Text(product['title'].toString()),
                    subtitle: Text(product['description'].toString()),
                    trailing: IconButton(
                      icon: Icon(Icons.remove_circle),
                      onPressed: () {
                        setState(() {
                        widget.cart.removeAt(index);
                        });
                      },
                    ));
              },
            ),
    );
  }
}
