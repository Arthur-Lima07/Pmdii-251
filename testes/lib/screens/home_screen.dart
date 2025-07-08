import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/cart_model.dart';
import 'product_list_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final total = context.watch<CartModel>().totalPrice;

    return Scaffold(
      appBar: AppBar(title: const Text('Resumo do Carrinho')),
      body: Center(
        child: Text(
          'Total: R\$ ${total.toStringAsFixed(2)}',
          style: const TextStyle(fontSize: 24),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const ProductListScreen()),
          );
        },
        label: const Text('Adicionar Itens'),
        icon: const Icon(Icons.add_shopping_cart),
      ),
    );
  }
}
