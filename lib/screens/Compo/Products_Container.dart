import 'package:chrisandsons/constants/constants.dart';
import 'package:flutter/material.dart';

class ProductsContainer extends StatelessWidget {
  final String image, name, price;

  const ProductsContainer({Key key, this.image, this.name, this.price})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Image.network(
            image,
            width: 130.0,
            height: 120,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return Image.asset(logoloader);
            },
          ),
          Text(name ?? "loading..."),
          Text(price ?? "Loading..."),
        ],
      ),
    );
  }
}
