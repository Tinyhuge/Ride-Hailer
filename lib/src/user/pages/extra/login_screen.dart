// ignore_for_file: prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:ride_hailer/src/user/pages/extra/signup_screen.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key, required this.isDriver});

  bool isDriver;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 244, 240, 240),
        body: SafeArea(child: parentLayout(context)));
  }

  Widget parentLayout(BuildContext context) {
    return Center(
      child: Container(
          height: 400,
          margin: const EdgeInsets.only(left: 10, right: 10),
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              const SizedBox(height: 30),
              const Text("Login",
                  style: TextStyle(fontSize: 23, fontWeight: FontWeight.w600)),
              const SizedBox(height: 30),
              textFieldWidget(
                  hintText: "Email",
                  email: true,
                  prefixColor: Colors.yellow,
                  initialValue: "Email"),
              const SizedBox(height: 15),
              textFieldWidget(
                  hintText: "Password",
                  email: false,
                  prefixColor: Colors.yellow,
                  initialValue: "Password"),
              const SizedBox(height: 30),
              calculateFareButton(context),
              const SizedBox(height: 18),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't Have Account?",
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 15,
                          fontWeight: FontWeight.w600)),
                  const SizedBox(width: 7),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SignupScreen(
                                  isDriver: widget.isDriver,
                                )),
                        (route) {
                          return true;
                        },
                      );
                    },
                    child: const Text("Create Account",
                        style: TextStyle(
                            color: Colors.deepPurple,
                            fontSize: 15,
                            fontWeight: FontWeight.w600)),
                  ),
                ],
              )
            ],
          )),
    );
  }

  Widget calculateFareButton(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 7, right: 7, top: 7),
      width: MediaQuery.of(context).size.width,
      height: 50,
      child: ElevatedButton(
          onPressed: () {},
          style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all<Color>(Colors.deepPurple[400]!),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24.0),
              ))),
          child: const Text(
            "Login",
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.w500, color: Colors.white),
          )),
    );
  }

  Widget textFieldWidget(
      {required Color prefixColor,
      required String initialValue,
      required bool email,
      required String hintText,
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
                hintText: hintText,
                suffixIcon: const Icon(Icons.bookmark_border_outlined),
                prefixIcon:
                    email ? const Icon(Icons.person) : const Icon(Icons.lock),
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

  Widget iconWidget() {
    return Container(
        alignment: Alignment.center,
        // color: Colors.yellow,
        width: 100,
        height: 80,
        child: Image.asset("asset/icons/taxi.png"));
  }
}
