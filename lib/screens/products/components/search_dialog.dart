// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:lojavirtual/models/products_manager.dart';
import 'package:provider/provider.dart';

class SearchDialog extends StatelessWidget {
  const SearchDialog(this.initialText);

  final String initialText;

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => ProductManager(),
      child: Stack(
        children: [
          Positioned(
            top: 2,
            left: 4,
            right: 4,
            child: Card(
              child: TextFormField(
                initialValue: initialText,
                textInputAction: TextInputAction.search,
                autofocus: true,
                decoration: InputDecoration(
                  hintText: 'Pesquise',
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(vertical: 15),
                  prefixIcon: IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(Icons.arrow_back),
                  ),
                ),
                onFieldSubmitted: (search) {
                  if (search != null)
                    // ignore: curly_braces_in_flow_control_structures
                    context.read<ProductManager>().search = search;
                  Navigator.of(context).pop();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
