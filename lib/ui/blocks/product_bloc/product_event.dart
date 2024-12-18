part of 'product_bloc.dart';

@immutable
sealed class ProductEvent {}

class LoadProducts extends ProductEvent {}

class AddProductToCart extends ProductEvent {
  final Product product;

  AddProductToCart(this.product);
}