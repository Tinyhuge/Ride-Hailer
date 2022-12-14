import 'package:flutter/material.dart';
import 'package:ride_hailer/src/user/pages/extra/chat.dart';
import 'package:ride_hailer/src/user/pages/extra/user_type_screen.dart';
import 'package:ride_hailer/src/user/pages/home/map_full_screen.dart';
import 'package:ride_hailer/src/user/pages/home/map_search_screen.dart';
import 'package:ride_hailer/src/user/utilities/localstore/token_pref.dart';
import 'package:ride_hailer/src/user/utilities/localstore/user_details.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final userTokenStore = UserTokenStore.getInstance();
  final TokenStore tokenStore = TokenStore.getInstance();
  @override
  void initState() {
    //dummySplashRedirection();
    setSplashTimeout();
    super.initState();
  }

  void dummySplashRedirection() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => ChatScreen()));
    });
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (context) => const ChatScreen()),
    // );
  }

  void setSplashTimeout() {
    Future.delayed(
      const Duration(seconds: 3),
      () {
        if (tokenStore.getAuthToken() != null &&
            tokenStore.getAuthToken() != "") {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => MapSearchScreen()),
            (route) {
              return true;
            },
          );
        }
        {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const UserTypeScreen()),
            (route) {
              return true;
            },
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 244, 240, 240),
      body: SafeArea(
        child: Stack(
          children: const [
            footerWidget(),
            logoWidget(),
          ],
        ),
      ),
    );
  }
}

class logoWidget extends StatelessWidget {
  const logoWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        height: 200,
        // color: Colors.yellow,
        child: Column(
          children: [
            Container(
                width: 100,
                height: 80,
                child: Image.asset("asset/icons/taxi.png")),
            const SizedBox(height: 10),
            const Text("Techie Rider",
                style: TextStyle(
                    fontSize: 23,
                    color: Colors.black,
                    fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }
}

class footerWidget extends StatelessWidget {
  const footerWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 40,
        width: 300,
        // color: Colors.blueAccent,

        child: const Text("Powered By TechieAid Technologies Pvt Ltd",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 14, color: Colors.grey, fontWeight: FontWeight.w500)),
      ),
    );
  }
}
