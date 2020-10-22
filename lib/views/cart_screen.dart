import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_sqflite/controllers/cart_controller.dart';

class CartItemsScreen extends StatelessWidget {
  final cartController = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Cart Items",
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.delete_sweep_outlined),
              onPressed: cartController.resetCart,
            ),
            IconButton(icon: Icon(Icons.add_shopping_cart), onPressed: () {}),
          ],
        ),
        body: GetX<CartController>(
          init: CartController(),
          builder: (controller) {
            return ListView.builder(
              itemCount: controller.cartItems.length,
              itemBuilder: (context, i) {
                var product = controller.cartItems[i];
                return Dismissible(
                  background: Container(
                    decoration: BoxDecoration(color: Colors.blue.shade700),
                  ),
                  key: UniqueKey(),
                  direction: DismissDirection.endToStart,
                  onDismissed: (direction) {
                    controller.removeFromCart(product);
                    Get.snackbar(
                        "${product.productName.toUpperCase()} Deleted", "");
                  },
                  child: ListTile(
                    leading: Icon(Icons.card_travel),
                    title: Text(product.productName),
                    subtitle: Text(product.productDescription),
                    trailing: Text(product.price.toString()),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}