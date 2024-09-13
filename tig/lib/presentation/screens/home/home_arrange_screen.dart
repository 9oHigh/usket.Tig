import 'package:flutter/material.dart';

class HomeArrangeScreen extends StatefulWidget {
  const HomeArrangeScreen({super.key});

  @override
  State<StatefulWidget> createState() => _HomeArrangeScreen();
}

class _HomeArrangeScreen extends State<HomeArrangeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [],
        ),
      ),
    );
  }
}
