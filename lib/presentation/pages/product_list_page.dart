import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../state/provider/product_provider.dart';

class ProductListPage extends ConsumerWidget {
  const ProductListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(productProvider);
    final notifier = ref.read(productProvider.notifier);
    final products = state.filteredProducts;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Produtos'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        actions: [
          // Contador de favoritos
          Center(
            child: Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Chip(
                avatar: const Icon(Icons.star, color: Colors.amber, size: 18),
                label: Text('${state.favoriteCount}'),
              ),
            ),
          ),
          // Filtro de favoritos
          IconButton(
            icon: Icon(
              state.showOnlyFavorites ? Icons.filter_alt : Icons.filter_alt_outlined,
            ),
            tooltip: state.showOnlyFavorites ? 'Mostrar todos' : 'Apenas favoritos',
            onPressed: () => notifier.toggleFilter(),
          ),
        ],
      ),
      body: products.isEmpty
          ? const Center(
              child: Text(
                'Nenhum produto favorito encontrado.',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];

                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  color: product.favorite ? Colors.deepPurple.shade50 : null,
                  child: ListTile(
                    title: Text(
                      product.name,
                      style: TextStyle(
                        fontWeight: product.favorite ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                    subtitle: Text(
                      'R\$ ${product.price.toStringAsFixed(2)}',
                      style: TextStyle(
                        color: product.favorite ? Colors.deepPurple : Colors.grey.shade700,
                      ),
                    ),
                    trailing: IconButton(
                      icon: Icon(
                        product.favorite ? Icons.star : Icons.star_border,
                        color: product.favorite ? Colors.amber : Colors.grey,
                        size: 28,
                      ),
                      onPressed: () => notifier.toggleFavorite(product),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
