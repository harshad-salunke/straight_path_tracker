import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:straight_path_tracker/providers/location_provider.dart';
import 'package:straight_path_tracker/screens/straight_path_map.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Straight Path Tracker',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Straight Path Tracker'),
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


  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => LocationProvider()),

      ],
      child: MaterialApp(
        title: 'Straight Path Tracker',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            useMaterial3: true,
            scaffoldBackgroundColor: Color(0xfff7f7f7)
        ),
        home: StraightPathMapScreen(),
      ),
    );

  }
}
