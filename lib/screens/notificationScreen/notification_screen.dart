import 'package:badges/badges.dart';
import 'package:chrisandsons/constants/constants.dart';
import 'package:chrisandsons/main.dart';
import 'package:chrisandsons/provider/carttestModel/cartbox.dart';

import 'package:chrisandsons/provider/providerdata.dart';
import 'package:chrisandsons/screens/Login/login_screen.dart';
import 'package:chrisandsons/screens/checkout/addressCheck.dart';
import 'package:chrisandsons/screens/userDetails/firsttimeAddress.dart';
import 'package:chrisandsons/screens/wishlist/wishlistScreen.dart';
import 'package:chrisandsons/widget/orderContainer.dart';
import 'package:chrisandsons/widget/sampleContainer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:lottie/lottie.dart';

import 'package:woocommerce/models/products.dart';
import 'package:woocommerce/woocommerce.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class NotificationScreen extends StatefulWidget {
  final List<WooProduct> products;
  final WooCustomer user;
  final bool login;

  const NotificationScreen({Key key, this.products, this.login, this.user})
      : super(key: key);
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final contro = Get.find<CartData>();
  List<WooProduct> category;
  // final contro = Get.find();

  var total = 0;
  var bb = 0.obs;

  @override
  void initState() {
    super.initState();
    getData();
    getPopup();
  }

  getData() {
    contro.testData();
    contro.fav();
  }

  getLike() {
    contro.favList(widget.products);
    contro.testData();
    for (var i = 0; i < widget.products.length; i++) {
      contro.isSave(widget.products[i].id);
    }
  }

  getPopup() {
    if (double.parse(contro.testTotal.value) >= 700.0) {
      print("aa sample product api sakai ");
      Future.delayed(Duration(milliseconds: 100), () {
        Get.defaultDialog(
          title: "Congratulations",
          content: Container(
            child: Stack(
              alignment: AlignmentDirectional.center,
              children: [
                LottieBuilder.asset(
                  samplecong,
                  repeat: false,
                  height: 150,
                  width: 600,
                ),
                Center(
                  child: Text("Now you can Add Sample products"),
                )
              ],
            ),
          ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          toolbarHeight: 70.0,
          title: Text(
            "Shopping cart",
            style: TextStyle(color: Colors.white),
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
                        contro.favItme.toString(),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10.0,
                        ),
                      ),
                    ),
                    child: IconButton(
                      icon: Icon(
                        Icons.favorite,
                        size: 30.0,
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => WishListScreen(
                                      products: widget.products,
                                      login: widget.login,
                                      user: widget.user,
                                      nav: true,
                                    )));
                      },
                    ),
                  ),
                )),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Obx(() => Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.min,
                children: [
                  double.parse(contro.testTotal.value) >= 700.0
                      ? Container(
                          child: ElevatedButton.icon(
                            onPressed: () {
                              showCupertinoModalBottomSheet(
                                  context: context,
                                  expand: true,
                                  builder: (context) => Material(
                                        child: Container(
                                          child: FutureBuilder(
                                              future: CartData.woocommerce
                                                  .getProducts(category: "15"),
                                              builder: (context, sample) {
                                                category = sample.data;
                                                if (sample.hasData) {
                                                  return Container(
                                                    child:
                                                        SingleChildScrollView(
                                                      child: Column(
                                                        children: [
                                                          SizedBox(
                                                            height: 20.0,
                                                          ),
                                                          Text(
                                                            "Add Sample Prodcuts",
                                                            style: GoogleFonts
                                                                .poppins(
                                                              fontSize: 15.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: 20.0,
                                                          ),
                                                          ListView.builder(
                                                              itemCount:
                                                                  category
                                                                      .length,
                                                              shrinkWrap: true,
                                                              physics:
                                                                  NeverScrollableScrollPhysics(),
                                                              itemBuilder:
                                                                  (context,
                                                                      index) {
                                                                final cat =
                                                                    category[
                                                                        index];
                                                                //  CartBox dd = contro.tcart[index];
                                                                return Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          8.0),
                                                                  child:
                                                                      SampleContainer(
                                                                    name: cat
                                                                        .name,
                                                                    url: cat
                                                                        .images[
                                                                            0]
                                                                        .src,
                                                                    add: () {
                                                                      var x = contro
                                                                          .tcart
                                                                          .where((element) =>
                                                                              element.sample ==
                                                                              false)
                                                                          .toList();
                                                                      if (double.parse(contro.testTotal.value) >=
                                                                              1200.0 &&
                                                                          x.length <
                                                                              2) {
                                                                        Hive.box(TestBox).put(
                                                                            cat.id,
                                                                            CartBox(
                                                                              1,
                                                                              cat.id,
                                                                              cat.name,
                                                                              cat.price,
                                                                              cat.images[0].src,
                                                                              false,
                                                                            ));
                                                                        contro
                                                                            .testData();
                                                                        getData();
                                                                      } else if (double.parse(contro.testTotal.value) >= 700.0 &&
                                                                          double.parse(contro.testTotal.value) <
                                                                              1200.0 &&
                                                                          x.length ==
                                                                              0) {
                                                                        Hive.box(TestBox).put(
                                                                            cat.id,
                                                                            CartBox(
                                                                              1,
                                                                              cat.id,
                                                                              cat.name,
                                                                              cat.price,
                                                                              cat.images[0].src,
                                                                              false,
                                                                            ));
                                                                        contro
                                                                            .testData();
                                                                        getData();
                                                                      } else {
                                                                        Get.snackbar(
                                                                          "Sample Already Added",
                                                                          "No More Sample ",
                                                                          backgroundColor:
                                                                              Colors.black54,
                                                                          colorText:
                                                                              Colors.white,
                                                                        );
                                                                      }
                                                                      // Hive.box(TestBox).put(
                                                                      //     cat.id,
                                                                      //     CartBox(
                                                                      //       1,
                                                                      //       cat.id,
                                                                      //       cat.name,
                                                                      //       cat.price,
                                                                      //       cat.images[0].src,
                                                                      //       false,
                                                                      //     ));
                                                                      // contro
                                                                      //     .testData();
                                                                      // getData();
                                                                    },
                                                                  ),
                                                                );
                                                              }),
                                                        ],
                                                      ),
                                                    ),
                                                  );
                                                }
                                                return Container(
                                                    child: Center(
                                                        child:
                                                            CircularProgressIndicator()));
                                              }),
                                        ),
                                      ));
                            },
                            style: ElevatedButton.styleFrom(
                                primary: Colors.black,
                                textStyle: GoogleFonts.poppins(
                                  fontSize: 17.0,
                                ),
                                padding: const EdgeInsets.all(8.0),
                                minimumSize: Size(width / 1.1, 60)),
                            icon: Icon(CupertinoIcons.arrow_right_circle_fill),
                            label: Text("Add Sample"),
                          ),
                        )
                      : Container(),
                  SizedBox(
                    height: 5.0,
                  ),
                  contro.testTotal.value == "0"
                      ? ElevatedButton.icon(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                              primary: Colors.black,
                              textStyle: GoogleFonts.poppins(
                                fontSize: 17.0,
                              ),
                              padding: const EdgeInsets.all(8.0),
                              minimumSize: Size(width / 1.1, 60)),
                          icon: Icon(CupertinoIcons.arrow_right_circle_fill),
                          label: Text("Add Product to cart"),
                        )
                      : ElevatedButton.icon(
                          onPressed: () {
                            widget.login && widget.user.billing.address1 == ""
                                ? Get.to(() => FirstTimeAddress(
                                      user: widget.user,
                                    ))
                                : widget.login
                                    // ? Get.to(() => SummaryScreen())
                                    ? Get.to(() => CheckAddress(
                                          products: contro.tcart,
                                          user: widget.user,
                                          price: contro.testTotal.toString(),
                                        ))
                                    : Get.to(() => LoginScreen());
                          },
                          style: ElevatedButton.styleFrom(
                              primary: Colors.black,
                              textStyle: GoogleFonts.poppins(
                                fontSize: 17.0,
                              ),
                              padding: const EdgeInsets.all(8.0),
                              minimumSize: Size(width / 1.1, 60)),
                          icon: Icon(CupertinoIcons.arrow_right_circle_fill),
                          label: Text("PLACE ORDER"),
                        ),
                ],
              ),
            )),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.start,
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GetX<CartData>(
                  init: contro,
                  // initState: contro.fetchdata(widget.products),
                  builder: (data) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text(
                            "${data.tcart.length}  Items",
                            style: GoogleFonts.poppins(
                              fontSize: 19.0,
                              fontWeight: FontWeight.w700,
                              color: Colors.black,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            "Total: ${rupee + data.testTotal.string}",
                            style: GoogleFonts.poppins(
                              fontSize: 18.0,
                              fontWeight: FontWeight.w600,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                Obx(
                  () {
                    return contro.mainloding.value == true && contro.lodgin.value  || contro.lodgin1.value
                        ? Container(
                            height: 400,
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          )
                        : Container(
                            child: contro.tcart.length <= 0
                                ? Center(
                                    child: Text("No items Added Yet"),
                                  )
                                : ListView.builder(
                                    shrinkWrap: true,
                                    physics: const BouncingScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      CartBox dd = contro.tcart[index];
                                      var ff = Hive.box(FavList)
                                          .containsKey(contro.tcart[index].id);
                                      print("aa sample check che ${dd.sample}");
                                      return OrderContainer(
                                        sample: contro.tcart[index].sample,
                                        qun: dd.quntity.toString(),
                                        url: dd.urlImage,
                                        name: dd.name,
                                        price: dd.price,
                                        shortname: dd.name,
                                        wishList: () {
                                          print("wishlist button");
                                          contro.isSave(contro.tcart[index].id);
                                          bool bb = Hive.box(FavList)
                                              .containsKey(
                                                  contro.tcart[index].id);

                                          if (bb == true) {
                                            contro.favRemove(
                                                contro.tcart[index].id);
                                            getLike();

                                            contro.cartitme1();
                                          } else {
                                            contro.addFav(
                                                contro.tcart[index].id,
                                                contro.tcart[index].id);
                                            print("save thai che  bar ");
                                            getLike();
                                            contro.cartitme1();
                                          }
                                        },
                                        minus: () {
                                          print("minus");
                                          var vv = dd.quntity--;
                                          if (vv != 1) {
                                            vv--;
                                          }

                                          Hive.box(TestBox).put(
                                              dd.id,
                                              CartBox(
                                                vv,
                                                dd.id,
                                                dd.name,
                                                dd.price,
                                                dd.urlImage,
                                                true,
                                              ));
                                          contro.testData();
                                          contro.sampleDatacheck();
                                          getData();
                                          // getPopup();
                                        },
                                        inc: () {
                                          print("plus");

                                          var vv = dd.quntity++;
                                          if (vv != 5) {
                                            vv++;
                                          }

                                          Hive.box(TestBox).put(
                                              dd.id,
                                              CartBox(
                                                vv,
                                                dd.id,
                                                dd.name,
                                                dd.price,
                                                dd.urlImage,
                                                true,
                                              ));

                                          contro.testData();
                                          // contro.sampleDatacheck();
                                          getData();
                                          // getPopup();
                                        },
                                        remove: () {
                                          print("remove button");
                                          print(
                                              "remove check ${contro.tcart[index].id}");
                                          contro.remove(contro.tcart[index].id);

                                          contro.testData();

                                          contro.cartitme1();
                                          contro.sampleDatacheck();
                                          getData();
                                        },
                                        ic: Icon(
                                          ff == true
                                              ? Icons.favorite
                                              : Icons.favorite_border_outlined,
                                          color: ff == true
                                              ? Colors.red
                                              : Colors.black,
                                        ),
                                      );
                                    },
                                    itemCount: contro.tcart.length,
                                  ),
                          );
                  },
                ),
                SizedBox(
                  height: 100,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
