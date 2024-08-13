import 'package:artifactsmmo_app/actions.dart';
import 'package:artifactsmmo_app/loops.dart';
import 'package:flutter/material.dart';
import 'package:global_configuration/global_configuration.dart';
import 'assets/app_settings.config.dart';

void main() async {
  GlobalConfiguration().loadFromMap(config);
  runApp(const ArtifactsmmoApp());
}

class ArtifactsmmoApp extends StatelessWidget {
  const ArtifactsmmoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Artifacts MMO App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(title: 'Artifacts MMO Home Page'),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: gatherLoop,
              child: Text("Gather"),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: fightLoop,
              child: Text("Fight"),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: levelCooking,
              child: Text("Level Cooking"),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: sellAllFish,
              child: Text("Sell All Fish Test"),
            ),
          ],
        ),
      ),
    );
  }
}
