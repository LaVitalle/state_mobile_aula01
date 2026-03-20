import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/product.dart';

class ProductState {
  final List<Product> products;
  final bool showOnlyFavorites;

  ProductState({
    required this.products,
    this.showOnlyFavorites = false,
  });

  int get favoriteCount => products.where((p) => p.favorite).length;

  List<Product> get filteredProducts =>
      showOnlyFavorites ? products.where((p) => p.favorite).toList() : products;

  ProductState copyWith({List<Product>? products, bool? showOnlyFavorites}) {
    return ProductState(
      products: products ?? this.products,
      showOnlyFavorites: showOnlyFavorites ?? this.showOnlyFavorites,
    );
  }
}

class ProductNotifier extends StateNotifier<ProductState> {
  ProductNotifier()
      : super(ProductState(
          products: [
            Product(name: 'Notebook', price: 3500),
            Product(name: 'Mouse', price: 120),
            Product(name: 'Teclado', price: 250),
            Product(name: 'Monitor', price: 900),
            Product(name: 'Headset', price: 350),
            Product(name: 'Webcam', price: 280),
          ],
        ));

  void toggleFavorite(Product product) {
    product.favorite = !product.favorite;
    state = state.copyWith(products: [...state.products]);
  }

  void toggleFilter() {
    state = state.copyWith(showOnlyFavorites: !state.showOnlyFavorites);
  }
}

final productProvider = StateNotifierProvider<ProductNotifier, ProductState>(
  (ref) => ProductNotifier(),
);
