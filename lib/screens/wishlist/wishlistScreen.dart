import 'package:badges/badges.dart';
import 'package:chrisandsons/constants/constants.dart';
import 'package:chrisandsons/provider/providerdata.dart';
import 'package:chrisandsons/screens/notificationScreen/notification_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:woocommerce/models/customer.dart';
import 'package:woocommerce/models/products.dart';

import '../product_detail_screen.dart';

class WishListScreen extends StatefulWidget {
  final List<WooProduct> products;
  final bool login;
  final WooCustomer user;
  final bool nav;
  const WishListScreen(
      {Key key, this.products, this.login, this.user, this.nav})
      : super(key: key);

  @override
  _WishListScreenState createState() => _WishListScreenState();
}

class _WishListScreenState extends State<WishListScreen> {
  final fav = Get.put(CartData());
  // @override
  // void initState() {
  //   super.initState();
  //   getdata();
  // }

  // getdata() {
  //   fav.favList(widget.products);
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          toolbarHeight: 70.0,
          title: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Wishlist"),
              SizedBox(
                height: 5.0,
              ),
              GetX<CartData>(
                builder: (data) {
                  return Text(
                    "${data.favTotal.toString()} Items",
                    style: TextStyle(
                      fontSize: 15.0,
                      color: Colors.white38,
                    ),
                  );
                },
              ),
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
                        fav.cartitem.toString(),
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
                        if (widget.nav == false) {
                          Navigator.push(
                              context,
                              CupertinoPageRoute(
                                  builder: (context) => NotificationScreen(
                                        products: widget.products,
                                        login: widget.login,
                                        user: widget.user,
                                      )));
                          // Navigator.pop(context);
                        } else {
                          Navigator.pop(context);
                        }
                      },
                    ),
                  ),
                )),
          ],
        ),
        body: GetX<CartData>(
          init: CartData(),
          builder: (data) {
            return data.mainloding.value == true && data.lodgin.value 
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Padding(
                    padding:
                        const EdgeInsets.only(left: 15.0, right: 15.0, top: 8.0),
                    child: Container(
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          mainAxisSpacing: 12,
                          crossAxisSpacing: 12,
                          crossAxisCount: 2,
                          childAspectRatio: MediaQuery.of(context).size.width /
                              (MediaQuery.of(context).size.height / 1.05),
                        ),
                        physics: const BouncingScrollPhysics(),
                        itemCount: data.favlist1.length,
                        itemBuilder: (context, index) {
                          final products = data.favlist1[index];
                          return Container(
                            child: WishListContainer(
                              like: () {
                                data.favRemove(products.id);
                                data.favList(widget.products);
                              },
                              details: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => ProductDetailScreen(
                                              data: products,
                                              user: widget.user,
                                              products: widget.products,
                                              login: widget.login,
                                            )));
                              },
                              dec: products.name,
                              dec2: products.name,
                              price: products.price,
                              image: products.images[0].src,
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

class WishListContainer extends StatelessWidget {
  final VoidCallback details;
  final VoidCallback like;
  final String image;
  final String dec;
  final String dec2;
  final String price;
  final String tag;
  const WishListContainer(
      {Key key,
      this.details,
      this.like,
      this.image,
      this.dec,
      this.dec2,
      this.tag,
      this.price})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6.0),
              color: bgcontainer,
            ),
            child: Stack(
              children: [
                GestureDetector(
                  onTap: details,
                  child: Image.network(
                    image,
                    // fit: BoxFit.cover,
                    width: width / 2,
                    height: height / 3.5,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Image.asset(logoloader);
                    },
                  ),
                ),
                Positioned(
                  left: width / 3,
                  top: 8.0,
                  child: InkWell(
                    onTap: like,
                    child: Container(
                      height: 30.0,
                      width: 30.0,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            offset: const Offset(
                              5.0,
                              5.0,
                            ),
                            blurRadius: 20.5,
                            spreadRadius: 0.0,
                          ), //BoxShadow
                          BoxShadow(
                            color: Colors.white,
                            offset: const Offset(0.0, 0.0),
                            blurRadius: 0.0,
                            spreadRadius: 0.0,
                          ), //BoxShadow
                        ],
                      ),
                      child: Icon(
                        Icons.close,
                        size: 20.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 5.0,
          ),
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    dec ?? "₹6000",
                    style: titletyle,
                    overflow: TextOverflow.fade,
                    softWrap: false,
                  ),
                ),
                const SizedBox(
                  height: 5.0,
                ),
                dec2 == null
                    ? SizedBox()
                    : Align(
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          dec2 ?? "",
                          overflow: TextOverflow.fade,
                          softWrap: false,
                          style: GoogleFonts.poppins(
                            color: Color(0xff898989),
                          ),
                          // style: pricestyle,
                        ),
                      ),
                const SizedBox(
                  height: 5.0,
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    "₹$price" ?? "₹5000",
                    style: pricestyle,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
