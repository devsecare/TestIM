import 'package:chrisandsons/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerLoading extends StatelessWidget {
  const ShimmerLoading({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        child: Shimmer.fromColors(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 10.0,
                ),
                Container(
                  // color: bgcontainer,
                  height: height / 7,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            // Hive.box(FavList).clear();
                          },
                          child: Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: bgcontainer,
                                  blurRadius: 1.0,
                                  offset: const Offset(
                                    1.5,
                                    1.5,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    color: Colors.white,
                    height: height / 3.1,
                    width: width,
                  ),
                ),
                Container(
                  // color: bgcontainer,
                  // color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 8.0,
                        ),
                        child: Text(
                          " Best Selling ",
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: ElevatedButton(
                          style: ButtonStyle(
                            elevation: MaterialStateProperty.all(0.0),
                            backgroundColor: MaterialStateProperty.all(
                              Colors.transparent,
                            ),
                          ),
                          onPressed: () {},
                          child: Container(
                            child: Text(
                              " See all",
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  // color: bgcontainer,
                  child: GridView.builder(
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(10.0),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      crossAxisCount: 2,
                      childAspectRatio: 0.48,
                    ),
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Container(
                        height: 350,
                        width: 450,
                        color: Colors.white,
                      );
                    },
                    itemCount: 16,
                  ),
                ),
              ],
            ),
          ),
          baseColor: Colors.grey[350],
          highlightColor: Colors.grey[100],
        ),
      ),
    );
  }
}

class PriceLoading extends StatelessWidget {
  const PriceLoading({ Key key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300],
      highlightColor: Colors.grey[100],
      child: Container(
        height: 20,
        width: 65,
        color: Colors.red,
        
      ),
    );
  }
}