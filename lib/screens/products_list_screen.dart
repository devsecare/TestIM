import 'package:badges/badges.dart';
import 'package:chrisandsons/constants/constants.dart';
import 'package:chrisandsons/provider/providerdata.dart';
import 'package:chrisandsons/screens/product_detail_screen.dart';
import 'package:chrisandsons/widget/shopContainer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_getx_widget.dart';
import 'package:hive/hive.dart';
import 'package:woocommerce/woocommerce.dart';

import '../main.dart';
import 'notificationScreen/notification_screen.dart';

class ProductListScreen extends StatefulWidget {
  final List<WooProduct> product;
  final WooCustomer user;
  final bool login;

  const ProductListScreen({Key key, this.product, this.user, this.login})
      : super(key: key);

  @override
  _ProductListScreenState createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  final contro = Get.put(CartData());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          toolbarHeight: 70.0,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Products List",
              ),
              const SizedBox(
                height: 5.0,
              ),
              Text(
                "${widget.product.length} items",
                style: TextStyle(
                  color: Colors.white38,
                  fontSize: 15.0,
                ),
              )
            ],
          ),
          actions: [
            Obx(() => Padding(
                  padding: const EdgeInsets.all(7.0),
                  child: Badge(
                    badgeColor: tabColor,
                    padding: EdgeInsets.all(5.0),
                    position: BadgePosition(
                      bottom: 29.0,
                      start: 29.0,
                    ),
                    badgeContent: Center(
                      child: Text(
                        contro.cartitem.toString(),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10.0,
                        ),
                      ),
                    ),
                    child: IconButton(
                      icon: Icon(
                        Icons.shopping_cart,
                        size: 30.0,
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            CupertinoPageRoute(
                                builder: (context) => NotificationScreen(
                                      products: widget.product,
                                      login: widget.login,
                                      user: widget.user,
                                    )));
                      },
                    ),
                  ),
                )),
            PopupMenuButton(
              onSelected: (value) {
                switch (value) {
                  case 0:
                    widget.product.sort(
                      (a, b) => double.parse(a.price).compareTo(
                        double.parse(b.price),
                      ),
                    );
                    setState(() {});
                    print("hu low vado ");
                    break;
                  case 1:
                    widget.product.sort(
                      (a, b) => double.parse(b.price).compareTo(
                        double.parse(a.price),
                      ),
                    );
                    setState(() {});
                    print("hu high to low vado");
                    break;
                  default:
                }
              },
              icon: Icon(Icons.more_vert),
              itemBuilder: (context) => [
                PopupMenuItem(
                  value: 0,
                  child: Row(
                    children: [
                      Icon(
                        Icons.align_vertical_top,
                        color: Colors.black,
                      ),
                      Text(" Low - High "),
                    ],
                  ),
                ),
                PopupMenuItem(
                  value: 1,
                  child: Row(
                    children: [
                      Icon(
                        Icons.align_vertical_bottom,
                        color: Colors.black,
                      ),
                      Text(" High - Low "),
                    ],
                  ),
                ),
              ],
            )
          ],
          // actions: [IconButton(onPressed: () {
    
          // }, icon: Icon(Icons.more_vert))],
        ),
        body: GetX<CartData>(
          init: CartData(),
          builder: (data) {
            return data.mainloding.value == true && data.lodgin.value 
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Container(
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          mainAxisSpacing: 12,
                          crossAxisSpacing: 12,
                          crossAxisCount: 2,
                          childAspectRatio: MediaQuery.of(context).size.width /
                              (MediaQuery.of(context).size.height / 1.05),
                        ),
                        physics: const BouncingScrollPhysics(),
                        itemCount: widget.product.length,
                        itemBuilder: (context, index) {
                          final products = widget.product[index];
                          return Container(
                            // height: 200,
                            // width: 200,
                            child: ShopContainer(
                              tag: "tag-${products.name}",
                              like: () {
                                data.isSave(widget.product[index].id);
                                bool dd = Hive.box(FavList)
                                    .containsKey(widget.product[index].id);
    
                                if (dd == true) {
                                  // Hive.box(FavList).delete(products.id);
                                  data.favRemove(products.id);
                                } else {
                                  data.addFav(widget.product[index].id,
                                      widget.product[index].id);
                                  print("save thai che  bar ");
                                }
                                data.favList(widget.product);
                              },
                              details: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => ProductDetailScreen(
                                              data: products,
                                              user: widget.user,
                                              products: widget.product,
                                              login: widget.login,
                                            )));
                              },
                              price: products.price,
                              dec: products.name,
                              dec2: products.name,
                              sale: products.onSale,
                              image: products.images[0].src,
                              icon: Icon(
                                Icons.favorite,
                                size: 20.0,
                                color: Hive.box(FavList).containsKey(products.id)
                                    ? Colors.red
                                    : bgcontainer,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  );
          },
        ),
      ),
    );
  }
}
