import 'package:flutter/material.dart';
import 'package:ride_hailer/src/user/pages/extra/login_screen.dart';

class UserTypeScreen extends StatelessWidget {
  const UserTypeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 244, 240, 240),
      body: SafeArea(
        child: parentLayout(context),
      ),
    );
  }

  Widget parentLayout(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Align(
          alignment: Alignment.center,
          child: Container(
            height: 300,
            // color: Color.fromARGB(255, 244, 240, 240),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Choose Your Role",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.w500)),
                    Container(
                        height: 30,
                        width: 30,
                        child: Image.asset("asset/icons/usertype.png")),
                  ],
                ),
                const SizedBox(height: 20),
                calculateFareButton(
                    buttonText: "I Am User",
                    context: context,
                    onTap: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginScreen()),
                        (route) {
                          return true;
                        },
                      );
                    },
                    buttonColor: Colors.deepPurple[400]!),
                const SizedBox(height: 7),
                calculateFareButton(
                    buttonText: "I Am Driver",
                    context: context,
                    onTap: () {},
                    buttonColor: Colors.white,
                    buttonTextColor: Colors.black)
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget calculateFareButton(
      {required BuildContext context,
      required Function() onTap,
      required Color buttonColor,
      required String buttonText,
      Color? buttonTextColor}) {
    return Container(
      margin: const EdgeInsets.only(left: 15, right: 15, top: 10),
      width: MediaQuery.of(context).size.width,
      height: 50,
      child: ElevatedButton(
          onPressed: () {
            onTap();
          },
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(buttonColor),
              // foregroundColor: MaterialStateProperty.all<Color>(Colors.yellow),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24.0),
              ))),
          child: Text(
            buttonText,
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: buttonTextColor ?? Colors.white),
          )),
    );
  }
}
