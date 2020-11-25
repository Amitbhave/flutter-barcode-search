import 'package:barcode_search/widgets/product_search_with_api.dart';
import 'package:flutter/material.dart';

class FutureSearchExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Barcode Search Application'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: ProductSearchWithApi());
            },
          ),
        ],
      ),
      body: Center(
        child: Text('Product catalogue screen'),
      ),
    );
  }
}
