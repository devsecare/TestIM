import 'package:chrisandsons/constants/constants.dart';
import 'package:chrisandsons/demo/Account.dart';
import 'package:chrisandsons/demo/bag.dart';
import 'package:chrisandsons/demo/rew.dart';
import 'package:chrisandsons/provider/BannerAdModel/BannerAd.dart';
import 'package:chrisandsons/provider/carttestModel/cartbox.dart';
import 'package:chrisandsons/provider/providerdata.dart';
import 'package:chrisandsons/provider/reviews/reviewsModel.dart';
import 'package:chrisandsons/screens/Login/login_screen.dart';
import 'package:chrisandsons/screens/cart/cart_screen.dart';
import 'package:chrisandsons/screens/category/category_screen.dart';
import 'package:chrisandsons/screens/notificationScreen/notification_screen.dart';
import 'package:chrisandsons/screens/product_detail_screen.dart';
import 'package:chrisandsons/screens/products_list_screen.dart';
import 'package:chrisandsons/screens/splashScreen/splashScreen.dart';
import 'package:chrisandsons/screens/wishlist/wishlistScreen.dart';
import 'package:chrisandsons/widget/shimmerScreen.dart';
import 'package:chrisandsons/widget/shopContainer.dart';
import 'package:chrisandsons/widget/tabShimmer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:woocommerce/woocommerce.dart';
import 'package:badges/badges.dart';
import 'widget/searchbar.dart';
import 'package:url_launcher/url_launcher.dart';

