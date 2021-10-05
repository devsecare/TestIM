import 'package:chrisandsons/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SampleContainer extends StatelessWidget {
  final String name;
  final String url;
  final VoidCallback add;
  const SampleContainer({Key key, this.name, this.url, this.add})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      child: Row(
        children: [
          Container(
            height: height / 8,
            width: width / 4.5,
            decoration: BoxDecoration(
              color: bgcontainer,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Image.network(
              url,
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(
            width: 9.0,
          ),
          Container(
            // color: Colors.red,
            width: width / 1.99,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: GoogleFonts.poppins(
                    color: Colors.green,
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Text(
                  "Free",
                  style: GoogleFonts.poppins(
                    color: Colors.black38,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          Spacer(),
          ElevatedButton(
            onPressed: add,
            style: ElevatedButton.styleFrom(
              primary: Colors.black,
            ),
            child: Text("ADD ✔"),
          ),
        ],
      ),
    );
  }
}
