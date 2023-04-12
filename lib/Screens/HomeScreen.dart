import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: const Color.fromRGBO(247, 246, 251, 1),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        toolbarOpacity: 0,
        titleSpacing: 16,
        toolbarHeight: double.tryParse('40'),
        title: const Text(
          "Hello Alexa",
          style: TextStyle(color: Color(0xFFffcccb)),
        ),
        actions: const [
          CircleAvatar(
            backgroundImage: NetworkImage(
                "https://images.unsplash.com/photo-1543269664-56d93c1b41a6?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80"),
          ),
          SizedBox(
            width: 16,
          )
        ],
      ),
      body: Text("Hello Alexa"),
    );
  }
}
