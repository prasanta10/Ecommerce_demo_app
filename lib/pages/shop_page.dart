import 'package:ecom_demo/components/my_drawer.dart';
import 'package:ecom_demo/components/my_product_tile.dart';
import 'package:flutter/material.dart';
import 'package:ecom_demo/models/shop.dart';
import 'package:provider/provider.dart';

class ShopPage extends StatelessWidget {
  const ShopPage({super.key});

  @override
  Widget build(BuildContext context) {
    //access products in shop
    final products = context.watch<Shop>().shop;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Shop Page"),
        actions: [
          //go to cart button
          IconButton(
              onPressed: () => Navigator.pushNamed((context), '/cart_page'),
              icon: const Icon(Icons.shopping_cart_outlined))
        ],
      ),
      drawer: const MyDrawer(),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: ListView(
        children: [
          const SizedBox(height: 25),
          //Shop Subtitle
          Center(
              child: Text(
            "Pick from the selected range of anime hoodies",
            style:
                TextStyle(color: Theme.of(context).colorScheme.inversePrimary),
          )),

          //product list
          SizedBox(
            height: 600,
            child: ListView.builder(
              itemCount: products.length,
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.all(15),
              itemBuilder: (context, index) {
                //get each product from shop
                final product = products[index];

                return MyProductTile(product: product);
              },
            ),
          ),
        ],
      ),
    );
  }
}
