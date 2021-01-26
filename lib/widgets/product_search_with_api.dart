import 'package:barcode_search/models/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class ProductSearchWithApi extends SearchDelegate<String> {
  Future _scanBarcode(BuildContext context) async {
    String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
      "#ff6666",
      "Cancel",
      true,
      ScanMode.BARCODE,
    );
    query = barcodeScanRes;
  }

  @override
  String get searchFieldLabel => 'Search (using scan)';

  @override
  List<Widget> buildActions(BuildContext context) {
    //Widgets to display after the search query in the AppBar.
    return [
      IconButton(
        icon: Icon(Icons.scanner),
        color: Theme.of(context).primaryColor,
        onPressed: () => {_scanBarcode(context)},
      ),
      IconButton(
        icon: Icon(Icons.clear),
        color: Theme.of(context).primaryColor,
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    //A widget to display before the current query in the AppBar.
    return IconButton(
      icon: BackButtonIcon(),
      color: Theme.of(context).primaryColor,
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    //The results shown after the user submits a search from the search page.
  }

  Future<List<Product>> _fetchProducts() async {
    // call your backend API
    return Future.delayed(
        Duration(seconds: 2),
        () => [
              Product('7921815609741', 'Dove'),
              Product('8908001158244', 'Fogg'),
              Product('8921815609743', 'Nivea'),
              Product('9921815609744', 'Engage'),
            ]);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Create suggestions, to be shown in the body of the search page while the user types a query into the search field.
    return FutureBuilder(
      future: _fetchProducts(),
      builder: (BuildContext ctx, AsyncSnapshot<List<Product>> snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.white,
            ),
          );
        }
        final products = query.isEmpty
            ? snapshot.data
            : snapshot.data.where((p) =>
                p.barcode.toLowerCase().startsWith(query.toLowerCase()) ||
                p.name.toLowerCase().startsWith(query.toLowerCase()));

        return ListView.builder(
          itemBuilder: (context, index) => ListTile(
            onTap: () {
              //You can navigate to product details page from here
            },
            title: Text(
              products.elementAt(index).name,
            ),
          ),
          itemCount: products.length,
        );
      },
    );
  }
}
