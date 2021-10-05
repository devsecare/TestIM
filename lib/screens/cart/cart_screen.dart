import 'package:badges/badges.dart';
import 'package:chrisandsons/constants/constants.dart';
import 'package:chrisandsons/provider/providerdata.dart';
import 'package:chrisandsons/screens/notificationScreen/notification_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:woocommerce/models/customer.dart';
import 'package:woocommerce/models/products.dart';

class CartScreen extends StatefulWidget {
  final WooCustomer user;
  final bool login;
  final List<WooProduct> products;

  const CartScreen({Key key, this.user, this.login, this.products})
      : super(key: key);
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final cro = Get.put(CartData());
  // List<WooCartItem> cart;

  // @override
  // void initState() {
  //   super.initState();
  //   countercontroller.fetchdata();
  // }

  // getData() async {
  //   var cart = await CartData.woocommerce.getMyCart();
  //   print(cart);
  // }

  @override
  Widget build(BuildContext context) {
    // print(cart.name);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          toolbarHeight: 70.0,
          title: Text(
            "Notifications ",
            style: TextStyle(
              color: Colors.white,
            ),
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
                        cro.cartitem.toString(),
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
                            MaterialPageRoute(
                                builder: (context) => NotificationScreen(
                                      products: widget.products,
                                      login: widget.login,
                                      user: widget.user,
                                    )));
                      },
                    ),
                  ),
                )),
          ],
        ),
        body: NotificationWidget(),
      ),
    );
  }
}

class NotificationWidget extends StatelessWidget {
  const NotificationWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    // final width = MediaQuery.of(context).size.width;

    return Container(
      // color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(child: Text("No Notification"),),
      ),
    );
  }
}
