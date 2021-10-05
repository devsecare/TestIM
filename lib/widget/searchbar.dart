import 'package:chrisandsons/screens/product_detail_screen.dart';
import 'package:chrisandsons/widget/shopContainer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:woocommerce/models/customer.dart';
import 'package:woocommerce/models/products.dart';

class ItemSearch extends SearchDelegate<WooProduct> {
  final List<WooProduct> list;
  final WooCustomer user;
  final bool login;

  ItemSearch(this.list, this.user, this.login);

  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData(
      textTheme: TextTheme(
          headline6: GoogleFonts.poppins(
        color: Colors.white,
      )),
      inputDecorationTheme: InputDecorationTheme(
        border: InputBorder.none,
      ),
      appBarTheme: AppBarTheme(
        color: Colors.black,
      ),
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = "";
          },
          icon: Icon(Icons.clear))
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
          // Navigator.pop(context);
        },
        icon: Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    return null;
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<WooProduct> mynew = [];
    mynew = list.where((p) {
      var note = p.name.toLowerCase();
      return note.contains(query);
    }).toList();

    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          crossAxisCount: 2,
          childAspectRatio: 0.51,
        ),
        physics: const BouncingScrollPhysics(),
        itemCount: query.isEmpty ? list.length : mynew.length,
        itemBuilder: (context, index) {
          final WooProduct my = query.isEmpty ? list[index] : mynew[index];
          // final products = widget.product[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => ProductDetailScreen(
                    data: my,
                    user: user,
                    products: list,
                    login: login,
                  ),
                ),
              );
            },
            child: Container(
              // height: 200,
              // width: 200,
              child: SearchContainer(
                price: my.price,
                dec: my.name,
                // dec2: products.name,
                image: my.images[0].src,
                // icon: Icon(
                //   Icons.favorite,
                //   size: 20.0,
                //   color: Hive.box(FavList).containsKey(my.id)
                //       ? Colors.red
                //       : bgcontainer,
                // ),
              ),
            ),
            // child: ProductsContainer(
            //   image: products.images[0].src,
            //   name: products.name,
            //   price: rupee + products.price,
            // ),
          );
        },
      ),
    );

    // return ListView.builder(
    //   itemBuilder: (context, index) {
    //     final WooProduct my = query.isEmpty ? list[index] : mynew[index];
    //     return ListTile(
    //       onTap: () {
    //         Navigator.push(
    //           context,
    //           CupertinoPageRoute(
    //             builder: (context) => ProductDetailScreen(
    //               data: my,
    //             ),
    //           ),
    //         );
    //       },
    //       title: Text(my.name),
    //     );
    //   },
    //   itemCount: query.isEmpty ? list.length : mynew.length,
    // );
  }
}
