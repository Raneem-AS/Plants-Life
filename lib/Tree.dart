import 'package:flutter/material.dart';

import 'Plant2.dart';

class Tree {
  const Tree({required this.name});

  final String name;
}

enum ThemeType {
  defaultFactory,
  themeDataFrom,
  themeDataColorSchemeSeed,
}

const Color seedColor = Color(0xff386a20);

ThemeData demoTheme(Brightness mode, bool useMaterial3, ThemeType type) {
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
  runApp(const IssueDemoApp3());
}

class IssueDemoApp3 extends StatefulWidget {
  const IssueDemoApp3({super.key});

  @override
  State<IssueDemoApp3> createState() => _IssueDemoAppState3();
}

class _IssueDemoAppState3 extends State<IssueDemoApp3> {
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
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
       title: 'IssueDemoApp',
      
      initialRoute: '/',
      routes: {
        '/second': (context) => const IssueDemoApp2(),
      
      },
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
        const SizedBox(height: 16),
        const LisTileExample(),
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



class LisTileExample extends StatefulWidget {
  const LisTileExample({super.key});

  @override
  State<LisTileExample> createState() => _LisTileExampleState();
}

class _LisTileExampleState extends State<LisTileExample>
    with TickerProviderStateMixin {
  late final AnimationController _fadeController;
  late final AnimationController _sizeController;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat(reverse: true);

    _sizeController = AnimationController(
      duration: const Duration(milliseconds: 850),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _sizeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Hero(
          tag: 'Tree',
         
          child: Material(
            child: ListTile(
              title: const Text('Evergreen trees'),
              subtitle:
                  const Text('Click for more information about the plant'),
              tileColor:Color.fromARGB(255, 227, 237, 230),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute<Widget>(builder: (BuildContext context) {
                    return Scaffold(
                      appBar: AppBar(title: const Text('Evergreen trees')),
                      body: Center(
                        child: Hero(
                          tag: 'Evergreen trees',
                          child: Material(
                            child: ListTile(
                              title: const Text('These trees carry leaves all year round and are a bold, permanent presence in a garden. They’re great for creating privacy and shelter, and cope in a range of soil types and situations. They are particularly valuable in winter, providing a green highlight when most other plants have died back or are reduced to bare stems.'),
                              subtitle: const Text('x'),
                              tileColor: Color.fromARGB(255, 227, 237, 230),
                              onTap: () {
                                Navigator.pop(context);
                              },
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                );
              },
            ),
          ),
        ),
        //////2
        Hero(
          tag: 'ListTile-Hero',
        
          child: Material(
            child: ListTile(
              title: const Text('Deciduous trees'),
              subtitle: const Text('Tap here for Hero transition'),
              tileColor:Color.fromARGB(255, 227, 237, 230),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute<Widget>(builder: (BuildContext context) {
                    return Scaffold(
                      appBar: AppBar(title: const Text('Deciduous trees')),
                      body: Center(
                        child: Hero(
                          tag: 'ListTile-Hero',
                          child: Material(
                            child: ListTile(
                              title: const Text('In autumn these trees lose their leaves, which often take on spectacular fiery hues before they fall, then sprout new ones in spring. Deciduous trees are a valuable permanent feature in a garden, and mark the changing seasons with flowers, fruits, new foliage, autumn colour or bare branches. By dropping their leaves in winter, they often reveal attractive bark and a bold branch structure, as well as letting in valuable additional light to a garden, enabling many early spring-flowering plants to thrive beneath them.'),
                              subtitle: const Text('Most alpines like dry, sunny conditions, so are happy in containers, rock gardens, gravel gardens and raised beds. They prefer a mulch of grit or gravel on the soil surface, so their foliage doesn’t rest on damp ground.'),
                              tileColor:Color.fromARGB(255, 227, 237, 230),
                              onTap: () {
                                Navigator.pop(context);
                              },
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                );
              },
            ),
          ),
        ),
//////3
 Hero(
          tag: 'ListTile-Hero',
          child: Material(
            child: ListTile(
              title: const Text('Fruit trees'),
              subtitle: const Text('Tap here for Hero transition'),
              tileColor:Color.fromARGB(255, 227, 237, 230),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute<Widget>(builder: (BuildContext context) {
                    return Scaffold(
                      appBar: AppBar(title: const Text('Fruit trees')),
                      body: Center(
                        child: Hero(
                          tag: 'ListTile-Hero',
                          child: Material(
                            child: ListTile(
                              title: const Text('From apples and plums to figs and oranges, many trees produce delicious fruits in summer and autumn. Compact forms are usually available, making them suitable for even the smallest gardens. Many fruit trees also produce pretty blossom, and some offer colourful foliage in autumn too.'),
                              subtitle: const Text('Planted when dormant, bulbs may look unassuming, but after just a few months they’ll reward you with exquisite flowers. It includes a wide range of flower shapes, colours and sizes as this is a large and diverse group.'),
                              tileColor: Color.fromARGB(255, 227, 237, 230),
                              onTap: () {
                                Navigator.pop(context);
                              },
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                );
              },
            ),
          ),
        ),
////////4
 
      ],
    );
  }
}