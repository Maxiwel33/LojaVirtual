import 'package:flutter/material.dart';
import 'package:lojavirtual/common/custom_drawer/custom_drawer.dart';
import 'package:lojavirtual/models/products_manager.dart';
import 'package:lojavirtual/screens/products/components/product_list_tile.dart';
import 'package:lojavirtual/screens/products/components/search_dialog.dart';
import 'package:provider/provider.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomDrawer(),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 4, 125, 141),
        title: const Text('Produtos'),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            onPressed: () {
              showDialog(context: context, builder: (_) => SearchDialog());
            },
            icon: const Icon(Icons.search),
          )
        ],
      ),
      body: Consumer<ProductManager>(builder: (_, productManager, __) {
        return ListView.builder(
          padding: const EdgeInsets.all(12.0),
          itemCount: productManager.allProducts.length,
          itemBuilder: (_, index) {
            return ProductListTile(productManager.allProducts[index]);
          },
        );
      }),
    );
  }
}
