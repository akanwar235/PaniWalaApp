import 'package:flutter/material.dart';

class ChooseLocationPage extends StatefulWidget {
  const ChooseLocationPage({super.key});

  @override
  State<StatefulWidget> createState() => _ChooseLocationPageState();
}

class _ChooseLocationPageState extends State<ChooseLocationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Select Location"),
      ),
      body: Center(
        child: Row(
          children: [
            const Spacer(),
            ElevatedButton(
              onPressed: () {},
              child: const Text("Select Automatically"),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {},
              child: const Text("Select on Map"),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
