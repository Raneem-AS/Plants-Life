import 'package:flutter/material.dart';
import 'package:ran_a1/Plant2.dart';
import 'package:ran_a1/Tree.dart';

enum ThemeType {
  defaultFactory,
  themeDataFrom,
  themeDataColorSchemeSeed,
}

// A seed color for M3 ColorScheme.
const Color seedColor = Color(0xff386a20);

// Example themes
ThemeData demoTheme(Brightness mode, bool useMaterial3, ThemeType type) {
  // Make an M3 ColorScheme.from seed
  final ColorScheme scheme = ColorScheme.fromSeed(
    brightness: mode,
    seedColor: seedColor,
  );

  switch (type) {
    case ThemeType.defaultFactory:
      return ThemeData(
        colorScheme: scheme,
        useMaterial3: useMaterial3,
      );
    case ThemeType.themeDataFrom:
      return ThemeData.from(
        colorScheme: scheme,
        useMaterial3: useMaterial3,
      );
    case ThemeType.themeDataColorSchemeSeed:
      return ThemeData(
        brightness: mode,
        colorSchemeSeed: seedColor,
        useMaterial3: useMaterial3,
      );
  }
}

void main() {
  runApp(const IssueDemoApp());
}

class IssueDemoApp extends StatefulWidget {
  const IssueDemoApp({super.key});

  @override
  State<IssueDemoApp> createState() => _IssueDemoAppState();
}

class _IssueDemoAppState extends State<IssueDemoApp> {
  bool useMaterial3 = true;
  ThemeMode themeMode = ThemeMode.light;
  ThemeType themeType = ThemeType.themeDataFrom;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: themeMode,
      theme: demoTheme(Brightness.light, useMaterial3, themeType),
      darkTheme: demoTheme(Brightness.dark, useMaterial3, themeType),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plant Life'),
          actions: [
            IconButton(
              icon: useMaterial3
                  ? const Icon(Icons.filter_3)
                  : const Icon(Icons.filter_2),
              onPressed: () {
                setState(() {
                  useMaterial3 = !useMaterial3;
                });
              },
              tooltip: "Switch to Material ${useMaterial3 ? 2 : 3}",
            ),
            IconButton(
              icon: themeMode == ThemeMode.dark
                  ? const Icon(Icons.wb_sunny_outlined)
                  : const Icon(Icons.wb_sunny),
              onPressed: () {
                setState(() {
                  if (themeMode == ThemeMode.light) {
                    themeMode = ThemeMode.dark;
                  } else {
                    themeMode = ThemeMode.light;
                  }
                });
              },
              tooltip: "Toggle brightness",
            ),
          ],
        ),
        body: HomePage(
          themeType: themeType,
          onChanged: (ThemeType value) {
            setState(() {
              themeType = value;
            });
          },
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Color.fromARGB(0, 33, 243, 142),
                ),
                child: Text('what do you want ? '),
              ),
              ListTile(
                title: const Text(' plants'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => IssueDemoApp2()),
                  );
                },
              ),
              ListTile(
                title: const Text('Trees'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => IssueDemoApp3()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key, this.themeType, this.onChanged});
  final ThemeType? themeType;
  final ValueChanged<ThemeType>? onChanged;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      children: [
        const SizedBox(height: 8),
        Text(
          'We are PlantLife',
          style: theme.textTheme.headlineSmall,
        ),
        const SizedBox(height: 16),
        const SizedBox(height: 16),
        const Padding(
          padding: EdgeInsets.all(32.0),
          child: BottomAppBarShowcase(),
        ),
        const Padding(
          padding: EdgeInsets.all(32.0),
          child: MyApp(),
        )
      ],
    );
  }
}

class BottomAppBarShowcase extends StatelessWidget {
  const BottomAppBarShowcase({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Enter a search term',
            ),
          ),
        ),
      ],
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Colors.white),
      child: const Center(
        child: Text(
          'What we do?  As a charity, we want to inspire a passion for gardening and growing plants, promote the value of gardens demonstrate how gardening is good for us and explain the vital role that plants play',
          textDirection: TextDirection.ltr,
          style: TextStyle(
            fontSize: 32,
            color: Color.fromARGB(255, 121, 135, 126),
          ),
        ),
      ),
    );
  }
}
