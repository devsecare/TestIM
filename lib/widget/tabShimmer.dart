import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class TabShimmer extends StatelessWidget {
  const TabShimmer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300],
      highlightColor: Colors.grey[100],
      child: Container(
        height: 50.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(
              Icons.person,
              size: 25.0,
            ),
            Icon(
              Icons.person,
              size: 25.0,
            ),
            Icon(
              Icons.person,
              size: 25.0,
            ),
            Icon(
              Icons.person,
              size: 25.0,
            ),
          ],
        ),
      ),
    );
  }
}


class ContainerShimmer extends StatelessWidget {
  const ContainerShimmer({ Key key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
     baseColor: Colors.grey[300],
      highlightColor: Colors.grey[100],
      child: Container(
        height: 200,
        width: double.infinity,
        color: Colors.red,
      
      ),
    );
  }
}