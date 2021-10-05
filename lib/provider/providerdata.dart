import 'package:chrisandsons/constants/constants.dart';
import 'package:chrisandsons/demo/Account.dart';
import 'package:chrisandsons/demo/bag.dart';
import 'package:chrisandsons/demo/rew.dart';
import 'package:chrisandsons/provider/carttestModel/cartbox.dart';
import 'package:chrisandsons/provider/couponModel/couponModel.dart';
import 'package:chrisandsons/provider/shippingmodel/shippingModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:woocommerce/woocommerce.dart';
import 'package:http/http.dart' as http;

import '../main.dart';
import 'BannerAdModel/BannerAd.dart';
import 'reviews/reviewsModel.dart';

class CartData extends GetxController {
  List<WooProduct> newProducts = List<WooProduct>.empty(growable: true).obs;
  var lodgin = true.obs;
  var mainloding = true.obs;
  var cr = true.obs;
  @override
  void onInit() {
    getxfetchData();
    super.onInit();
  }

  getxfetchData() async {
    try {
      mainloding(true);
      print(lodgin.value);
      var gx = await woocommerce.getProducts(
        perPage: 50,
        minPrice: "1",
      );
      newProducts.assignAll(gx);
      print("aa getxmathi che ${newProducts.length}");

      print(lodgin.value);
      update();
      mainloding(false);
    } catch (e) {
       Get.defaultDialog(
         title: "Opps... ",
         content: Text("something Went Wrong Please Try Again")
      );
    }
  }

  List<WooProduct> favlist1 = List<WooProduct>.empty(growable: true).obs;
  List<WooProduct> cartdata2 = List<WooProduct>.empty(growable: true).obs;

  static bool loginornot;

  var favTotal = 0.obs;
  var cartitem = 0.obs;
  var favItme = 0.obs;
  var count = 1.obs;
  var testTotal = "0".obs;

  var isfav = false.obs;
//////////////////////////////////////////////////
  var total = 0.0.obs;
  var lodgin1 = true.obs;

  List<CartBox> tcart = List<CartBox>.empty(growable: true).obs;

  static WooCommerce woocommerce = WooCommerce(
    baseUrl: baseUrl,
    consumerKey: ck,
    consumerSecret: cs,
    isDebug: false,
  );

  fav() {
    var dd = Hive.box(FavList).length;
    favItme(dd);
  }

  Future<List<Reviews>> reviews({String id}) async {
    try {
      var response = await http.get(
          "https://www.incredibleman.in/wp-json/wc/v3/products/reviews?consumer_key=$ck&consumer_secret=$cs&product=$id");

      final reviews = reviewsFromJson(response.body);

      return reviews;
    } catch (e) {
      return e;
    }
  }

  static Future<List<CouponModel>> couponCheck({String code}) async {
    try {
      var response = await http.get(
          "https://www.incredibleman.in/wp-json/wc/v3/coupons?consumer_secret=$cs&consumer_key=$ck&code=$code");

      final coup = couponModelFromJson(response.body);

      return coup;
    } catch (e) {
      return e;
    }
  }

  static Future<BannerAd> bannerAD() async {
    try {
      var response = await http
          .get("https://www.incredibleman.in/wp-json/banner/v1/banner");

      final bannerAd = bannerAdFromJson(response.body);

      return bannerAd;
    } catch (e) {
      return e;
    }
  }

  static Future<List<ShippingModel>> shippingDatat() async {
    try {
      var response = await http.get(
          "https://www.incredibleman.in/wp-json/wc/v3/shipping/zones/1/methods?consumer_secret=cs_e0d2efcba59453a6883a91b0bbf241d699898151&consumer_key=ck_e9df4b7d747d2ccc30946837db4d3ef80b215535");

      final shippingModel = shippingModelFromJson(response.body);
      return shippingModel;
    } catch (e) {
      print(e);
      return e;
    }
  }

  favList(List<WooProduct> dd) {
    lodgin(true);
    mainloding(true);
    var favdata = Hive.box(FavList).values.toList().obs;
    print(favdata);
    favlist1 = dd.where((element) => favdata.contains(element.id)).toList().obs;

    favTotal(favlist1.length);
    fav();
    lodgin(false);
    mainloding(false);
  }

