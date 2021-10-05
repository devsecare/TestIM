import 'package:badges/badges.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:chrisandsons/constants/constants.dart';
import 'package:chrisandsons/main.dart';
import 'package:chrisandsons/provider/carttestModel/cartbox.dart';
import 'package:chrisandsons/provider/providerdata.dart';
import 'package:chrisandsons/provider/reviews/reviewsModel.dart';
import 'package:chrisandsons/screens/Login/login_screen.dart';
import 'package:chrisandsons/screens/userDetails/firsttimeAddress.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:share/share.dart';
import 'package:shimmer/shimmer.dart';
import 'package:woocommerce/models/products.dart';
import 'package:woocommerce/woocommerce.dart';
import 'package:intl/intl.dart';


import 'package:flutter_rating_bar/flutter_rating_bar.dart';
// import 'package:html/dom.dart' as dom;

import 'checkout/addressCheck.dart';
import 'notificationScreen/notification_screen.dart';

class ProductDetailScreen extends StatefulWidget {
  final WooProduct data;
  final WooCustomer user;
  final List<WooProduct> products;
  final bool login;

  const ProductDetailScreen(
      {Key key, this.data, this.user, this.products, this.login})
      : super(key: key);

  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  CartData controller = Get.find<CartData>();
  bool userin;
  var off;
  DateFormat dateFormat = DateFormat("yyyy-MM-dd – HH:mm:ss");
  // WooOrderPayload orderPayload;

  // @override
  // void initState() {
  //   getData();
  //   super.initState();
  // }

  getData() {
    controller.isSave(widget.data.id);
    
  }

