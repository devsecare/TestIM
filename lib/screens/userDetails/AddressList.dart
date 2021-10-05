// import 'package:chrisandsons/provider/providerdata.dart';
// import 'package:chrisandsons/screens/userDetails/add_address.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:woocommerce/woocommerce.dart';

// class UserDetailScreen extends StatefulWidget {
//   @override
//   _UserDetailScreenState createState() => _UserDetailScreenState();
// }

// class _UserDetailScreenState extends State<UserDetailScreen> {
//   WooCustomer user;
//   int userid;
//   bool loadind;
//   @override
//   void initState() {
//     loadind = true;
//     super.initState();
//     getuserDetail();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           "My Profile",
//           // style: TextStyle(
//           //   color: Colors.black,
//           // ),
//         ),
//       ),
//       body: loadind
//           ? Center(
//               child: CircularProgressIndicator(),
//             )
//           : Container(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 mainAxisSize: MainAxisSize.max,
//                 children: [
//                   Text(user.firstName),
//                   Text(user.password ?? "hmmm"),
//                   Text(user.email),
//                   Text(user.isPayingCustomer.toString()),
//                   Text(user.shipping.address1 ?? "hmmm"),
//                   Text(user.shipping.postcode ?? "hmmm"),
//                   Text(user.shipping.city ?? "hmm"),
//                   Text(user.links.collection.length.toString() ?? "hmm"),
//                   Text(user.metaData.length.toString() ?? "hmm"),
//                   Text(user.billing.address1 ?? "hmm"),
//                   ElevatedButton.icon(
//                       onPressed: () {
//                         Get.to(() => AddAddressScreen());
//                       },
//                       icon: Icon(Icons.edit),
//                       label: Text("Edit Address")),
//                 ],
//               ),
//             ),
//     );
//   }

//   void getuserDetail() async {
//     userid = await CartData.woocommerce.fetchLoggedInUserId();
//     user = await CartData.woocommerce.getCustomerById(id: userid);
//     setState(() {
//       loadind = false;
//     });
//   }
// }

import 'package:chrisandsons/constants/constants.dart';
import 'package:chrisandsons/screens/userDetails/editAddress.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:woocommerce/models/customer.dart';

class AddressList extends StatefulWidget {
  final WooCustomer user;
  const AddressList({Key key, this.user}) : super(key: key);

  @override
  _AddressListState createState() => _AddressListState();
}

class _AddressListState extends State<AddressList> {
  @override
  Widget build(BuildContext context) {
    // final width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("Address"),
          toolbarHeight: 70.0,
        ),
        body: Container(
          child: Column(
            children: [
              ListTile(
                selected: true,
                selectedTileColor: Color(0xffF1F1F1),
                onTap: () {
                  print("tile click");
                },
                leading: Container(
                  height: 25,
                  width: 25,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  child: IconButton(
                    padding: const EdgeInsets.all(0.0),
                    icon: Icon(
                      Icons.done,
                      color: Colors.white,
                      size: 19.0,
                    ),
                    onPressed: () {},
                  ),
                ),
                trailing: TextButton(
                  onPressed: () {
                    Get.to(() => EditAddressScreen(
                          user: widget.user,
                        ));
                  },
                  child: Text(
                    "Edit",
                    style: GoogleFonts.poppins(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w700,
                      color: tabColor,
                    ),
                  ),
                ),
                title: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Text(
                    widget.user.billing.firstName,
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${widget.user.billing.address1}, ${widget.user.billing.city}, ${widget.user.billing.address2}\n${widget.user.billing.postcode} ${widget.user.billing.state}",
                        style: GoogleFonts.poppins(
                          color: Colors.black45,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        "Mobile: ${widget.user.billing.phone}",
                        style: GoogleFonts.poppins(
                          color: Colors.black45,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // ListTile(
              //   selected: false,
              //   selectedTileColor: Color(0xffF1F1F1),
              //   onTap: () {
              //     print("tile click");
              //   },
              //   leading: Container(
              //     height: 25,
              //     width: 25,
              //     decoration: BoxDecoration(
              //       color: Colors.white,
              //       border: Border.all(
              //         color: Colors.black26,
              //       ),
              //       borderRadius: BorderRadius.circular(25.0),
              //     ),
              //     child: IconButton(
              //       padding: const EdgeInsets.all(0.0),
              //       icon: Icon(
              //         Icons.done,
              //         color: Colors.black26,
              //         size: 19.0,
              //       ),
              //       onPressed: () {},
              //     ),
              //   ),
              //   trailing: TextButton(
              //     onPressed: () {
              //       Get.to(() => EditAddressScreen());
              //     },
              //     child: Text(
              //       "Edit",
              //       style: GoogleFonts.poppins(
              //         fontSize: 18.0,
              //         fontWeight: FontWeight.w700,
              //         color: tabColor,
              //       ),
              //     ),
              //   ),
              //   title: Padding(
              //     padding: const EdgeInsets.all(5.0),
              //     child: Text(
              //       "Alex George,",
              //       style: GoogleFonts.poppins(
              //         color: Colors.black,
              //         fontWeight: FontWeight.bold,
              //       ),
              //     ),
              //   ),
              //   subtitle: Padding(
              //     padding: const EdgeInsets.all(8.0),
              //     child: Column(
              //       crossAxisAlignment: CrossAxisAlignment.start,
              //       children: [
              //         Text(
              //           "13C, Bearly lake, walney, Barrow, London, \nUnited kingdom LA14 K3,",
              //           style: GoogleFonts.poppins(
              //             color: Colors.black45,
              //             fontWeight: FontWeight.w600,
              //           ),
              //         ),
              //         const SizedBox(
              //           height: 10.0,
              //         ),
              //         Text(
              //           "Mobile: 8320241748,",
              //           style: GoogleFonts.poppins(
              //             color: Colors.black45,
              //             fontWeight: FontWeight.w600,
              //           ),
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
              const SizedBox(
                height: 50.0,
              ),
              // ElevatedButton.icon(
              //   onPressed: () {
              //     Get.to(() => AddAddressScreen());
              //   },
              //   style: ElevatedButton.styleFrom(
              //     primary: Colors.white,
              //     side: BorderSide(
              //       width: 1.0,
              //       color: Colors.black54,
              //     ),
              //     padding: const EdgeInsets.all(8.0),
              //     minimumSize: Size(width / 1.16, 50),
              //   ),
              //   icon: Icon(
              //     Icons.add,
              //     color: Colors.black,
              //     size: 20.0,
              //   ),
              //   label: Text(
              //     "ADD NEW ADDRESS",
              //     style: GoogleFonts.poppins(
              //       color: black,
              //       fontWeight: FontWeight.bold,
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
