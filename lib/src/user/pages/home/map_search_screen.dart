// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mapmyindia_gl/mapmyindia_gl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:ride_hailer/src/user/constants/api_key.dart';
import 'package:ride_hailer/src/user/data/singleton.dart';
import 'package:ride_hailer/src/user/pages/home/search_screen.dart';
import 'package:ride_hailer/src/user/utilities/localstore/token_pref.dart';
import 'package:ride_hailer/src/user/utilities/localstore/user_details.dart';

class MapSearchScreen extends StatefulWidget {
  MapSearchScreen(
      {Key? key,
      this.currentLat,
      this.currentLoc,
      this.currentLong,
      this.togoLat,
      this.togoLoc,
      this.togoLong})
      : super(key: key);
  String? currentLoc;
  String? currentLat;
  String? currentLong;
  String? togoLoc;
  String? togoLat;
  String? togoLong;

  @override
  State<MapSearchScreen> createState() => _MapSearchScreenState();
}

class _MapSearchScreenState extends State<MapSearchScreen> {
  static const List<String> _kOptions = <String>[
    'aardvark',
    'bobcat',
    'chameleon',
  ];
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  late MapmyIndiaMapController mmc;
  double mapZoom = 14.0;
  double bangLat = 12.9587464;
  double bangLong = 77.5573456;
  final userTokenStore = UserTokenStore.getInstance();
  final TokenStore tokenStore = TokenStore.getInstance();
  String name = "";
  String email = "";
  String userType = "";
  String accessToken = "";

  Future<void> initMapDrawings() async {}

  void initParams() {}

  void initMapMyIndia() {
    MapmyIndiaAccountManager.setMapSDKKey(ApiKey.REST_API_KEY);
    MapmyIndiaAccountManager.setRestAPIKey(ApiKey.REST_API_KEY);
    MapmyIndiaAccountManager.setAtlasClientId(ApiKey.ATLAS_CLIENT_ID);
    MapmyIndiaAccountManager.setAtlasClientSecret(ApiKey.ATLAS_CLIENT_SECRET);
  }

  void configureDestination() {
    if (Singleton().togoLat != "" && Singleton().togoLong != "") {
      setState(() {
        bangLat = Singleton().togoLat as double;
        bangLong = Singleton().togoLong as double;
        mapZoom = 20.0;
      });
    }
  }

  void fetchedLoggedInUser() {
    if (userTokenStore.getDeviceToken() != null &&
        userTokenStore.getDeviceToken() != "") {
      setState(() {
        name = userTokenStore.getUserName()!;
        email = userTokenStore.getCurrentUserEmail()!;
        userType = userTokenStore.getCurrentUserType()!;
        accessToken = userTokenStore.getDeviceToken()!;
      });
    }
  }

