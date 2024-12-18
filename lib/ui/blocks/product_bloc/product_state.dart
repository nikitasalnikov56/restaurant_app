part of 'product_bloc.dart';

@immutable
sealed class ProductState {}

// final class ProductInitial extends ProductState {}

// class ProductsLoaded extends ProductState {
//   final List<Product> products;
//   final List<Product>? addedProducts;
//   ProductsLoaded(this.products, {this.addedProducts});
// }

// class ProductsLoadedError extends ProductState {
//   final String error;

//   ProductsLoadedError(this.error);
// }

// class ProductAdded extends ProductState {}
class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductsLoaded extends ProductState {
  final List<Product> products;
  final List<Product>? addedProducts;

  ProductsLoaded({required this.products, this.addedProducts});
}

class ProductError extends ProductState {
  final String message;

  ProductError(this.message);
}