// import 'package:chrisandsons/constants/constants.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// // import 'package:shimmer/shimmer.dart';
// // import 'package:woocommerce/woocommerce.dart';

// class RewScreen extends StatelessWidget {
//   const RewScreen({Key key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     double height = MediaQuery.of(context).size.height;
//     double width = MediaQuery.of(context).size.width;
//     return Scaffold(
//       body: Container(
//         color: Colors.white,
//         height: height,
//         child: SingleChildScrollView(
//           // physics: const NeverScrollableScrollPhysics(),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Padding(
//                 padding: const EdgeInsets.symmetric(
//                   horizontal: 18.0,
//                   vertical: 15.0,
//                 ),
//                 child: Container(
//                   // alignment: Alignment.center,
//                   height: height / 3.99,
//                   width: width,
//                   decoration: BoxDecoration(
//                     color: Colors.black,
//                     borderRadius: BorderRadius.circular(15.0),
//                     image: DecorationImage(
//                       image: AssetImage(
//                         drawerbg,
//                       ),
//                       fit: BoxFit.fitWidth,
//                     ),
//                   ),
//                   child: Container(
//                     child: Padding(
//                       padding: const EdgeInsets.all(15.0),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Container(
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Container(
//                                   // color: Colors.red,
//                                   child: Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       Text(
//                                         "Coin Balance",
//                                         style: GoogleFonts.poppins(
//                                           color: Colors.white60,
//                                           fontSize: 10.0,
//                                         ),
//                                       ),
//                                       const SizedBox(
//                                         height: 2.0,
//                                       ),
//                                       Text(
//                                         "200 Coins",
//                                         style: GoogleFonts.poppins(
//                                           color: Colors.white,
//                                           fontWeight: FontWeight.bold,
//                                           fontSize: 20.0,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                                 Image.asset(
//                                   coin,
//                                   scale: 7.5,
//                                 ),
//                               ],
//                             ),
//                           ),
//                           const SizedBox(
//                             height: 10.0,
//                           ),
//                           Container(
//                             width: width / 1.5,
//                             child: Text(
//                               "Lorem ipusm dolor sit amet consecteutr adpisicing elit sed do",
//                               style: GoogleFonts.poppins(
//                                 color: Colors.white60,
//                                 fontSize: 12.0,
//                               ),
//                             ),
//                           ),
//                           const SizedBox(
//                             height: 20.0,
//                           ),
//                           Container(
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   "Account Holder",
//                                   style: GoogleFonts.poppins(
//                                     color: Colors.white60,
//                                     fontSize: 10.0,
//                                   ),
//                                 ),
//                                 Text(
//                                   "Jayveersinh Mahida",
//                                   style: GoogleFonts.poppins(
//                                     color: Colors.white,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           )
//                         ],
//                       ),
//                     ),
//                     // child: Row(
//                     //   mainAxisAlignment: MainAxisAlignment.center,
//                     //   children: [
//                     //     Image.asset(
//                     //       coin,
//                     //       scale: 7.5,
//                     //     ),
//                     //     SizedBox(
//                     //       width: 10.0,
//                     //     ),
//                     //     Text(
//                     //       "200 Coins",
//                     //       style: GoogleFonts.poppins(
//                     //         fontSize: 25.0,
//                     //         color: Colors.white,
//                     //         fontWeight: FontWeight.bold,
//                     //       ),
//                     //     ),
//                     //   ],
//                     // ),
//                   ),
//                 ),
//               ),
//               Padding(
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 18.0, vertical: 5.0),
//                 child: Container(
//                   // color: Colors.red,
//                   child: Row(
//                     children: [
//                       Container(
//                         height: 80,
//                         width: 165,
//                         decoration: BoxDecoration(
//                           color: Color(0xFFf2f4f7),
//                           borderRadius: BorderRadius.circular(10.0),
//                         ),
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Spacer(),
//                             Text(
//                               "Earned",
//                               style: GoogleFonts.poppins(
//                                 fontWeight: FontWeight.w500,
//                                 fontSize: 11.0,
//                               ),
//                             ),
//                             const SizedBox(
//                               height: 5,
//                             ),
//                             Container(
//                               child: Row(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   plus,
//                                   const SizedBox(
//                                     width: 2.0,
//                                   ),
//                                   Text(
//                                     "620 Coins",
//                                     style: GoogleFonts.poppins(
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             Spacer(),
//                           ],
//                         ),
//                       ),
//                       Spacer(),
//                       Container(
//                         height: 80,
//                         width: 165,
//                         decoration: BoxDecoration(
//                           color: Color(0xFFf2f4f7),
//                           borderRadius: BorderRadius.circular(10.0),
//                         ),
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Spacer(),
//                             Text(
//                               "Claimed",
//                               style: GoogleFonts.poppins(
//                                 fontWeight: FontWeight.w500,
//                                 fontSize: 11.0,
//                               ),
//                             ),
//                             const SizedBox(
//                               height: 5,
//                             ),
//                             Container(
//                               child: Row(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   mins,
//                                   const SizedBox(
//                                     width: 2.0,
//                                   ),
//                                   Text(
//                                     "150 Coins",
//                                     style: GoogleFonts.poppins(
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             Spacer(),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.symmetric(
//                   horizontal: 18.0,
//                   vertical: 10.0,
//                 ),
//                 child: Text("Coins History"),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Container(
//                   height: height / 3,
//                   child: ListView.builder(
//                     // physics: const NeverScrollableScrollPhysics(),
//                     shrinkWrap: true,
//                     itemBuilder: (context, index) {
//                       // final ord = orders[index];
//                       // final name = ord.lineItems[0].name;
//                       // print(orders[0]);
//                       return Padding(
//                         padding: const EdgeInsets.all(5.0),
//                         child: _orderList(
//                             name: "#ID98763-976243",
//                             height: height,
//                             width: width),
//                       );
//                     },
//                     itemCount: 10,
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: 20.0,
//               ),
//             ],
//           ),
//         ),
//         // child: Center(
//         //   child: Text("rewards"),
//         // ),
//       ),
//     );
//   }

//   Widget _orderList({
//     String name,
//     var height,
//     var width,
//   }
//       // WooOrder order,

//       ) {
//     return Container(
//       width: width,
//       height: 65,
//       decoration: BoxDecoration(
//         color: Color(0xFFf2f4f7),
//         borderRadius: BorderRadius.circular(10.0),
//       ),
//       padding: EdgeInsets.symmetric(horizontal: 8.0),
//       child: Row(
//         children: [
//           Container(
//             // height: height / 8,
//             // width: width / 4,
//             child: Image.asset(
//               coin,
//               scale: 10.5,
//             ),
//           ),
//           const SizedBox(
//             width: 9.0,
//           ),
//           Container(
//             // color: Colors.red,
//             width: width / 1.99,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text(
//                   name,
//                   style: GoogleFonts.poppins(
//                     color: Colors.black,
//                     fontSize: 15,
//                     fontWeight: FontWeight.w600,
//                   ),
//                   overflow: TextOverflow.clip,
//                   softWrap: false,
//                 ),
//                 Row(
//                   children: [
//                     Text(
//                       "Sun 26,",
//                       style: GoogleFonts.poppins(
//                         color: Colors.black38,
//                         fontSize: 13,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                     Text(
//                       "2:30 PM",
//                       style: GoogleFonts.poppins(
//                         color: Colors.black38,
//                         fontSize: 13,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//           Spacer(),
//           Container(
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 mins,
//                 const SizedBox(
//                   width: 2.0,
//                 ),
//                 Text(
//                   "150 Coins",
//                   style: GoogleFonts.poppins(
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           const SizedBox(
//             width: 15.0,
//           ),
//         ],
//       ),
//     );
//   }
// }


import 'package:chrisandsons/constants/constants.dart';
import 'package:chrisandsons/provider/providerdata.dart';
import 'package:chrisandsons/screens/product_detail_screen.dart';
import 'package:chrisandsons/widget/shimmerScreen.dart';
import 'package:chrisandsons/widget/shopContainer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:woocommerce/woocommerce.dart';

import '../main.dart';

class ImcomboScreen extends StatefulWidget {
  final String id, name;
  final List<WooProduct> product;
  final WooCustomer user;
  final bool login;
  const ImcomboScreen({ Key key, this.id, this.name, this.product, this.user, this.login }) : super(key: key);

  @override
  _ImcomboScreenState createState() => _ImcomboScreenState();
}

class _ImcomboScreenState extends State<ImcomboScreen> {

  final cro = Get.find<CartData>();
  //////////////////////////////
  List<WooProduct> cat = [];
  bool _loading = true;
  @override
  void initState() {
    getByCategory();
    super.initState();
    
  }
  getByCategory() async {
    cat = await CartData.woocommerce
        .getProducts(category: "73", minPrice: "1");

    print(cat.length);
    
    
      setState(() {
        _loading = false;
      });
    
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child:  Container(
          child: _loading
              ? Center(
                  child: ShimmerLoading(),
                )
              : cat.length <= 0 ? Center(child: Text("No Items ")) : GetX<CartData>(
                  // init: CartData(),
                  builder: (data) {
                    return Container(
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: cat.length <= 0
                            ? Center(child: Text("No Items "))
                            : data.mainloding.value == true && data.lodgin.value
                                ? Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : GridView.builder(
                                    shrinkWrap: true,
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                      mainAxisSpacing: 12,
                                      crossAxisSpacing: 12,
                                      crossAxisCount: 2,
                                      childAspectRatio: MediaQuery.of(context)
                                              .size
                                              .width /
                                          (MediaQuery.of(context).size.height /
                                              1.05),
                                    ),
                                    physics: const BouncingScrollPhysics(),
                                    itemCount: cat.length,
                                    itemBuilder: (context, index) {
                                      final products = cat[index];
                                      return ShopContainer(
                                        sale: products.onSale,
                                        tag: "tag-${products.name}",
                                        like: () {
                                          print("like it");
                                          data.isSave(cat[index].id);
                                          bool dd = Hive.box(FavList)
                                              .containsKey(cat[index].id);

                                          if (dd == true) {
                                            // Hive.box(FavList).delete(products.id);
                                            data.favRemove(products.id);
                                          } else {
                                            data.addFav(
                                                cat[index].id, cat[index].id);
                                            print("save thai che  bar ");
                                          }
                                          data.favList(widget.product);
                                        },
                                        details: () {
                                          Navigator.push(
                                            context,
                                            CupertinoPageRoute(
                                              builder: (context) =>
                                                  ProductDetailScreen(
                                                data: products,
                                                user: widget.user,
                                                products: widget.product,
                                                login: widget.login,
                                              ),
                                            ),
                                          );
                                        },
                                        image: products.images[0].src,
                                        dec: products.name,
                                        price: products.price,
                                        dec2: products.name,
                                        icon: Icon(
                                          Icons.favorite,
                                          size: 20.0,
                                          color: Hive.box(FavList)
                                                  .containsKey(products.id)
                                              ? Colors.red
                                              : bgcontainer,
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