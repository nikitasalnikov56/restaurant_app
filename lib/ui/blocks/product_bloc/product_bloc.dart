import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:test_app/data/api/api.dart';
import 'package:test_app/data/models/products.dart';
import 'package:test_app/data/repositories/product_repossitory.dart';

part 'product_event.dart';
part 'product_state.dart';

// class ProductBloc extends Bloc<ProductEvent, ProductState> {
//   ProductBloc() : super(ProductInitial()) {
//     on<LoadProducts>(_onLoadAllProducts);
//   }

//   Future<void> _onLoadAllProducts(
//       LoadProducts event, Emitter<ProductState> emit) async {
//     try {
//       List<Product> products = await Api.getProducts();
//       emit(ProductsLoaded(products));
//     } catch (e) {
//       emit(
//         ProductsLoadedError(
//           e.toString(),
//         ),
//       );
//     }
//   }
// }



class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository productRepository;
  final String tableName; // Добавляем столик

  ProductBloc({required this.productRepository, required this.tableName})
      : super(ProductInitial()) {
        productRepository.init();
    on<LoadProducts>((event, emit) async {
      emit(ProductLoading());
      try {
        List<Product> products = await Api.getProducts();
        // final products = await productRepository.getProducts();
        // final addedProducts = await productRepository.getCartItems(tableName); // Загрузка товаров из корзины
        emit(ProductsLoaded(products: products));
      } catch (e) {
        emit(ProductError('Не удалось загрузить продукты'));
      }
    });

    on<AddProductToCart>((event, emit) async {
      if (state is ProductsLoaded) {
        final currentState = state as ProductsLoaded;
        final updatedCart = List<Product>.from(currentState.addedProducts ?? []);
        updatedCart.add(event.product);
        emit(ProductsLoaded(products: currentState.products, addedProducts: updatedCart));

        // Сохранение в базу данных
        await productRepository.addProductToCart(event.product, tableName);
      }
    });
  }
}
