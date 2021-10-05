import 'package:chrisandsons/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddAddressScreen extends StatefulWidget {
  const AddAddressScreen({Key key}) : super(key: key);

  @override
  _AddAddressScreenState createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          toolbarHeight: 70.0,
          title: Text("Add new address"),
        ),
        body: Container(
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
                                  left: 20.0,
                                  right: 20.0,
                                  top: 5,
                                  bottom: 10.0),
                              // padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10.0),
                              child: TextFormField(
                                // controller: _username,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return "Please enter Name";
                                  }
                                  return null;
                                },
                                // controller: _username,
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
                                  left: 20.0,
                                  right: 20.0,
                                  top: 5,
                                  bottom: 10.0),
                              // padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10.0),
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                // controller: _username,
                                validator: (value) {
                                  if (value.isEmpty && value.length == 10) {
                                    return "Please enter Mobile";
                                  }
                                  return null;
                                },
                                // controller: _username,
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
                                  left: 20.0,
                                  right: 20.0,
                                  top: 5,
                                  bottom: 10.0),
                              // padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10.0),
                              child: TextFormField(
                                // controller: _username,
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
                            // Padding(
                            //   padding: const EdgeInsets.only(
                            //       left: 20, top: 10.0, bottom: 1.0),
                            //   child: Align(
                            //     alignment: Alignment.topLeft,
                            //     child: Text(
                            //       "Birthday",
                            //       style: GoogleFonts.poppins(
                            //         fontWeight: FontWeight.bold,
                            //       ),
                            //     ),
                            //   ),
                            // ),

                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 20.0,
                                  right: 20.0,
                                  top: 5,
                                  bottom: 10.0),
                              // padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10.0),
                              child: Container(
                                child: Row(
                                  // mainAxisAlignment:
                                  //     MainAxisAlignment.spaceAround,
                                  // crossAxisAlignment: CrossAxisAlignment.center,
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
                                              keyboardType:
                                                  TextInputType.number,
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
                                  left: 20.0,
                                  right: 20.0,
                                  top: 5,
                                  bottom: 10.0),
                              // padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10.0),
                              child: TextFormField(
                                // controller: _username,
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
                                  left: 20.0,
                                  right: 20.0,
                                  top: 5,
                                  bottom: 10.0),
                              // padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10.0),
                              child: TextFormField(
                                // controller: _username,
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
                                  left: 20.0,
                                  right: 20.0,
                                  top: 5,
                                  bottom: 10.0),
                              // padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10.0),
                              child: TextFormField(
                                // controller: _username,
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
                    minimumSize: Size(width / 1.16, 50),
                  ),
                  onPressed: () async {
                    // if (_formkey.currentState.validate()) {}
                  },
                  icon: const Icon(Icons.arrow_forward),
                  label: const Text("ADD NEW ADDRESS"),
                ),
                SizedBox(
                  height: 25.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
