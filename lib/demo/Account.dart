import 'package:chrisandsons/constants/constants.dart';
import 'package:chrisandsons/provider/providerdata.dart';
import 'package:chrisandsons/screens/Login/login_screen.dart';
import 'package:chrisandsons/screens/cart/cart_screen.dart';
import 'package:chrisandsons/screens/userDetails/AddressList.dart';
import 'package:chrisandsons/screens/userDetails/profileScreen.dart';
import 'package:chrisandsons/screens/wishlist/wishlistScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:woocommerce/woocommerce.dart';

import '../main.dart';

class Account extends StatelessWidget {
  final List<WooProduct> products;
  final bool login;
  final WooCustomer user;

  const Account({
    Key key,
    this.products,
    this.login,
    this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: height / 6,
                width: double.infinity,
                color: Colors.black,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Positioned(
                      top: height / 15,
                      left: width / 30,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          // color: Colors.amber,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 90.0,
                                width: 90.0,
                                decoration: BoxDecoration(
                                    color: bgcontainer,
                                    borderRadius: BorderRadius.circular(8.0)),
                                child: Icon(
                                  Icons.person_outline_outlined,
                                  size: 50.0,
                                ),
                              ),
                              SizedBox(
                                width: 15.0,
                              ),
                              Container(
                                // color: Colors.red,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    login
                                        ? Text(
                                            user.firstName,
                                            style: GoogleFonts.poppins(
                                              color: Colors.white,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          )
                                        : Text(
                                            "Hello Guest",
                                            style: GoogleFonts.poppins(
                                              color: Colors.white,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                    // SizedBox(
                                    //   height: 5.0,
                                    // ),
                                    login
                                        ? Text(
                                            user.email,
                                            style: GoogleFonts.poppins(
                                              color: Colors.white38,
                                              fontSize: 13,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          )
                                        : Container(),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 35.0,
              ),
              ListTile(
                onTap: () {
                  Get.to(() => CartScreen(
                        user: user,
                        products: products,
                        login: login,
                      ));
                },
                // tileColor: Colors.white,
                title: Text(
                  "Notifications",
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                leading: Image.asset(
                  notifi,
                  scale: 2,
                ),
                // leading: Icon(
                //   Icons.notifications_none,
                //   size: 35.0,
                // ),
                subtitle: Text("Stay on top of all products updates"),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.black,
                ),
              ),
              const Divider(),
              // ListTile(
              //   onTap: () {
              //     Get.to(() => ThankYouScreen());
              //   },
              //   title: Text(
              //     "Help Center",
              //     style: GoogleFonts.poppins(
              //       fontWeight: FontWeight.w600,
              //     ),
              //   ),
              //   leading: Image.asset(
              //     helpcenter,
              //     scale: 2,
              //   ),
              //   subtitle: Text("Regarding your recent purchase"),
              //   trailing: Icon(
              //     Icons.arrow_forward_ios,
              //     color: Colors.black,
              //   ),
              // ),
              // const Divider(),
              ListTile(
                onTap: () {
                  Get.to(
                    () => WishListScreen(
                      products: products,
                      login: login,
                      user: user,
                      nav: false,
                    ),
                  );
                },
                title: Text(
                  "Wishlist",
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                leading: Image.asset(
                  wishList,
                  scale: 2,
                ),
                subtitle: Text("your most loved products"),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.black,
                ),
              ),
              login ? const Divider() : Container(),
              login
                  ? ListTile(
                      onTap: () {
                        Get.to(() => AddressList(
                              user: user,
                            ));
                      },
                      title: Text(
                        "Address",
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      leading: Image.asset(
                        address,
                        scale: 2,
                      ),
                      subtitle: Text("save address for checkout"),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.black,
                      ),
                    )
                  : Container(),
              login ? const Divider() : Container(),
              login
                  ? ListTile(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (_) => ProfileScreen(
                                  user: user,
                                )));
                      },
                      title: Text(
                        "Profile Details",
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      leading: Image.asset(
                        profile,
                        scale: 2,
                      ),
                      subtitle: Text("Change profile information"),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.black,
                      ),
                    )
                  : Container(),
              const Divider(),
              // ListTile(
              //   onTap: () {
              //     Get.to(() => SettingPage());
              //   },
              //   title: Text(
              //     "Settings",
              //     style: GoogleFonts.poppins(
              //       fontWeight: FontWeight.w600,
              //     ),
              //   ),
              //   leading: Image.asset(
              //     setting,
              //     scale: 2,
              //   ),
              //   subtitle: Text("Manage settings"),
              //   trailing: Icon(
              //     Icons.arrow_forward_ios,
              //     color: Colors.black,
              //   ),
              // ),
              // const SizedBox(
              //   height: 20.0,
              // ),
              login
                  ? Directionality(
                      textDirection: TextDirection.rtl,
                      child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                            textStyle: GoogleFonts.poppins(
                              fontSize: 17.0,
                              fontWeight: FontWeight.w600,
                            ),
                            side: BorderSide(
                              width: 1.0,
                              color: tabColor,
                            ),
                            padding: const EdgeInsets.all(8.0),
                            minimumSize: Size(width / 1.12, 50),
                          ),
                          onPressed: () {
                            CartData.woocommerce.logUserOut();
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                  builder: (context) => Home(),
                                ),
                                (route) => false);
                          },
                          icon: Icon(
                            Icons.arrow_back,
                            color: tabColor,
                          ),
                          label: Text(
                            "LOG OUT",
                            style: TextStyle(
                              color: tabColor,
                            ),
                          )),
                    )
                  : Directionality(
                      textDirection: TextDirection.rtl,
                      child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                            textStyle: GoogleFonts.poppins(
                              fontSize: 17.0,
                              fontWeight: FontWeight.w600,
                            ),
                            side: BorderSide(
                              width: 1.0,
                              color: tabColor,
                            ),
                            padding: const EdgeInsets.all(8.0),
                            minimumSize: Size(width / 1.12, 50),
                          ),
                          onPressed: () {
                            Get.to(() => LoginScreen(), fullscreenDialog: true);
                          },
                          icon: Icon(
                            Icons.arrow_back,
                            color: tabColor,
                          ),
                          label: Text(
                            "Login",
                            style: TextStyle(
                              color: tabColor,
                            ),
                          )),
                    ),
              SizedBox(
                height: 20.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
