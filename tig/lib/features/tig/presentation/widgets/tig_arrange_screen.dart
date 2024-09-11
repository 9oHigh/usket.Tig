import 'package:flutter/material.dart';

class TigArrangeScreen extends StatefulWidget {
  const TigArrangeScreen({super.key});

  @override
  State<StatefulWidget> createState() => _TigArrangeScreenState();
}

class _TigArrangeScreenState extends State<TigArrangeScreen> {
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