  @override
  Widget build(BuildContext context) {
    print(widget.data.salePrice);
    print(controller.cartitem);
    print("Aa valuue ave che ${widget.data.id}");
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    if (widget.data.onSale) {
      var go = double.parse(widget.data.salePrice) /
          double.parse(widget.data.regularPrice);
      print(go);
      var tt = go * 100;
      off = 100 - tt.round();
      print(off.round());
    }
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            // color: Colors.red,
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  width: 8,
                ),
                ElevatedButton.icon(
                  onPressed: () async {
                    controller.addTest(
                        widget.data.id,
                        CartBox(
                          1,
                          widget.data.id,
                          widget.data.name,
                          widget.data.onSale
                                            ? widget.data.salePrice
                                            : widget.data.regularPrice,
                          widget.data.images[0].src,
                          true,
                        ));
                    controller.cartitme1();

                    Get.snackbar(
                      "Add to Cart",
                      "Product has been added to cart",
                      colorText: Colors.white,
                      backgroundColor: Colors.black,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    // elevation: 5.0,
                    side: BorderSide(
                      color: Colors.black12,
                    ),
                    padding: const EdgeInsets.all(8.0),
                    minimumSize: Size(width / 2.6, 50),
                  ),
                  icon: Icon(
                    Icons.shopping_cart_outlined,
                    color: Colors.black45,
                  ),
                  label: const Text(
                    "ADD CART",
                    style: TextStyle(
                      color: Colors.black54,
                    ),
                  ),
                ),
                SizedBox(
                  width: 8.0,
                ),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.black,
                    padding: const EdgeInsets.all(8.0),
                    minimumSize: Size(width / 2.0, 50),
                  ),
                  onPressed: () async {
                    userin = await CartData.userlogin();
                    print(userin);
                    if (userin == false) {
                      await Hive.box(Cart_Items)
                          .put(widget.data.id, widget.data.id);

                      Get.to(() => LoginScreen(), fullscreenDialog: true);
                    } else {
                      userin && widget.user.billing.address1 == ""
                          ? Get.to(() => FirstTimeAddress(
                                user: widget.user,
                              ))
                          : userin
                              ? Get.to(() => CheckAddress(
                                    products: [
                                      CartBox(
                                        1,
                                        widget.data.id,
                                        widget.data.name,
                                        widget.data.onSale
                                            ? widget.data.salePrice
                                            : widget.data.regularPrice,
                                        widget.data.images[0].src,
                                        true,
                                      )
                                    ],
                                    user: widget.user,
                                    price:widget.data.onSale
                                            ? widget.data.salePrice
                                            : widget.data.regularPrice,
                                  ))
                              : Get.to(() => LoginScreen());
                    }
                  },
                  icon: Icon(
                    Icons.shopping_bag,
                  ),
                  label: const Text("BUY NOW"),
                ),
              ],
            ),
          ),
        ),
        body: Container(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Container(
                      color: bg,
                      child: CarouselSlider.builder(
                        itemCount: widget.data.images.length,
                        options: CarouselOptions(
                          aspectRatio: MediaQuery.of(context).size.width /
                              (MediaQuery.of(context).size.height / 1.6),
                          // aspectRatio: 12 / 12,
                          viewportFraction: 1,

                          // height: 400,
                          initialPage: 0,
                          enlargeCenterPage: true,
                          autoPlayCurve: Curves.fastOutSlowIn,
                          enableInfiniteScroll: true,
                          autoPlay: true,
                          scrollDirection: Axis.horizontal,
                          autoPlayAnimationDuration: const Duration(seconds: 1),
                          autoPlayInterval: const Duration(seconds: 3),
                        ),
                        itemBuilder:
                            (BuildContext context, int index, int realIndex) {
                          final image = widget.data.images[index].src;
                          // print("${widget.data.description}");
                          return Container(
                            // color: Colors.red,
                            // child: Text("me hu slider "),

                            child: Hero(
                              tag: "tag-${widget.data.name}",
                              child: Image.network(
                                image,
                                loadingBuilder:
                                    (context, child, loadingProgress) {
                                  if (loadingProgress == null) return child;
                                  return Shimmer.fromColors(
                                    baseColor: Colors.grey[400],
                                    highlightColor: Colors.grey[100],
                                    period: Duration(milliseconds: 1200),
                                    child: Container(
                                      width: 500,
                                      color: Colors.white,
                                    ),
                                  );
                                },
                                fit: BoxFit.cover,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Positioned(
                      top: height / 50.0,
                      left: width / 30.0,
                      child: InkWell(
                        onTap: () {
                          print("back");
                          Navigator.pop(context);
                        },
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                          child: Icon(
                            Icons.arrow_back,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: height / 50.0,
                      left: width / 1.16,
                      child: Obx(() => Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                            child: Badge(
                              badgeColor: tabColor,
                              padding: EdgeInsets.all(3.0),
                              position: BadgePosition(
                                bottom: 18.0,
                                start: 22.0,
                              ),
                              badgeContent: Center(
                                child: Text(
                                  controller.cartitem.toString(),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 8.0,
                                  ),
                                ),
                              ),
                              child: IconButton(
                                icon: Icon(
                                  Icons.shopping_cart,
                                ),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      CupertinoPageRoute(
                                          builder: (context) =>
                                              NotificationScreen(
                                                products: widget.products,
                                                login: widget.login,
                                                user: widget.user,
                                              )));
                                },
                              ),
                            ),
                          )),
                      // child: Container(
                      //   height: 40,
                      //   width: 40,
                      //   decoration: BoxDecoration(
                      //     color: Colors.white,
                      //     borderRadius: BorderRadius.circular(50.0),
                      //   ),
                      //   child: IconButton(
                      //     icon: Icon(
                      //       Icons.shopping_cart,
                      //     ),
                      //     onPressed: () {},
                      //   ),
                      // ),
                    ),
                    Positioned(
                      top: height / 50.0,
                      left: width / 1.35,
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                        child: IconButton(
                          icon: Icon(
                            Icons.share,
                          ),
                          onPressed: () {
                            Share.share(
                                "Discover the great experience of all-natural skincare and grooming products. Shop for the best natural and organic skincare products only at Incredible Man. \n${widget.data.name}  \n${widget.data.permalink}");
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 25.0,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0, bottom: 5.0),
                  child: Container(
                    // color: Colors.red,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(
                          flex: 10,
                          child: Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.data.name,
                                  overflow: TextOverflow.fade,
                                  softWrap: false,
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0,
                                  ),
                                ),
                                const SizedBox(
                                  height: 2.0,
                                ),
                                Text(
                                  widget.data.name,
                                  overflow: TextOverflow.fade,
                                  softWrap: false,
                                  style: GoogleFonts.poppins(
                                    color: Colors.black54,
                                  ),
                                ),
                                const SizedBox(
                                  height: 2.0,
                                ),
                                Row(
                                  children: [
                                    widget.data.onSale
                                        ? Text(
                                            rupee + widget.data.salePrice,
                                            style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                              fontSize: 18.0,
                                            ),
                                          )
                                        : Text(
                                            rupee + widget.data.regularPrice,
                                            style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                              fontSize: 18.0,
                                            ),
                                          ),
                                    SizedBox(
                                      width: 12.0,
                                    ),
                                    Visibility(
                                      visible: widget.data.onSale,
                                      child: Text(
                                        rupee + widget.data.regularPrice,
                                        style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black45,
                                          fontSize: 15.0,
                                          decoration:
                                              TextDecoration.lineThrough,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10.0,
                                    ),
                                    Visibility(
                                      visible: widget.data.onSale,
                                      child: Text(
                                        "($off% OFF)",
                                        style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w500,
                                          color: tabColor,
                                          fontSize: 15.0,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        Spacer(),
                        GetX<CartData>(
                          init: CartData(),
                          builder: (data) {
                            return data.mainloding.value == true && data.lodgin.value 
                                ? Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : Padding(
                                    padding: const EdgeInsets.only(
                                      top: 18.0,
                                      left: 15.0,
                                    ),
                                    child: Container(
                                      height: 45.0,
                                      width: 45.0,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(50.0),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black26,
                                            offset: const Offset(
                                              5.0,
                                              5.0,
                                            ),
                                            blurRadius: 10,
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
                                      child: IconButton(
                                        onPressed: () {
                                          data.isSave(widget.data.id);
                                          bool dd = Hive.box(FavList)
                                              .containsKey(widget.data.id);

                                          if (dd == true) {
                                            // Hive.box(FavList).delete(products.id);
                                            data.favRemove(widget.data.id);
                                          } else {
                                            data.addFav(
                                                widget.data.id, widget.data.id);
                                            print("save thai che  bar ");
                                          }
                                          data.favList(widget.products);
                                        },
                                        icon: Icon(
                                          Icons.favorite,
                                          color: Hive.box(FavList)
                                                  .containsKey(widget.data.id)
                                              ? Colors.red
                                              : bgcontainer,
                                        ),
                                        iconSize: 30.0,
                                      ),
                                    ),
                                  );
                          },
                        ),
                        SizedBox(
                          width: 40.0,
                        ),
                      ],
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: const Divider(
                    thickness: 1.0,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8.0,
                  ),
                  child: Container(
                    // height: 150,
                    // color: Colors.red,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text(
                            "Product Details",
                            style: GoogleFonts.poppins(
                              fontSize: 15.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text(
                            widget.data.shortDescription.toString(),
                            style: GoogleFonts.poppins(
                              color: Colors.black87,
                              fontSize: 13.0,
                            ),
                          ),
                        ),

                        //////////////////////////////////html tag //////////////////////////////
                        // Html(
                        //   data: widget.data.shortDescription,
                        // ),
                        /////////////////////////////////html tag////////////////////////////////
                        SizedBox(
                          height: 5.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text(
                            "General",
                            style: GoogleFonts.poppins(
                              fontSize: 15.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            // width: 200,

                            child: ListView.separated(
                                separatorBuilder: (context, index) {
                                  return Divider();
                                },
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: widget.data.metaData.length,
                                itemBuilder: (context, index) {
                                  final customedata =
                                      widget.data.metaData[index];
                                  return Container(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Container(
                                          width: 150,
                                          child: Text(
                                            customedata.key,
                                            style: GoogleFonts.poppins(
                                              color: Colors.black45,
                                              fontSize: 13.0,
                                            ),
                                          ),
                                        ),

                                        // const SizedBox(
                                        //   width: 100.0,
                                        // ),
                                        Container(
                                          child: Text(
                                            customedata.value,
                                            style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black,
                                              fontSize: 13.0,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }),
                          ),
                        )
                        // Padding(
                        //   padding: const EdgeInsets.all(8.0),
                        //   child: Container(
                        //     child: Column(
                        //       children: [

                        //         Row(
                        //           children: [
                        //             Text(
                        //               "Type",
                        //               style: GoogleFonts.poppins(
                        //                 color: Colors.black45,
                        //                 fontSize: 13.0,
                        //               ),
                        //             ),
                        //             const SizedBox(
                        //               width: 80.0,
                        //             ),
                        //             Text(
                        //               "Beard and Hair Growth Oil",
                        //               style: GoogleFonts.poppins(
                        //                 fontWeight: FontWeight.w500,
                        //                 color: Colors.black,
                        //                 fontSize: 13.0,
                        //               ),
                        //             ),
                        //           ],
                        //         ),
                        //         const SizedBox(
                        //           height: 6.0,
                        //         ),
                        //         const Divider(
                        //           thickness: 1.0,
                        //         ),
                        //         Row(
                        //           mainAxisAlignment: MainAxisAlignment.start,
                        //           crossAxisAlignment: CrossAxisAlignment.start,
                        //           children: [
                        //             Text(
                        //               "Model Name",
                        //               style: GoogleFonts.poppins(
                        //                 color: Colors.black45,
                        //                 fontSize: 13.0,
                        //               ),
                        //             ),
                        //             const SizedBox(
                        //               width: 30.0,
                        //             ),
                        //             Flexible(
                        //               child: Text(
                        //                 "Beard and Hair Growth Oil, 0 ml |\nBeard growth for men | Hair growth\noil for men | For faster beard growth",
                        //                 style: GoogleFonts.poppins(
                        //                   fontWeight: FontWeight.w500,
                        //                   color: Colors.black,
                        //                   fontSize: 13.0,
                        //                 ),
                        //                 overflow: TextOverflow.visible,
                        //                 softWrap: false,
                        //               ),
                        //             ),
                        //           ],
                        //         ),
                        //         const SizedBox(
                        //           height: 6.0,
                        //         ),
                        //         const Divider(
                        //           thickness: 1.0,
                        //         ),
                        //         Row(
                        //           mainAxisAlignment: MainAxisAlignment.start,
                        //           crossAxisAlignment: CrossAxisAlignment.start,
                        //           children: [
                        //             Text(
                        //               "Quantity",
                        //               style: GoogleFonts.poppins(
                        //                 color: Colors.black45,
                        //                 fontSize: 13.0,
                        //               ),
                        //             ),
                        //             const SizedBox(
                        //               width: 55.0,
                        //             ),
                        //             Text(
                        //               "50 ml",
                        //               style: GoogleFonts.poppins(
                        //                 fontWeight: FontWeight.w500,
                        //                 color: Colors.black,
                        //                 fontSize: 13.0,
                        //               ),
                        //             ),
                        //           ],
                        //         ),
                        //         const SizedBox(
                        //           height: 6.0,
                        //         ),
                        //         const Divider(
                        //           thickness: 1.0,
                        //         ),
                        //         Row(
                        //           mainAxisAlignment: MainAxisAlignment.start,
                        //           crossAxisAlignment: CrossAxisAlignment.start,
                        //           children: [
                        //             Text(
                        //               "Ideal For",
                        //               style: GoogleFonts.poppins(
                        //                 color: Colors.black45,
                        //                 fontSize: 13.0,
                        //               ),
                        //             ),
                        //             const SizedBox(
                        //               width: 55.0,
                        //             ),
                        //             Text(
                        //               " Men",
                        //               style: GoogleFonts.poppins(
                        //                 fontWeight: FontWeight.w500,
                        //                 color: Colors.black,
                        //                 fontSize: 13.0,
                        //               ),
                        //             ),
                        //           ],
                        //         ),
                        //         const SizedBox(
                        //           height: 6.0,
                        //         ),
                        //         const Divider(
                        //           thickness: 1.0,
                        //         ),
                        //         Row(
                        //           mainAxisAlignment: MainAxisAlignment.start,
                        //           crossAxisAlignment: CrossAxisAlignment.start,
                        //           children: [
                        //             Text(
                        //               "Applied For",
                        //               style: GoogleFonts.poppins(
                        //                 color: Colors.black45,
                        //                 fontSize: 13.0,
                        //               ),
                        //             ),
                        //             const SizedBox(
                        //               width: 41.0,
                        //             ),
                        //             Text(
                        //               "Hair Growth, Hair Thickening,\nPrevents Greying, Healthy Scalp",
                        //               style: GoogleFonts.poppins(
                        //                 fontWeight: FontWeight.w500,
                        //                 color: Colors.black,
                        //                 fontSize: 13.0,
                        //               ),
                        //             ),
                        //           ],
                        //         ),
                        //         const SizedBox(
                        //           height: 6.0,
                        //         ),
                        //         const Divider(
                        //           thickness: 1.0,
                        //         ),
                        //         Row(
                        //           mainAxisAlignment: MainAxisAlignment.start,
                        //           crossAxisAlignment: CrossAxisAlignment.start,
                        //           children: [
                        //             Text(
                        //               "Organic",
                        //               style: GoogleFonts.poppins(
                        //                 color: Colors.black45,
                        //                 fontSize: 13.0,
                        //               ),
                        //             ),
                        //             const SizedBox(
                        //               width: 60.0,
                        //             ),
                        //             Text(
                        //               "Yes",
                        //               style: GoogleFonts.poppins(
                        //                 fontWeight: FontWeight.w500,
                        //                 color: Colors.black,
                        //                 fontSize: 13.0,
                        //               ),
                        //             ),
                        //           ],
                        //         ),
                        //         const SizedBox(
                        //           height: 6.0,
                        //         ),
                        //         const Divider(
                        //           thickness: 1.0,
                        //         ),
                        //         Row(
                        //           mainAxisAlignment: MainAxisAlignment.start,
                        //           crossAxisAlignment: CrossAxisAlignment.start,
                        //           children: [
                        //             Text(
                        //               "Hair Type",
                        //               style: GoogleFonts.poppins(
                        //                 color: Colors.black45,
                        //                 fontSize: 13.0,
                        //               ),
                        //             ),
                        //             const SizedBox(
                        //               width: 53.0,
                        //             ),
                        //             Text(
                        //               "All Hair Types",
                        //               style: GoogleFonts.poppins(
                        //                 fontWeight: FontWeight.w500,
                        //                 color: Colors.black,
                        //                 fontSize: 13.0,
                        //               ),
                        //             ),
                        //           ],
                        //         ),
                        //         const SizedBox(
                        //           height: 6.0,
                        //         ),
                        //         const Divider(
                        //           thickness: 1.0,
                        //         ),
                        //         Row(
                        //           mainAxisAlignment: MainAxisAlignment.start,
                        //           crossAxisAlignment: CrossAxisAlignment.start,
                        //           children: [
                        //             Text(
                        //               "Best Suitable\nBefore",
                        //               style: GoogleFonts.poppins(
                        //                 color: Colors.black45,
                        //                 fontSize: 13.0,
                        //               ),
                        //             ),
                        //             const SizedBox(
                        //               width: 30.0,
                        //             ),
                        //             Text(
                        //               "36 Months",
                        //               style: GoogleFonts.poppins(
                        //                 fontWeight: FontWeight.w500,
                        //                 color: Colors.black,
                        //                 fontSize: 13.0,
                        //               ),
                        //             ),
                        //           ],
                        //         ),
                        //         const SizedBox(
                        //           height: 19.0,
                        //         ),
                        //         Text(
                        //           "Less Specifications",
                        //           style: GoogleFonts.poppins(
                        //             color: tabColor,
                        //             fontWeight: FontWeight.bold,
                        //           ),
                        //         ),
                        //       ],
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),

                Padding(
                  padding: const EdgeInsets.only(
                      left: 15.0, bottom: 5.0, right: 15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        // height: 90,
                        width: 80,
                        // color: Colors.red,
                        child: Column(
                          children: [
                            Container(
                              height: 70,
                              width: 70,
                              decoration: BoxDecoration(
                                  color: bg,
                                  borderRadius: BorderRadius.circular(50.0)),
                              child: Image.asset(
                                noContact,
                                scale: 2.5,
                              ),
                            ),
                            const SizedBox(
                              height: 5.0,
                            ),
                            Text(
                              "No Contact",
                              style: GoogleFonts.poppins(
                                fontSize: 12.0,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              "Delivery",
                              style: GoogleFonts.poppins(
                                fontSize: 12.0,
                                fontWeight: FontWeight.w500,
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        // height: 90,
                        width: 80,
                        // color: Colors.red,
                        child: Column(
                          children: [
                            Container(
                              height: 70,
                              width: 70,
                              decoration: BoxDecoration(
                                  color: bg,
                                  borderRadius: BorderRadius.circular(50.0)),
                              child: Image.asset(
                                deliverd,
                                scale: 2.5,
                              ),
                            ),
                            const SizedBox(
                              height: 5.0,
                            ),
                            Text(
                              "Timely",
                              style: GoogleFonts.poppins(
                                fontSize: 12.0,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              "Delivered",
                              style: GoogleFonts.poppins(
                                fontSize: 12.0,
                                fontWeight: FontWeight.w500,
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        // height: 90,
                        width: 80,
                        // color: Colors.red,
                        child: Column(
                          children: [
                            Container(
                              height: 70,
                              width: 70,
                              decoration: BoxDecoration(
                                  color: bg,
                                  borderRadius: BorderRadius.circular(50.0)),
                              child: Image.asset(
                                reture,
                                scale: 2.5,
                              ),
                            ),
                            const SizedBox(
                              height: 5.0,
                            ),
                            Text(
                              "Easy",
                              style: GoogleFonts.poppins(
                                fontSize: 12.0,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              "Return",
                              style: GoogleFonts.poppins(
                                fontSize: 12.0,
                                fontWeight: FontWeight.w500,
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        // height: 90,
                        width: 80,
                        // color: Colors.red,
                        child: Column(
                          children: [
                            Container(
                              height: 70,
                              width: 70,
                              decoration: BoxDecoration(
                                  color: bg,
                                  borderRadius: BorderRadius.circular(50.0)),
                              child: Image.asset(
                                pay,
                                scale: 2.5,
                              ),
                            ),
                            const SizedBox(
                              height: 5.0,
                            ),
                            Text(
                              "Secure",
                              style: GoogleFonts.poppins(
                                fontSize: 12.0,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              "Payment",
                              style: GoogleFonts.poppins(
                                fontSize: 12.0,
                                fontWeight: FontWeight.w500,
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 15.0, bottom: 5.0, right: 15.0),
                  child: Text(
                    "Reviews",
                    style: GoogleFonts.poppins(
                      fontSize: 15.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),

                Container(
                  child: FutureBuilder(
                    // initialData: [],
                    future: CartData().reviews(id: widget.data.id.toString()),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                    
                      if (snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.data.length >= 1) {
                          return ListView.builder(
                            itemCount: snapshot.data.length,
                            itemBuilder: (context, index) {
                              final Reviews dd = snapshot.data[index];
                                var ddd = dateFormat.format(dd.dateCreated);
                                print(ddd.toString().substring(0, 10));
                              return Padding(
                                padding: const EdgeInsets.only(
                                    left: 15.0, bottom: 35.0, right: 15.0),
                                child: ReviewContainer(
                                  img:
                                      dd.reviewerAvatarUrls.entries.first.value,
                                  name: dd.reviewer,
                                  reviews: dd.review,
                                  rate: dd.rating,
                                  date: ddd.toString().substring(0, 10),
                                ),
                              );
                            },
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                          );
                        } else if (snapshot.data.length <= 0) {
                          print("hahaha");
                          return Center(child: Text("No Reviews yet"));
                        }
                      }
                      return Center(child: CircularProgressIndicator());
                    },
                  ),
                ),
                SizedBox(
                  height: 100.0,
                ),

                // Html(
                //   data: widget.data.shortDescription,
                //   customRender: {
                //     "li": (
                //       RenderContext context,
                //       Widget child,
                //     ) {
                //       return customListItem(context.tree.element);
                //     },
                //   },
                // ),

                // Text(data.shortDescription),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Row customListItem(dom.Element node) {
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.start,
  //     children: [
  //       CircleAvatar(
  //         backgroundColor: Colors.transparent,
  //         child: Image.asset(listimage),
  //       ),
  //       SizedBox(
  //         width: 2.0,
  //       ),
  //       Expanded(
  //         child: Padding(
  //           padding: const EdgeInsets.only(top: 8.0),
  //           child: Text(
  //             node.text,
  //             style: TextStyle(
  //               color: Colors.black,
  //               fontSize: 15.0,
  //               fontWeight: FontWeight.w600,
  //             ),
  //           ),
  //         ),
  //       ),
  //     ],
  //   );
  // }
}

class ReviewContainer extends StatelessWidget {
  final String img;
  final String name;
  final String reviews;
  final int rate;
  final String date;
  const ReviewContainer({Key key, this.img, this.name, this.reviews, this.rate, this.date})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Container(
      // height: 160,
      width: width,
      // color: Colors.red,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Row(
              children: [
                ClipOval(
                  child: Image.network(
                    img,
                    scale: 0.5,
                  ),
                ),
                const SizedBox(
                  width: 10.0,
                ),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      RatingBar(
                          itemCount: 5,
                          itemSize: 18.0,
                          initialRating: rate.toDouble(),
                          allowHalfRating: false,
                          unratedColor: Colors.black,
                          ignoreGestures: true,
                          ratingWidget: RatingWidget(
                            full: Icon(
                              Icons.star,
                              color: tabColor,
                            ),
                            half: Icon(
                              Icons.star,
                              color: tabColor,
                            ),
                            empty: Icon(
                              Icons.star_border,
                              color: Colors.black45,
                            ),
                          ),
                          onRatingUpdate: (r) {})
                    ],
                  ),
                ),
                Spacer(),
                
              ],
            ),
          ),
          SizedBox(
            height: 23.0,
          ),
          Text(
            reviews,
            style: GoogleFonts.poppins(
              fontSize: 13.0,
            ),
            overflow: TextOverflow.clip,
          ),
          
          SizedBox(
            height: 10.0,
          ),
          Container(
            child: Row(
              children: [
                Text(
                  date,
                  style: GoogleFonts.poppins(
                    fontSize: 13.0,
                    color: Colors.black45,
                  ),
                ),
                Spacer(),
                // Icon(
                //   Icons.thumb_up_outlined,
                //   color: Colors.black45,
                // ),
                // const SizedBox(
                //   width: 5.0,
                // ),
                // Text(
                //   "421",
                //   style: GoogleFonts.poppins(
                //     color: Colors.black45,
                //   ),
                // ),
                // const SizedBox(
                //   width: 8.0,
                // ),
                // Icon(
                //   Icons.thumb_down_outlined,
                //   color: Colors.black45,
                // ),
                // const SizedBox(
                //   width: 6.0,
                // ),
                // Text(
                //   "421",
                //   style: GoogleFonts.poppins(
                //     color: Colors.black45,
                //   ),
                // ),
                const SizedBox(
                  width: 6.0,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
