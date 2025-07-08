import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/cart_model.dart';

class ProductListScreen extends StatelessWidget {
  const ProductListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final products = [
      Product('Camiseta', 49.90),
      Product('Tênis', 199.99),
      Product('Boné', 39.50),
      Product('Calça Jeans', 89.90),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Lista de Produtos')),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (_, index) {
          final product = products[index];

          return ListTile(
            title: Text(product.name),
            subtitle: Text('R\$ ${product.price.toStringAsFixed(2)}'),
            trailing: IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                context.read<CartModel>().add(product);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('${product.name} adicionado ao carrinho'),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
