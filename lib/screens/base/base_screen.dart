import 'package:flutter/material.dart';
import 'package:lojavirtual/common/custom_drawer/custom_drawer.dart';
import 'package:lojavirtual/models/page_manager.dart';
import 'package:lojavirtual/screens/products/products_screen.dart';

import 'package:provider/provider.dart';

class BaseScreen extends StatelessWidget {
  final PageController pagecontroller = PageController();

  BaseScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (context) => PageManager(pagecontroller),
      child: PageView(
        controller: pagecontroller,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          Scaffold(
            drawer: const CustomDrawer(),
            appBar: AppBar(
              title: const Text('Home'),
              backgroundColor: const Color.fromARGB(255, 9, 27, 39),
            ),
          ),
          const ProductsScreen(),
          Scaffold(
            drawer: const CustomDrawer(),
            appBar: AppBar(
              title: const Text('Home2'),
              backgroundColor: const Color.fromARGB(255, 9, 27, 39),
            ),
          ),
          Scaffold(
            drawer: const CustomDrawer(),
            appBar: AppBar(
              title: const Text('Home3'),
              backgroundColor: const Color.fromARGB(255, 9, 27, 39),
            ),
          ),
        ],
      ),
    );
  }
}
