import 'package:flutter/material.dart';
import 'package:flutter_v4/sensor_data.dart';
// Packages
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter V4',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.indigo)),
      home: const MyHomePage(title: 'Profile page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final SharedPreferencesAsync sharedPref = SharedPreferencesAsync();
  String? _username;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUsername();
  }

  void _loadUsername() async {
    final storedUsername = await sharedPref.getString('username');

    // Preventing setState to be called on a page no longer in use, if the user changes viewing page while the async function is waiting for await result to finish
    if (!mounted) return;

    setState(() {
      _username = storedUsername;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(body: Center(child: Text("LOADING...")));
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: .center,
          children: [
            Text(
              'Welcome ${_username ?? 'Guest'}!',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            ElevatedButton(
              onPressed: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SensorData()),
                ),
              },
              child: Text("View Sensor Data"),
            ),
          ],
        ),
      ),
    );
  }
}
