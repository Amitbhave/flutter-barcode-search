import 'package:barcode_search/widgets/product_search.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: BarcodeSearch(),
  ));
}

class BarcodeSearch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Barcode Search Application'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: ProductSearch());
            },
          ),
        ],
      ),
      body: Center(
        child: Text(
          'Product Catalogue Screen',
        ),
      ),
    );
  }
}
