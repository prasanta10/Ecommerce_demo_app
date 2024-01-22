import 'package:ecom_demo/components/my_button.dart';
import 'package:ecom_demo/components/my_drawer.dart';
import 'package:ecom_demo/models/product.dart';
import 'package:ecom_demo/models/shop.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  //remove item from cart method
  void removeItemFromCart(BuildContext context, Product product) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: const Text("Remove this item from your cart?"),
        actions: [
          //cancel button
          MaterialButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel')),

          //confirm button
          MaterialButton(
              onPressed: () {
                Navigator.pop(context);

                context.read<Shop>().removeFromCart(product);
              },
              child: const Text('Confirm')),
        ],
      ),
    );
  }

  void payButtonPressed(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => const AlertDialog(
        content: Text("Payment yet to be integrate!!"),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    //get access to the cart
    final cart = context.watch<Shop>().cart;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Cart Page"),
      ),
      drawer: const MyDrawer(),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(
        children: [
          // cart list
          Expanded(
            child: cart.isEmpty
                ? const Center(
                    child: Text("Your cart is empty!"),
                  )
                : ListView.builder(
                    itemCount: cart.length,
                    itemBuilder: (context, index) {
                      final item = cart[index];

                      return ListTile(
                        title: Text(item.name),
                        subtitle: Text(item.price.toStringAsFixed(2)),
                        trailing: IconButton(
                          icon: const Icon(Icons.remove),
                          onPressed: () => removeItemFromCart(context, item),
                        ),
                      );
                    }),
          ),

          //pay button
          Padding(
            padding: const EdgeInsets.all(50.0),
            child: Button(
              onTap: () => payButtonPressed(context),
              child: const Text("BUY NOW"),
            ),
          ),
        ],
      ),
    );
  }
}
