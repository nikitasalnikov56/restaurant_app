import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/data/models/products.dart';
import 'package:test_app/data/repositories/product_repossitory.dart';
import 'package:test_app/ui/blocks/product_bloc/product_bloc.dart';

class MenuScreen extends StatelessWidget {
  final String tableName;

  const MenuScreen({super.key, required this.tableName});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductBloc(
          productRepository: ProductRepository(), tableName: tableName)
        ..add(LoadProducts()),
      child: Scaffold(
        appBar: AppBar(title: const Text('Выбор товаров')),
        body: const MenuWidget(),
      ),
    );
  }
}

class MenuWidget extends StatelessWidget {
  const MenuWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        if (state is ProductInitial) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is ProductsLoaded) {
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: state.addedProducts?.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(
                        state.addedProducts?[index].title ?? '',
                      ),
                      subtitle: Text(
                        '${state.addedProducts?[index].price ?? ''}',
                      ),
                    );
                  },
                ),
              ),
              Expanded(
                child: GridView(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    // childAspectRatio: 2.0,
                    mainAxisExtent: 80,
                  ),
                  children: state.products.map((item) {
                    return GestureDetector(
                      onTap: () {
                        context.read<ProductBloc>().add(AddProductToCart(item));
                      },
                      child: Card(
                        child: Row(
                          children: [
                            CachedNetworkImage(
                              imageUrl: item.imageUrl,
                              width: 50,
                              height: 50,
                            ),
                            ColumnItems(
                              item: item,
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}

class ColumnItems extends StatelessWidget {
  const ColumnItems({super.key, required this.item});
  final Product item;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            item.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            item.price.toString(),
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
// class MenuWidget extends StatelessWidget {
//   const MenuWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<ProductBloc, ProductState>(
//       builder: (context, state) {
//         if (state is ProductInitial || state is ProductLoading) {
//           return const Center(
//             child: CircularProgressIndicator(),
//           );
//         }
//         if (state is ProductsLoaded) {
//           return Column(
//             children: [
//               Expanded(
//                 child: ListView.builder(
//                   itemCount: state.addedProducts?.length,
//                   itemBuilder: (context, index) {
//                     return ListTile(
//                       title: Text(state.addedProducts?[index].title ?? ''),
//                       subtitle: Text('${state.addedProducts?[index].price ?? ''}'),
//                     );
//                   },
//                 ),
//               ),
//               Expanded(
//                 child: GridView(
//                   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                     crossAxisCount: 2,
//                     mainAxisExtent: 80,
//                   ),
//                   children: state.products.map((item) {
//                     return GestureDetector(
//                       onTap: () {
//                         // Добавление товара в корзину
//                         context.read<ProductBloc>().add(AddProductToCart(item));
//                       },
//                       child: Card(
//                         child: Row(
//                           children: [
//                             CachedNetworkImage(
//                               imageUrl: item.imageUrl,
//                               width: 50,
//                               height: 50,
//                             ),
//                             ColumnItems(item: item),
//                           ],
//                         ),
//                       ),
//                     );
//                   }).toList(),
//                 ),
//               ),
//             ],
//           );
//         }
//         return const SizedBox.shrink();
//       },
//     );
//   }
// }