const String Cart_Items = "cart";
const String FavList = "fav";
const String TestBox = "TestBox";
final bool nav = false;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(CartAdapter());
  await Hive.openBox(Cart_Items);
  await Hive.openBox(FavList);
  await Hive.openBox(TestBox);
  await Firebase.initializeApp();


  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final cro = Get.put(CartData());
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          elevation: 0.0,
          systemOverlayStyle:
              SystemUiOverlayStyle(statusBarColor: Colors.white),
          // centerTitle: true,
          color: Colors.black,
          titleTextStyle: TextStyle(color: Colors.white),
        ),
      ),
      debugShowCheckedModeBanner: false,
      title: 'incradable man ',
      home: SplashScreen(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final cro = Get.find<CartData>();
  // final FirebaseMessaging _messaging = FirebaseMessaging();

  //
  bool _loading;
  bool login = false;

  // List<WooProduct> products = [];
  List<WooProductCategory> category = [];
  WooCustomer user;
  List<WooOrder> orders = [];

  ///
  ///
  List<Reviews> productReviews = [];

  ///

  int userid;
  int indexvalue = 0;

  @override
  void initState() {
  print("aa init mathi che ${cro.newProducts.length}");
   _loading = true;
   
    super.initState();
    cro.cartitme1();
   

    getProducts();
    
    print("aa cartitme count che ${cro.cartitem.value}");
    
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  getProducts() async {

    try {
   
    var login1 = await CartData.woocommerce.isCustomerLoggedIn();
    var token = CartData.woocommerce.authToken;
    var auth = JwtDecoder.isExpired(token);
    print("aaa auth che $auth");
    
    cro.testData();
    cro.favList(cro.newProducts);
    for (var i = 0; i < cro.newProducts.length; i++) {
      cro.isSave(cro.newProducts[i].id);
    }
      if (login1 == true && auth == false) {
      print("hu true chu");
      try {
        userid = await CartData.woocommerce.fetchLoggedInUserId();
        print("id $userid");
        user = await CartData.woocommerce.getCustomerById(id: userid);
        
        login = true;

        orders = await CartData.woocommerce.getOrders(customer: userid);
        
      } on WooCommerceError catch (e) {
        print("aa error che ${e.message}");
      }

      print(userid);
    }
    setState(() {
      _loading = false;
    });
    } catch (e) {
      print(e);
      Get.defaultDialog(
         title: "Opps... ",
         content: Text("something Went Wrong Please Try Again")
      );
    }
   

    // CartData(products);
    


    
  }

  void hmmm() {
    cro.favList(cro.newProducts);
  }

  void tabIndex(int number) {
    setState(() {
      indexvalue = number;
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    print("aa starting ma thai che ${cro.mainloding.value}");
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 80.0,
          // iconTheme: IconThemeData(color: Colors.black),
          actions: [
            Padding(
              padding: const EdgeInsets.only(left: 7.0),
              child: IconButton(
                icon: Image.asset(
                  search,
                  scale: 2,
                ),
                onPressed: () {
                  showSearch(
                      context: context,
                      delegate: ItemSearch(
                        cro.newProducts,
                        user,
                        login,
                      ));
                  // Navigator.push(context,
                  //     CupertinoPageRoute(builder: (context) => CartScreen()));
                },
              ),
            ),
            Obx(() => cro.cr.value ? CircularProgressIndicator() :
            Padding(
                  padding: const EdgeInsets.all(7.0),
                  child: Badge(
                    badgeColor: tabColor,
                    padding: EdgeInsets.all(5.0),
                    position: BadgePosition(
                      bottom: 35.0,
                      start: 25.0,
                    ),
                    badgeContent: Center(
                      child: Text(
                        cro.cartitem.toString(),
                        
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10.0,
                        ),
                      ),
                    ),
                    child: IconButton(
                      icon: Icon(
                        Icons.shopping_cart,
                        size: 30.0,
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            CupertinoPageRoute(
                                builder: (context) => NotificationScreen(
                                      products: cro.newProducts,
                                      login: login,
                                      user: user,
                                    )));
                      },
                    ),
                  ),
                )),
          ],
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: Image.asset(
                  drawer,
                  scale: 2.0,
                ),
                onPressed: () => Scaffold.of(context).openDrawer(),
              );
            },
          ),
          elevation: 0.0,
          backgroundColor: Color(0xff0F0E0F),
          centerTitle: true,
          title: Image.asset(
            mainLogo,
            scale: 2.5,
            // width: 60,
          ),
        ),
        drawer: Drawer(
          child: Padding(
            padding: const EdgeInsets.only(top: 0.0),
            child: _loading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Container(
                    color: Colors.white,
                    child: ListView(
                      children: [
                        login
                            ? UserAccountsDrawerHeader(
                                margin: EdgeInsets.only(
                                  bottom: 10.0,
                                ),
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                  image: AssetImage(
                                    drawerbg,
                                  ),
                                  fit: BoxFit.cover,
                                )),
                                // arrowColor: Colors.black,
                                accountName: Text(
                                  user.firstName,
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                accountEmail: Text(
                                  user.email,
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                currentAccountPicture: ClipOval(
                                  child: Image.network(
                                    user.avatarUrl,
                                    scale: 1.0,
                                  ),
                                ),
                              )
                            : const UserAccountsDrawerHeader(
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                  image: AssetImage(
                                    drawerbg,
                                  ),
                                  fit: BoxFit.cover,
                                )),
                                // arrowColor: Colors.black,
                                accountName: const Text(" Hi Guest "),

                                currentAccountPicture: const CircleAvatar(
                                  backgroundColor: tabColor,
                                  child: const Icon(Icons.person),
                                ),
                                accountEmail: const Text(""),
                              ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                            // Get.to(()=> ThankYouScreen());
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CartScreen(
                                          products: cro.newProducts,
                                          user: user,
                                          login: login,
                                        )));
                          },
                          child: Container(
                            width: double.infinity,
                            height: 60,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                right: 30.0,
                                left: 20.0,
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.notifications,
                                    color: Colors.black54,
                                  ),
                                  const SizedBox(
                                    width: 20.0,
                                  ),
                                  Text(
                                    "My Notification",
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Spacer(),
                                  // Text(
                                  //   "15",
                                  //   style: GoogleFonts.poppins(
                                  //     fontWeight: FontWeight.w600,
                                  //     color: Colors.black45,
                                  //   ),
                                  // )
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 0.0,
                            left: 20.0,
                            right: 20.0,
                          ),
                          child: const Divider(
                            thickness: 1.8,
                          ),
                        ),
                        Obx(() => GestureDetector(
                              onTap: () {
                                Navigator.of(context).pop();
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            NotificationScreen(
                                              products: cro.newProducts,
                                              login: login,
                                            )));
                              },
                              child: Container(
                                width: double.infinity,
                                height: 50,
                                // color: Colors.red,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    right: 30.0,
                                    left: 20.0,
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.shopping_cart,
                                        color: Colors.black54,
                                      ),
                                      const SizedBox(
                                        width: 20.0,
                                      ),
                                      Text(
                                        "My Cart",
                                        style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Spacer(),
                                      Container(
                                        padding: EdgeInsets.only(
                                          left: 9.0,
                                          right: 9.0,
                                          top: 5.0,
                                          bottom: 5.0,
                                        ),
                                        decoration: BoxDecoration(
                                          color: tabColor,
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                        ),
                                        child: Text(
                                          "${cro.cartitem.toString()} items",
                                          style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white,
                                            fontSize: 11.50,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )),
                        Obx(() => GestureDetector(
                              onTap: () {
                                Navigator.of(context).pop();

                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => WishListScreen(
                                              products: cro.newProducts,
                                              login: login,
                                              user: user,
                                              nav: false,
                                            )));
                              },
                              child: Container(
                                width: double.infinity,
                                // color: Colors.red,
                                height: 50,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    right: 30.0,
                                    left: 20.0,
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.favorite,
                                        color: Colors.black54,
                                      ),
                                      const SizedBox(
                                        width: 20.0,
                                      ),
                                      Text(
                                        "Wishlist",
                                        style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Spacer(),
                                      Text(
                                        cro.favItme.toString(),
                                        style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black45,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 0.0,
                            left: 20.0,
                            right: 20.0,
                            bottom: 0.0,
                          ),
                          child: const Divider(
                            thickness: 1.8,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            _launchURL(
                                "https://www.incredibleman.in/faq/");
                          },
                          child: Container(
                            width: double.infinity,
                            // color: Colors.red,
                            height: 50,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                right: 30.0,
                                left: 20.0,
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.error,
                                    color: Colors.black54,
                                  ),
                                  const SizedBox(
                                    width: 20.0,
                                  ),
                                  Text(
                                    "FAQs",
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  // Spacer(),
                                  // Text(
                                  //   "30",
                                  //   style: GoogleFonts.poppins(
                                  //     fontWeight: FontWeight.w600,
                                  //     color: Colors.black45,
                                  //   ),
                                  // ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            _launchURL(
                                "https://www.incredibleman.in/contact-us/");
                          },
                          child: Container(
                            width: double.infinity,
                            // color: Colors.red,
                            height: 50,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                right: 30.0,
                                left: 20.0,
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.support_agent,
                                    color: Colors.black54,
                                  ),
                                  const SizedBox(
                                    width: 20.0,
                                  ),
                                  Text(
                                    "Contact Us",
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            _launchURL(
                                "https://www.incredibleman.in/privacy-policy/");
                          },
                          child: Container(
                            width: double.infinity,
                            // color: Colors.red,
                            height: 50,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                right: 30.0,
                                left: 20.0,
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.lock,
                                    color: Colors.black54,
                                  ),
                                  const SizedBox(
                                    width: 20.0,
                                  ),
                                  Text(
                                    "Privacy Policy",
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        login
                            ? GestureDetector(
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: const Text("Alert!"),
                                          content: const Text(
                                              " Are you sure you want to Logout?"),
                                          actions: [
                                            ElevatedButton(
                                                onPressed: () {
                                                  CartData.woocommerce
                                                      .logUserOut();
                                                      // getProducts();
                                                      // Get.back();
                                                      

                                                  Navigator.of(context)
                                                      .pushAndRemoveUntil(
                                                          MaterialPageRoute(
                                                            builder:
                                                                (context) =>
                                                                    Home(),
                                                          ),
                                                          (route) => false);
                                                },
                                                child: Text(
                                                  "yes",
                                                  style: GoogleFonts.poppins(
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                )),
                                            ElevatedButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Text(
                                                  "No",
                                                  style: GoogleFonts.poppins(
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                )),
                                          ],
                                        );
                                      });
                                },
                                child: Container(
                                  width: double.infinity,
                                  // color: Colors.red,
                                  height: 50,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                      right: 30.0,
                                      left: 20.0,
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.logout_sharp,
                                          color: Colors.black54,
                                        ),
                                        const SizedBox(
                                          width: 20.0,
                                        ),
                                        Text(
                                          "Logout",
                                          style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            : GestureDetector(
                                onTap: () {
                                  print(" Go to login Screen plz");
                                  Navigator.pop(context);
                                  Navigator.push(
                                      context,
                                      CupertinoPageRoute(
                                          builder: (context) => LoginScreen()));
                                },
                                child: Container(
                                  width: double.infinity,
                                  // color: Colors.red,
                                  height: 50,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                      right: 30.0,
                                      left: 20.0,
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.logout_sharp,
                                          color: Colors.black54,
                                        ),
                                        const SizedBox(
                                          width: 20.0,
                                        ),
                                        Text(
                                          "Login",
                                          style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                        const SizedBox(
                          height: 290.0,
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Text(
                            "V0.0.1©Incredibleman.in",
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w500,
                              fontSize: 10.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
          ),
        ),
        bottomNavigationBar: _loading
            ? TabShimmer()
            : BottomNavigationBar(
                showSelectedLabels: true,
                type: BottomNavigationBarType.fixed,
                showUnselectedLabels: true,
                selectedItemColor: tabColor,
                selectedLabelStyle: GoogleFonts.poppins(
                  fontWeight: FontWeight.w500,
                ),
                unselectedItemColor: Colors.black45,
                unselectedLabelStyle: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                ),
                onTap: (value) {
                  tabIndex(value);
                },
                currentIndex: indexvalue,
                items: <BottomNavigationBarItem>[
                  for (var tabItem in TabNavigationItem.items)
                    BottomNavigationBarItem(
                      icon: tabItem.icon,
                      label: tabItem.title.toString(),
                      activeIcon: tabItem.activeIcon,
                    )
                ],
              ),
        body: IndexedStack(
          index: indexvalue,
          children: [
            _loading
                ? Center(
                    child: ShimmerLoading(),
                  )
                : Container(
                    color: Colors.white,
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 10.0,
                            ),
                            FutureBuilder(
                                future:
                                    CartData.woocommerce.getProductCategories(),
                                builder: (context, catData) {
                                  category = catData.data;
                                  if (catData.hasData) {
                                    return Container(
                                      // color: Colors.black.withOpacity(0.1),
                                      height: height / 7.5,

                                      child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: category.length - 1,
                                        itemBuilder: (context, index) {
                                          final cat = category[index];

                                          return Padding(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 8.0,
                                              vertical: 8.0,
                                            ),
                                            child: GestureDetector(
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  CupertinoPageRoute(
                                                    builder: (context) =>
                                                        CategoryScreen(
                                                      id: cat.id.toString(),
                                                      name: cat.name,
                                                      product: cro.newProducts,
                                                      user: user,
                                                      login: login,
                                                    ),
                                                  ),
                                                );
                                              },
                                              child: Container(
                                                width: 90,
                                                height: 90,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color: index == 0
                                                      ? Colors.black
                                                      : Colors.white,
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.grey
                                                          .withOpacity(0.20),
                                                      spreadRadius: 5,
                                                      blurRadius: 7,
                                                      offset: Offset(
                                                        5,
                                                        5,
                                                      ), // changes position of shadow
                                                    ),
                                                  ],
                                                ),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      height: 50,
                                                      child: Image.asset(
                                                        cimage[index],
                                                        scale: 2,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 5.0,
                                                    ),
                                                    Text(
                                                      cat.name,
                                                      style:
                                                          GoogleFonts.poppins(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: index == 0
                                                            ? Colors.white
                                                            : Colors.black,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    );
                                  }
                                  return TabShimmer();
                                }),
                            const SizedBox(
                              height: 5.0,
                            ),
                            FutureBuilder(
                              future: CartData.bannerAD(),
                              builder: (BuildContext context,
                                  AsyncSnapshot<dynamic> snapshot) {
                                    final BannerAd banner = snapshot.data;
                                    if (snapshot.hasData){
                                      return GestureDetector(
                                        onTap: (){
                                           Navigator.push(
                                                  context,
                                                  CupertinoPageRoute(
                                                    builder: (context) =>
                                                        CategoryScreen(
                                                      id: banner.post1.offerCategory[0].toString(),
                                                      name: "offer",
                                                      product: cro.newProducts,
                                                      user: user,
                                                      login: login,
                                                    ),
                                                  ),
                                                  
                                                );
                                                print("banner id ${banner.post1.offerCategory[0].toString()}");

                                        },
                                        child: Container(
                                                                        height: height / 3.8,
                                                                        width: width,
                                                                        child: Image.network(
                                                                          banner.post1.banner,
                                                                          fit: BoxFit.cover,
                                                                        ),
                                                                      ),
                                      );

                                    }
                                    return ContainerShimmer();
                                
                              },
                            ),
                            const SizedBox(
                              height: 8.0,
                            ),
                            Container(
                              // color: Colors.red,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Best Selling ",
                                    style: GoogleFonts.poppins(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      padding: EdgeInsets.all(0.0),
                                      primary: Colors.transparent,
                                      elevation: 0.0,
                                      alignment: Alignment.centerRight,
                                    ),
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          CupertinoPageRoute(
                                              builder: (context) =>
                                                  ProductListScreen(
                                                    product: cro.newProducts,
                                                    user: user,
                                                    login: login,
                                                  )));
                                    },
                                    child: Container(
                                      child: Text(
                                        "See all",
                                        style: GoogleFonts.poppins(
                                          color: Colors.black45,
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            Obx(
                              // init: CartData(),
                               () =>
                                 cro.mainloding.value == true || cro.lodgin.value || cro.newProducts.length <=0 
                                    ? Center(
                                        child:ContainerShimmer(),
                                      )
                                    : Container(
                                        child: GridView.builder(
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          reverse: true,
                                          shrinkWrap: true,
                                          gridDelegate:
                                              SliverGridDelegateWithFixedCrossAxisCount(
                                            mainAxisSpacing: 12,
                                            crossAxisSpacing: 12,
                                            crossAxisCount: 2,
                                            childAspectRatio:
                                                MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    (MediaQuery.of(context)
                                                            .size
                                                            .height /
                                                        1.05),
                                          ),
                                          itemCount: cro.newProducts.length - 29 ?? 2 ,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            final p = cro.newProducts[index ];
                                            // print(
                                            //     " aa double che ${double.parse(p.price).toStringAsFixed(0)}");
                                            return ShopContainer(
                                              tag: "tag-${p.name}",
                                              sale: p.onSale,
                                              like: () async {
                                                cro.isSave(cro.newProducts[index].id);
                                                bool dd = Hive.box(FavList)
                                                    .containsKey(
                                                        cro.newProducts[index].id);

                                                if (dd == true) {
                                                  // Hive.box(FavList).delete(products.id);
                                                  cro.favRemove(p.id);
                                                } else {
                                                  cro.addFav(
                                                      cro.newProducts[index].id,
                                                     cro.newProducts[index].id);
                                                  // data.addTest(
                                                  //     p.id, CartBox(5, p.id));

                                                  print("save thai che  bar ");
                                                }
                                                hmmm();
                                              },
                                              details: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (_) =>
                                                            ProductDetailScreen(
                                                              data: p,
                                                              user: user,
                                                              products:
                                                                  cro.newProducts,
                                                              login: login,
                                                            )));
                                                // data.addTest(
                                                //     p.id, CartBox(2, p.id));
                                              },
                                              price: p.onSale
                                                  ? p.salePrice
                                                  : p.regularPrice,
                                              dec: p.name,
                                              image: p.images[0].src,
                                              dec2: p.name,
                                              icon: Icon(
                                                Icons.favorite,
                                                size: 20.0,
                                                color: Hive.box(FavList)
                                                        .containsKey(
                                                            cro.newProducts[index].id)
                                                    ? Colors.red
                                                    : bgcontainer,
                                              ),
                                            );
                                          },
                                        ),
                                      )
                              
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                             FutureBuilder(
                              future: CartData.bannerAD(),
                              builder: (BuildContext context,
                                  AsyncSnapshot<dynamic> snapshot) {
                                    final BannerAd banner = snapshot.data;
                                    if (snapshot.hasData){
                                      return GestureDetector(
                                        onTap: (){
                                           Navigator.push(
                                                  context,
                                                  CupertinoPageRoute(
                                                    builder: (context) =>
                                                        CategoryScreen(
                                                      id: banner.post2.offerCategory[0].toString(),
                                                      name: "offer",
                                                      product: cro.newProducts,
                                                      user: user,
                                                      login: login,
                                                    ),
                                                  ),
                                                  
                                                );
                                                print("banner id ${banner.post2.offerCategory[0].toString()}");

                                        },
                                        child: Container(
                                                                        height: height / 3.8,
                                                                        width: width,
                                                                        child: Image.network(
                                                                          banner.post2.banner,
                                                                          fit: BoxFit.cover,
                                                                        ),
                                                                      ),
                                      );

                                    }
                                    return TabShimmer();
                                
                              },
                            ),
                            Container(
                              // color: bgcontainer,
                              // color: Colors.white,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Recommended",
                                    style: GoogleFonts.poppins(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      padding: EdgeInsets.all(0.0),
                                      primary: Colors.transparent,
                                      elevation: 0.0,
                                      alignment: Alignment.centerRight,
                                    ),
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          CupertinoPageRoute(
                                              builder: (context) =>
                                                  ProductListScreen(
                                                    product: cro.newProducts,
                                                    user: user,
                                                    login: login,
                                                  )));
                                    },
                                    child: Container(
                                      child: Text(
                                        "See all",
                                        style: GoogleFonts.poppins(
                                          color: Colors.black45,
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 9.0,
                            ),
                            Obx(
                              // init: CartData(),
                              () 
                                =>  cro.mainloding.value == true || cro.lodgin.value || cro.newProducts.length <=0 
                                    ? Center(
                                        child:ContainerShimmer(),
                                      )
                                    :Container(
                                        // color: bgcontainer,
                                        child: GridView.builder(
                                          shrinkWrap: true,
                                          reverse: true,
                                          gridDelegate:
                                              SliverGridDelegateWithFixedCrossAxisCount(
                                            mainAxisSpacing: 12,
                                            crossAxisSpacing: 12,
                                            crossAxisCount: 2,
                                            childAspectRatio:
                                                MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    (MediaQuery.of(context)
                                                            .size
                                                            .height /
                                                        1.05),
                                          ),
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          itemBuilder: (context, index) {
                                            final p = cro.newProducts[index];
                                            return ShopContainer(
                                              tag: "tag-${p.name}",
                                              sale: p.onSale,
                                              like: () async {
                                                cro.isSave(cro.newProducts[index].id);
                                                bool dd = Hive.box(FavList)
                                                    .containsKey(
                                                        cro.newProducts[index].id);

                                                if (dd == true) {
                                                  cro.favRemove(p.id);
                                                } else {
                                                  cro.addFav(
                                                      cro.newProducts[index].id,
                                                     cro.newProducts[index].id);
                                                  print("save thai che  bar ");
                                                }
                                                hmmm();
                                              },
                                              details: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (_) =>
                                                            ProductDetailScreen(
                                                              data: p,
                                                              user: user,
                                                              products:
                                                                  cro.newProducts,
                                                              login: login,
                                                            )));
                                              },
                                              price: p.onSale
                                                  ? p.salePrice
                                                  : p.regularPrice,
                                              dec: p.name,
                                              dec2: p.name,
                                              image: p.images[0].src,
                                              icon: Icon(
                                                Icons.favorite,
                                                size: 20.0,
                                                color: Hive.box(FavList)
                                                        .containsKey(
                                                            cro.newProducts[index].id)
                                                    ? Colors.red
                                                    : bgcontainer,
                                              ),
                                            );
                                          },
                                          itemCount:
                                              cro.newProducts.length -15?? 6,
                                        ),
                                      ),
                              
                            ),
                            const SizedBox(
                              height: 20.0,
                            ),
                            Container(
                              child: Text("© 2021 Incredible Man"),
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
            // DevScreen(),
            ImcomboScreen(
              id: "73",
              user: user,
              login: login,
              name: "Im Combo",
              product: cro.newProducts,
            ),
            BagScreen(
              orders: orders,
            ),
            Account(
              products: cro.newProducts,
              login: login,
              user: user,
            ),
          ],
        ),
      ),
    );
  }
}
