import 'package:flutter/material.dart';

class HomeArrangeScreen extends StatefulWidget {
  const HomeArrangeScreen({super.key});

  @override
  State<StatefulWidget> createState() => _HomeArrangeScreenState();
}

class _HomeArrangeScreenState extends State<HomeArrangeScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back)),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Arrange Screen'),
            ],
          ),
        ],
      ),
    );
  }
}