  void isSave(key) {
    lodgin(true);
    mainloding(true);
    if (Hive.box(FavList).containsKey(key).obs.value) {
      isfav(true).obs;
    } else {
      isfav(false).obs;
    }

    lodgin(false);
    mainloding(false);
  }

  void favRemove(product) {
    Hive.box(FavList).delete(product).obs;
    fav();
  }

  void addFav(key, value) {
    Hive.box(FavList).put(key, value).obs;
    fav();
  }

  void addTest(key, value) {
    Hive.box(TestBox).put(key, value);
    cartitme1();
  }

  static Future<bool> userlogin() async {
    loginornot = await woocommerce.isCustomerLoggedIn();

    return loginornot;
  }

/////////////////////////////////////////////////////////////////
  ///

  cartitme1() {
    cr(true);
    var dd = Hive.box(TestBox).length;
    cartitem(dd);
    cr(false);
  }

  // void fetchdata(List<WooProduct> dd) {
  //   lodgin1(true);

  //   var cartdata = Hive.box(Cart_Items).values.toList().obs;
  //   print(cartdata);

  //   cartdata2 =
  //       dd.where((element) => cartdata.contains(element.id)).toList().obs;

  //   // var hmm = cartdata2.fold(
  //   //     0,
  //   //     (sum, element) =>
  //   //         sum + double.parse(element.price).toPrecision(0).toInt());

  //   // total(hmm);

  //   print(" aa getX nu che : ${cartdata2.length}");

  //   lodgin1(false);
  // }

  void testData() {
    lodgin1(true);
    tcart = Hive.box(TestBox).values.toList().cast<CartBox>().obs;
    var hehe = tcart
        .map((element) => double.parse(element.price) * element.quntity)
        .fold(0, (p, element) => p + element);
    print(hehe.runtimeType);
    testTotal(hehe.toString());

    print("aaa test nu totel che $hehe");
    lodgin1(false);
  }

  void sampleDatacheck() {
    lodgin1(true);
    var del = tcart.where((element) => element.sample == false).toList();
    print("xxx jo aa ${del.toList()}");
    if (del.length != 0) {
      if (double.parse(testTotal.value) <= 700.0 && del.length != null) {
        if (del != null) {
          for (var i = 0; i < del.length; i++) {
            remove(del[i].id);
            cartitme1();
          }
        }
      } else if (double.parse(testTotal.value) <= 1200.0 &&
          del.length >= 2 &&
          double.parse(testTotal.value) >= 700.0) {
        print("XXX under ${del.length}");
        if (del != null) {
          remove(del[0].id);
          cartitme1();
        }
      }
    }

    lodgin1(false);
  }

  remove(product) {
    Hive.box(TestBox).delete(product).obs;
    cartitem(tcart.length);
    cartitme1();
  }

  cartAdd(key, value) {
    Hive.box(TestBox).put(key, value).obs;
    cartitem(tcart.length);
    cartitme1();
  }

///////////////////////////////////////////////////////////////////////////////
  // static Future review() async {
  //   await woocommerce.getProductReviewById(reviewId: reviewId)
  // }
}

class TabNavigationItem {
  final Widget page;
  final String title;
  final Widget icon;
  final Widget activeIcon;

  TabNavigationItem(
      {@required this.page,
      @required this.title,
      @required this.icon,
      @required this.activeIcon});

  static List<TabNavigationItem> get items => [
        TabNavigationItem(
          page: Home(),
          title: 'Home',
          icon: Image.asset(
            hometab,
            scale: 2.5,
          ),
          activeIcon: Image.asset(
            homeSelected,
            scale: 2.5,
          ),
        ),
        TabNavigationItem(
          page: ImcomboScreen(),
          title: 'IM Combo',
          icon: Image.asset(
            im,
            scale: 5,
          ),
          activeIcon: Image.asset(
            imtabse,
            scale: 5,
          ),
        ),
        TabNavigationItem(
          page: BagScreen(),
          title: 'Orders',
          icon: Image.asset(
            order,
            scale: 2.5,
          ),
          activeIcon: Image.asset(
            orderSelected,
            scale: 2.5,
          ),
        ),
        TabNavigationItem(
          page: Account(),
          title: 'Account',
          icon: Image.asset(
            account,
            scale: 2.5,
          ),
          activeIcon: Image.asset(
            accountSelected,
            scale: 2.5,
          ),
        ),
      ];
}
