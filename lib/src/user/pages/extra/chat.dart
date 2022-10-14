// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  main() {
    // Dart client
    IO.Socket socket = IO.io('http://192.168.0.102:5000');
    socket.onConnect((_) {
      print('connected to API Websocket');
      socket.emit('chat message', {"message": "mmmm", "nick": "usuus89"});
    });
    socket.on('new user', (data) => print(data));
    // socket.onDisconnect((_) => print('disconnect'));
    // socket.on('fromServer', (_) => print(_));
  }

  @override
  void initState() {
    // main();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
      //physics: const NeverScrollableScrollPhysics(),
      child: Container(
          color: Colors.pink,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.all(10),
                width: MediaQuery.of(context).size.width,
                height: 60,
                color: Colors.white,
                child: const Text("ChatRoom",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.black)),
              ),
              chatListView(),
              textFieldWidget(
                  prefixColor: Colors.yellow,
                  initialValue: "",
                  icon: Icons.chat_bubble,
                  inputType: TextInputType.multiline,
                  hintText: "Send a message...")
            ],
          )),
    )));
  }

  Container chatListView() {
    return Container(
        height: MediaQuery.of(context).size.height - 200,
        width: MediaQuery.of(context).size.width,
        child: ListView.builder(
          //physics: const NeverScrollableScrollPhysics(),
          itemCount: 25,
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            return chatWidget(context, index);
          },
        ));
  }

  Widget chatWidget(BuildContext context, int index) {
    return Container(
        height: 50,
        color: Colors.grey,
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(10),
        child: Text("My Message $index"));
  }

  Widget calculateFareButton(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 7, right: 7, top: 7),
      width: MediaQuery.of(context).size.width,
      height: 50,
      child: GestureDetector(
        onDoubleTap: () {},
        onLongPress: () {},
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
              "Create Account",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.white),
            )),
      ),
    );
  }

  Widget textFieldWidget(
      {required Color prefixColor,
      required String initialValue,
      required IconData icon,
      required TextInputType inputType,
      required String hintText,
      Function()? onTap,
      Function(String)? onTextChange}) {
    return Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24.0),
        ),
        child: TextFormField(
            onChanged: onTextChange,
            keyboardType: inputType,
            autofocus: false,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            decoration: InputDecoration(
                hintText: hintText,
                suffixIcon: const Icon(Icons.send),
                prefixIcon: Icon(icon),
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
}
