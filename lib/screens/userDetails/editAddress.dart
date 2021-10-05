import 'package:chrisandsons/constants/constants.dart';
import 'package:chrisandsons/main.dart';
import 'package:chrisandsons/provider/providerdata.dart';
import 'package:chrisandsons/screens/wishlist/loading.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:woocommerce/models/customer.dart';

class EditAddressScreen extends StatefulWidget {
  final WooCustomer user;
  const EditAddressScreen({Key key, this.user}) : super(key: key);

  @override
  _EditAddressScreenState createState() => _EditAddressScreenState();
}

class _EditAddressScreenState extends State<EditAddressScreen> {
  final _formkey = GlobalKey<FormState>();
  bool _loading = false;
  TextEditingController _firstname = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _postal = TextEditingController();
  TextEditingController _state = TextEditingController();
  TextEditingController _address = TextEditingController();
  TextEditingController _address1 = TextEditingController();
  TextEditingController _city = TextEditingController();
  TextEditingController _phone = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            toolbarHeight: 70.0,
            title: Text("Add new address"),
          ),
          body: _loading
              ? Loading(
                  body: _body(),
                )
              : _body()),
    );
  }

  Widget _body() {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Form(
              key: _formkey,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20, top: 10.0, bottom: 1.0),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Name",
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20.0, right: 20.0, top: 5, bottom: 10.0),
                          child: TextFormField(
                            controller: _firstname
                              ..text = widget.user.billing.firstName,
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Please enter Name";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Enter Name',
                                hintText: ''),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20, top: 10.0, bottom: 1.0),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Mobile",
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20.0, right: 20.0, top: 5, bottom: 10.0),
                          child: TextFormField(
                            controller: _phone
                              ..text = widget.user.billing.phone,
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value.isEmpty && value.length == 10) {
                                return "Please enter Mobile";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Enter Moblie',
                                hintText: ''),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20, top: 10.0, bottom: 1.0),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Email address",
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20.0, right: 20.0, top: 5, bottom: 10.0),
                          child: TextFormField(
                            controller: _email..text = widget.user.email,
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Please enter email address";
                              }
                              return null;
                            },
                            // controller: _username,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Enter email address',
                                hintText: 'Enter email address'),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20.0, right: 20.0, top: 5, bottom: 10.0),
                          child: Container(
                            child: Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    child: Column(
                                      children: [
                                        Align(
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                            "Pincode",
                                            style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 5.0,
                                        ),
                                        TextField(
                                          controller: _postal
                                            ..text =
                                                widget.user.billing.postcode,
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                            contentPadding: EdgeInsets.only(
                                              left: 15.0,
                                            ),
                                            hintText: "Your pincode",
                                            border: OutlineInputBorder(),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 15.0,
                                ),
                                Expanded(
                                    child: Container(
                                  child: Column(
                                    children: [
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          "State",
                                          style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5.0,
                                      ),
                                      TextField(
                                        controller: _state
                                          ..text = widget.user.billing.state.toUpperCase(),
                                        keyboardType: TextInputType.text,
                                        textCapitalization: TextCapitalization.characters,
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.only(
                                            left: 15,
                                          ),
                                          hintText: "Your State",
                                          border: OutlineInputBorder(),
                                        ),
                                      ),
                                    ],
                                  ),
                                )),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20, top: 10.0, bottom: 1.0),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Postal address",
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20.0, right: 20.0, top: 5, bottom: 10.0),
                          // padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10.0),
                          child: TextFormField(
                            controller: _address
                              ..text = widget.user.billing.address1,
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Enter House no./Building";
                              }
                              return null;
                            },
                            // controller: _username,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Enter House no./Building',
                                hintText: 'Enter House no./Building'),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20.0, right: 20.0, top: 5, bottom: 10.0),
                          // padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10.0),
                          child: TextFormField(
                            controller: _address1
                              ..text = widget.user.billing.address2,
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Please enter Locality/town";
                              }
                              return null;
                            },
                            // controller: _username,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Enter Locality/town',
                              hintText: 'Enter Locality/town',
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20.0, right: 20.0, top: 5, bottom: 10.0),
                          // padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10.0),
                          child: TextFormField(
                            controller: _city..text = widget.user.billing.city,
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Please enter City/District";
                              }
                              return null;
                            },
                            // controller: _username,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Enter City/District',
                              hintText: 'Enter City/District',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            // ElevatedButton(
            //   onPressed: () {},
            //   style: ElevatedButton.styleFrom(
            //     primary: Colors.white,
            //     side: BorderSide(
            //       width: 1.0,
            //       color: tabColor,
            //     ),
            //     padding: const EdgeInsets.all(8.0),
            //     minimumSize: Size(335, 50),
            //   ),
            //   child: Text(
            //     "CHANGE PASSWORD",
            //     style: TextStyle(color: tabColor),
            //   ),
            // ),
            SizedBox(
              height: 15.0,
            ),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                primary: tabColor,
                textStyle: GoogleFonts.poppins(
                  fontSize: 17.0,
                  fontWeight: FontWeight.w600,
                ),
                padding: const EdgeInsets.all(8.0),
                minimumSize: Size(335, 50),
              ),
              onPressed: () async {
                if (_formkey.currentState.validate()) {
                  setState(() {
                    _loading = true;
                  });
                  var data = {
                    "billing": {
                      "first_name": _firstname.text,
                      "address_1": _address.text,
                      "address_2": _address1.text,
                      "city": _city.text,
                      "state": _state.text,
                      "postcode": _postal.text,
                      "email": _email.text,
                      "phone": _phone.text
                    },
                  };

                  await CartData.woocommerce
                      .updateCustomer(id: widget.user.id, data: data);
                  setState(() {
                    _loading = false;
                  });
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: const Text("Address has been Changed"),
                  ));
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (_) => Home()),
                      (route) => false);
                }
              },
              icon: const Icon(Icons.arrow_forward),
              label: const Text("Save"),
            ),
            SizedBox(
              height: 25.0,
            ),
          ],
        ),
      ),
    );
  }
}