  @override
  void initState() {
    initMapMyIndia();
    initMapDrawings();
    fetchedLoggedInUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Drawer(child: drawerWidget()),
        key: _scaffoldKey,
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Container(
              height: MediaQuery.of(context).size.height,
              //  color: Colors.yellow,
              child: Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.6,
                    // margin: const EdgeInsets.all(10),
                    color: Colors.black,
                    child: mapMyIndiaWidget(),
                  ),
                  Container(
                    // margin: const EdgeInsets.all(5),
                    //  color: Colors.blue,
                    height: MediaQuery.of(context).size.height * 0.4,
                    child: plainTextFields(),
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  Container drawerWidget() {
    return Container(
      child: ListView(
        children: [
          Container(
            height: 170,
            color: Colors.yellow,
            child: SizedBox(
              width: 60,
              height: 60,
              child: navItem(
                  icon: Icons.person,
                  iconBackground: Colors.green,
                  title: "Rahul KS"),
            ),
          ),
          const Divider(),
          navItem(
              icon: Icons.paid,
              iconBackground: Colors.purple,
              title: "Local-Send Items"),
          navItem(
              icon: Icons.card_membership,
              iconBackground: Colors.blue,
              title: "Payment"),
          navItem(
              icon: Icons.history,
              iconBackground: Colors.grey,
              title: "My Rides"),
          navItem(
              icon: Icons.card_giftcard,
              iconBackground: Colors.orange,
              title: "Refer and Earn"),
          navItem(
              icon: Icons.monitor,
              iconBackground: Colors.cyan,
              title: "Power Pass"),
          navItem(
              icon: Icons.notifications,
              iconBackground: Colors.pink,
              title: "Notifications"),
          navItem(
              icon: Icons.privacy_tip,
              iconBackground: Colors.green,
              title: "Claims"),
          navItem(
              icon: Icons.settings,
              iconBackground: Colors.blue,
              title: "Settings"),
          navItem(
              icon: Icons.sports_basketball,
              iconBackground: Colors.deepOrange,
              title: "Support"),
        ],
      ),
    );
  }

  Container drawerHeaderWidget() {
    return Container(
      height: 170,
      child: Container(
          color: Colors.pink,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                  width: 60,
                  height: 60,
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(48)),
                      color: Colors.lightGreen),
                  child: const Icon(
                    Icons.account_box,
                    color: Colors.white,
                  )),
              const SizedBox(width: 20),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(name,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey[600],
                        fontWeight: FontWeight.bold,
                      )),
                  Text(email,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      )),
                ],
              )
            ],
          )),
    );
  }

  Widget navItem(
      {required IconData icon,
      required String title,
      required Color iconBackground}) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(48)),
                  color: iconBackground),
              child: Icon(
                icon,
                color: Colors.white,
              )),
          const SizedBox(width: 20),
          Text(title,
              style: TextStyle(
                fontSize: 15,
                color: Colors.grey[600],
                fontWeight: FontWeight.bold,
              )),
        ],
      ),
    );
  }

  Widget plainTextFields() {
    return Material(
      borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16), topRight: Radius.circular(16)),
      elevation: 10,
      child: Container(
        color: Colors.yellow,
        height: 200,
        margin: const EdgeInsets.all(5),
        padding: const EdgeInsets.all(5),
        alignment: Alignment.center,
        child: Column(
          children: [
            textFieldWidget(
              prefixColor: Colors.green,
              initialValue: Singleton().currentLoc! == ""
                  ? "Your Current Location"
                  : Singleton().currentLoc!,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SearchScreen(
                            isCurrentLoc: true,
                          )),
                );
              },
            ),
            textFieldWidget(
              prefixColor: Colors.red,
              initialValue: Singleton().togoLoc == ""
                  ? "Enter Destination"
                  : Singleton().togoLoc,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SearchScreen(
                            isCurrentLoc: false,
                          )),
                );
              },
            ),
            const SizedBox(height: 16),
            calculateFareButton()
          ],
        ),
      ),
    );
  }

  Widget calculateFareButton() {
    return Container(
      margin: const EdgeInsets.only(left: 7, right: 7, top: 7),
      width: MediaQuery.of(context).size.width,
      height: 50,
      child: ElevatedButton(
          onPressed: () {
            bottomSheet();
          },
          style: ButtonStyle(
              foregroundColor:
                  MaterialStateProperty.all<Color>(Colors.deepPurple[400]!),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24.0),
              ))),
          child: const Text(
            "Calulate Fare",
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.w500, color: Colors.white),
          )),
    );
  }

  Widget textFieldWidget(
      {required Color prefixColor,
      required String initialValue,
      Function()? onTap}) {
    return Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24.0),
        ),
        child: TextFormField(
            autofocus: false,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            decoration: InputDecoration(
                suffixIcon: const Icon(Icons.bookmark_border_outlined),
                prefix: Container(
                  margin: const EdgeInsets.only(left: 2, right: 10),
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(48)),
                      color: prefixColor),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(24.0),
                  ),
                  borderSide: BorderSide(color: Colors.grey, width: 0.0),
                ),
                enabledBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(24.0),
                  ),
                  borderSide: BorderSide(color: Colors.grey, width: 0.0),
                )),
            initialValue: initialValue,
            onTap: onTap));
  }

  void calculateFairValidation() {}

  Future bottomSheet() {
    return showMaterialModalBottomSheet(
      context: context,
      builder: (context) => IntrinsicHeight(
        child: Container(
            child: Column(
          children: [
            finalFairWidget(
              vehicleIcon: Icons.bike_scooter,
              vehicleName: "Bike",
              travelTime: "7 mins",
              finalPrice: "64",
              showHikedPrice: false,
            ),
            finalFairWidget(
                vehicleIcon: Icons.car_rental,
                vehicleName: "Car",
                travelTime: "17 mins",
                finalPrice: "74",
                showHikedPrice: true,
                hikedPrice: "119",
                containerColor: Colors.white),
            const Divider(),
            finalFairWidget(
                vehicleIcon: Icons.car_crash_outlined,
                vehicleName: "Auto",
                travelTime: "27 mins",
                finalPrice: "64",
                showHikedPrice: true,
                hikedPrice: "109",
                containerColor: Colors.white),
            const Divider(),
            payOptionsWidget(isPayment: false, availableCoupons: "10"),
            const Divider(),
            payOptionsWidget(isPayment: true, availableCoupons: "10"),
            const SizedBox(height: 30),
            bookBikeButton(context)
          ],
        )),
      ),
    );
  }

  Container bookBikeButton(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          border: Border.all(width: 1.0, color: Colors.grey),
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          color: Colors.yellow[700]),
      height: 70,
      child: const Text("Book Bike",
          style: TextStyle(
              fontSize: 18, color: Colors.black, fontWeight: FontWeight.w500)),
    );
  }

  Container payOptionsWidget(
      {required bool isPayment, String? availableCoupons}) {
    return Container(
      height: 70,
      color: Colors.white,
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                border: Border.all(width: 3.0, color: Colors.grey),
                borderRadius: const BorderRadius.all(Radius.circular(48)),
                color: isPayment ? Colors.green : Colors.black),
            child: Icon(
              isPayment ? Icons.currency_rupee : Icons.discount_outlined,
              color: isPayment ? Colors.white : Colors.yellow,
            )),
        Text(
            isPayment == false
                ? "$availableCoupons Coupons available"
                : "Choose Payment Method",
            style: const TextStyle(
                fontSize: 18,
                color: Colors.black,
                fontWeight: FontWeight.w500)),
        Visibility(
          visible: isPayment,
          child: const Icon(
            Icons.arrow_forward_sharp,
            color: Colors.grey,
          ),
        )
      ]),
    );
  }

  MapmyIndiaDirection drawPolylineOnMap() {
    return MapmyIndiaDirection(
        origin: LatLng(12.919877383124968, 77.60427008647855),
        destination: LatLng(12.947179321657432, 77.54554705300654));
  }

  Widget finalFairWidget(
      {required IconData vehicleIcon,
      required String vehicleName,
      required String travelTime,
      String? hikedPrice,
      required String finalPrice,
      bool showHikedPrice = false,
      Color? containerColor}) {
    return Container(
      color: containerColor ?? Colors.yellow[100],
      padding: const EdgeInsets.only(left: 15, right: 15),
      height: 90,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                border: Border.all(width: 3.0, color: Colors.grey),
                borderRadius: const BorderRadius.all(Radius.circular(48)),
                color: Colors.yellow),
            child: Icon(vehicleIcon),
          ),
          Row(
            children: [
              Text(vehicleName,
                  style: const TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.w500)),
              const SizedBox(width: 10),
              Text(travelTime,
                  style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                      fontWeight: FontWeight.w500))
            ],
          ),
          Row(
            children: [
              Visibility(
                visible: showHikedPrice == false ? false : true,
                child: Text("₹$hikedPrice" ?? "9889",
                    style: const TextStyle(
                        fontSize: 16,
                        decoration: TextDecoration.lineThrough,
                        color: Colors.black,
                        fontWeight: FontWeight.w500)),
              ),
              const SizedBox(width: 10),
              Text("₹$finalPrice",
                  style: const TextStyle(
                      fontSize: 19,
                      color: Colors.black,
                      fontWeight: FontWeight.w500)),
              const SizedBox(width: 8),
              const Icon(
                Icons.info_outline,
                color: Colors.grey,
              )
            ],
          )
        ],
      ),
    );
  }

  Future<void> addImageFromAsset(
      String name, String assetName, MapmyIndiaMapController mmp) async {
    final ByteData bytes = await rootBundle.load(assetName);
    final Uint8List list = bytes.buffer.asUint8List();
    return mmp.addImage(name, list);
  }

  Future<void> addMarkers(MapmyIndiaMapController map) async {
    await addImageFromAsset("icon1", "asset/icons/homemap.png", map);
    map.addSymbol(const SymbolOptions(
        geometry: LatLng(12.919877383124968, 77.60427008647855),
        iconImage: "icon1"));

    await addImageFromAsset("icon2", "asset/icons/officemap.png", map);
    map.addSymbol(const SymbolOptions(
        geometry: LatLng(12.947179321657432, 77.54554705300654),
        iconImage: "icon2"));
  }

  Widget mapMyIndiaWidget() {
    return Stack(children: [
      MapmyIndiaMap(
        zoomGesturesEnabled: true,
        compassEnabled: true,
        myLocationEnabled: true,
        tiltGesturesEnabled: true,
        scrollGesturesEnabled: true,
        initialCameraPosition: CameraPosition(
          target: LatLng(bangLat, bangLong),
          zoom: mapZoom,
        ),
        onMapCreated: (map) async => {
          // mmc = map,
          map.addLine(const LineOptions(geometry: [
            LatLng(12.919877383124968, 77.60427008647855),
            LatLng(12.947179321657432, 77.54554705300654)
          ], lineColor: "#2006c9", lineWidth: 5)),
          addMarkers(map)
        },
        onMapClick: (point, coordinates) {
          print("onMapClick : $coordinates");
        },
        onMapLongClick: (point, coordinates) {
          print("onMapLongClick : $coordinates");
        },
        onMapError: (code, message) {
          print("onMapError : $message");
        },
      ),
      drawerIconWidget(
          isDrawwer: true,
          onTap: () {
            _scaffoldKey.currentState!.openDrawer();
          }),
      drawerIconWidget(
        isDrawwer: false,
        onTap: () {
          setState(() {
            mapZoom = 14.0;
          });
        },
      )
    ]);
  }

  Widget drawerIconWidget(
      {required bool isDrawwer, required Function() onTap}) {
    return Align(
      alignment: isDrawwer ? Alignment.topLeft : Alignment.bottomRight,
      child: Container(
          padding: const EdgeInsets.all(8),
          margin: const EdgeInsets.all(20),
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(width: 1.0, color: Colors.grey),
              borderRadius: const BorderRadius.all(Radius.circular(48))),
          child: GestureDetector(
              onTap: onTap,
              child: Icon(isDrawwer ? Icons.menu : Icons.location_on))),
    );
  }
}
