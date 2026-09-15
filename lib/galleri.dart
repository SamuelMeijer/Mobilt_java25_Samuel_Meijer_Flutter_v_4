import 'package:flutter/material.dart';

class Galleri extends StatefulWidget {
  const new({super.key});

  @override
  State<Galleri> createState() => _GalleriState();
}

class _GalleriState extends State<Galleri> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("Galleri"),
      ),

      body: Placeholder()
    ); 
  }
}