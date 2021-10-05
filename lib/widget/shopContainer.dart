import 'package:chrisandsons/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ShopContainer extends StatelessWidget {
  final String price, image, dec, dec2, tag;
  final VoidCallback like, details;
  final Icon icon;
  final bool sale;

  const ShopContainer({
    Key key,
    this.price,
    this.image,
    this.dec,
    this.dec2,
    this.like,
    this.details,
    this.icon,
    this.sale,
    this.tag,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      // height: height / 10,
      // color: Colors.red,
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
                  child: Hero(
                    tag: tag,
                    child: Image.network(
                      image,
                      // fit: BoxFit.cover,
                      width: width / 2,
                      height: height / 3.5,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Image.asset(
                          logoloader,
                          width: width / 2,
                          height: height / 3.5,
                        );
                      },
                    ),
                  ),
                ),
                Visibility(
                  visible: sale,
                  child: Positioned(
                    left: width / 30,
                    top: 8.0,
                    child: Container(
                      height: 35.0,
                      width: 35.0,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        image: DecorationImage(image: AssetImage(sales)),
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
                      child: Text(
                        "SALE",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 8.0,
                        ),
                      ),
                    ),
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
                      child: icon,
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
               dec == null
                    ? SizedBox()
                    :   Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    dec ,
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
                          dec2,
                          style: GoogleFonts.poppins(
                            color: Color(0xff898989),
                            fontWeight: FontWeight.w500,
                          ),
                          overflow: TextOverflow.fade,
                          softWrap: false,
                          // style: pricestyle,
                        ),
                      ),
                const SizedBox(
                  height: 5.0,
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    "₹$price",
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

class SearchContainer extends StatelessWidget {
  final String price, image, dec, dec2;
  final VoidCallback details;
  final Icon icon;
  const SearchContainer(
      {Key key,
      this.price,
      this.image,
      this.dec,
      this.dec2,
      this.details,
      this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
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
                  width: 200.0,
                  height: 250,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Image.asset(logoloader);
                  },
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
                  dec ?? "product name",
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
                        dec2 ?? "product dec",
                        style: GoogleFonts.poppins(color: Color(0xfff0F0E0F)),
                        // style: pricestyle,
                      ),
                    ),
              const SizedBox(
                height: 5.0,
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  "₹$price" ?? "price",
                  style: pricestyle,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
