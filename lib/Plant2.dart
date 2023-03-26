import 'package:flutter/material.dart';

import 'Tree.dart';

class Plant2 {
  const Plant2({required this.name});

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
  runApp(const IssueDemoApp2());
}

class IssueDemoApp2 extends StatefulWidget {
  const IssueDemoApp2({super.key});

  @override
  State<IssueDemoApp2> createState() => _IssueDemoAppState2();
}

class _IssueDemoAppState2 extends State<IssueDemoApp2> {
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
          // Add a ListView to the drawer. This ensures the user can scroll
          // through the options in the drawer if there isn't enough vertical
          // space to fit everything.
          child: ListView(
            // Important: Remove any padding from the ListView.
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
                  Navigator.pop(context);
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

/// Draw a number of boxes showing the colors of key theme color properties
///
/// Draw a number of boxes showing the colors of key theme color properties
/// in the ColorScheme of the inherited ThemeData and its color properties.

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
          tag: '؛plants',
          // Wrap the ListTile in a Material widget so the ListTile has someplace
          // to draw the animated colors during the hero transition.
          child: Material(
            child: ListTile(
              title: const Text('Aquatic'),
              subtitle:
                  const Text('Click for more information about the plant'),
              tileColor:Color.fromARGB(255, 227, 237, 230),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute<Widget>(builder: (BuildContext context) {
                    return Scaffold(
                      appBar: AppBar(title: const Text('Aquatic')),
                      body: Center(
                        child: Hero(
                          tag: 'ListTile-Hero',
                          child: Material(
                            child: ListTile(
                              title: const Text('No pond should be without plants – they bring it to life, add colour and interest, help to hide the liner, and attract wildlife of all kinds. Whether growing in the water itself, or around the damp margins, these often bold and beautiful plants can turn your pond into the star feature of your garden.Aquatic plants like to grow permanently in water, and many are quite specific about the depth of water they need. Some enjoy a lot of space, others are more compact, and they usually like plenty of sun '),
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
          // Wrap the ListTile in a Material widget so the ListTile has someplace
          // to draw the animated colors during the hero transition.
          child: Material(
            child: ListTile(
              title: const Text('Alpines'),
              subtitle: const Text('Tap here for Hero transition'),
              tileColor:Color.fromARGB(255, 227, 237, 230),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute<Widget>(builder: (BuildContext context) {
                    return Scaffold(
                      appBar: AppBar(title: const Text('Alpines')),
                      body: Center(
                        child: Hero(
                          tag: 'ListTile-Hero',
                          child: Material(
                            child: ListTile(
                              title: const Text('Alpines are small and highly collectable plants, producing exquisite little flowers in a range of vibrant hues. As they come from mountainous regions,Alpines won’t survive in consistently damp conditions, so give them free-draining soil or compost. If growing in a container, make sure there are plenty of drainage holes,'),
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
              title: const Text('Bulbs'),
              subtitle: const Text('Tap here for Hero transition'),
              tileColor:Color.fromARGB(255, 227, 237, 230),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute<Widget>(builder: (BuildContext context) {
                    return Scaffold(
                      appBar: AppBar(title: const Text('Bulbs')),
                      body: Center(
                        child: Hero(
                          tag: 'ListTile-Hero',
                          child: Material(
                            child: ListTile(
                              title: const Text('Bulbs bring spectacular colour to gardens across the seasons, but especially in spring. From cheery daffodils to elegant tulips, blowsy gladioli to demure snowdrops, there are bulbs for all styles and growing conditions. A container of miniature bulbs will brighten up even the smallest space, while some dramatic dahlias or cannas will make a big splash in even the grandest of borders.'),
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
 Hero(
          tag: 'ListTile-Hero',
         
          child: Material(
            child: ListTile(
              title: const Text('Cacti and succulents'),
              subtitle: const Text('Tap here for Hero transition'),
              tileColor:Color.fromARGB(255, 227, 237, 230),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute<Widget>(builder: (BuildContext context) {
                    return Scaffold(
                      appBar: AppBar(title: const Text(' Cacti and succulents')),
                      body: Center(
                        child: Hero(
                          tag: 'ListTile-Hero',
                          child: Material(
                            child: ListTile(
                              title: const Text('Low maintenance and drought tolerant, cacti and succulents make attractive and easy-to-grow houseplants. A few can also be grown outdoors in sunny, well-drained conditions. Readily available in great diversity, these often inexpensive plants are fascinating and highly collectable.'),
                              subtitle: const Text('Cacti and succulents generally like low moisture, dry air, good drainage and high temperatures. However, some do grow well in semi-shade and humid conditions.'),
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
///////////5
 Hero(
          tag: 'ListTile-Hero',
          // Wrap the ListTile in a Material widget so the ListTile has someplace
          // to draw the animated colors during the hero transition.
          child: Material(
            child: ListTile(
              title: const Text('Climbing plants'),
              subtitle: const Text('Tap here for Hero transition'),
              tileColor:Color.fromARGB(255, 227, 237, 230),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute<Widget>(builder: (BuildContext context) {
                    return Scaffold(
                      appBar: AppBar(title: const Text('Climbing plants')),
                      body: Center(
                        child: Hero(
                          tag: 'ListTile-Hero',
                          child: Material(
                            child: ListTile(
                              title: const Text('Climbers and wall shrubs are a brilliant way to liven up dull walls, fences, obelisks and supports throughout the garden, especially when planting space is limited. There are many different types to suit all locations, and they provide shelter and food for wildlife too.'),
                              subtitle: const Text('Climbers love to grow upwards, and like sturdy supports to help them on their way. Wall shrubs are happy to be trained and pruned closely against a wall. There are planting options for every type of soil and growing location. '),
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
/////////6
Hero(
          tag: 'ListTile-Hero',
          // Wrap the ListTile in a Material widget so the ListTile has someplace
          // to draw the animated colors during the hero transition.
          child: Material(
            child: ListTile(
              title: const Text('Houseplants'),
              subtitle: const Text('Tap here for Hero transition'),
              tileColor:Color.fromARGB(255, 227, 237, 230),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute<Widget>(builder: (BuildContext context) {
                    return Scaffold(
                      appBar: AppBar(title: const Text('Houseplants')),
                      body: Center(
                        child: Hero(
                          tag: 'ListTile-Hero',
                          child: Material(
                            child: ListTile(
                              title: const Text('Climbers and wall shrubs are a brilliant way to liven up dull walls, fences, obelisks and supports throughout the garden, especially when planting space is limited. There are many different types to suit all locations, and they provide shelter and food for wildlife too.'),
                              subtitle: const Text('Climbers love to grow upwards, and like sturdy supports to help them on their way. Wall shrubs are happy to be trained and pruned closely against a wall. There are planting options for every type of soil and growing location. '),
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
///////7

Hero(
          tag: 'ListTile-Hero',
          // Wrap the ListTile in a Material widget so the ListTile has someplace
          // to draw the animated colors during the hero transition.
          child: Material(
            child: ListTile(
              title: const Text('Perennials'),
              subtitle: const Text('Tap here for Hero transition'),
              tileColor:Color.fromARGB(255, 227, 237, 230),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute<Widget>(builder: (BuildContext context) {
                    return Scaffold(
                      appBar: AppBar(title: const Text('Perennials')),
                      body: Center(
                        child: Hero(
                          tag: 'ListTile-Hero',
                          child: Material(
                            child: ListTile(
                              title: const Text('Climbers and wall shrubs are a brilliant way to liven up dull walls, fences, obelisks and supports throughout the garden, especially when planting space is limited. There are many different types to suit all locations, and they provide shelter and food for wildlife too.'),
                              subtitle: const Text('Climbers love to grow upwards, and like sturdy supports to help them on their way. Wall shrubs are happy to be trained and pruned closely against a wall. There are planting options for every type of soil and growing location. '),
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
        /////8
        Hero(
          tag: 'ListTile-Hero',
          // Wrap the ListTile in a Material widget so the ListTile has someplace
          // to draw the animated colors during the hero transition.
          child: Material(
            child: ListTile(
              title: const Text('Shrubs'),
              subtitle: const Text('Tap here for Hero transition'),
              tileColor:Color.fromARGB(255, 227, 237, 230),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute<Widget>(builder: (BuildContext context) {
                    return Scaffold(
                      appBar: AppBar(title: const Text('Shrubs')),
                      body: Center(
                        child: Hero(
                          tag: 'ListTile-Hero',
                          child: Material(
                            child: ListTile(
                              title: const Text('Climbers and wall shrubs are a brilliant way to liven up dull walls, fences, obelisks and supports throughout the garden, especially when planting space is limited. There are many different types to suit all locations, and they provide shelter and food for wildlife too.'),
                              subtitle: const Text('Climbers love to grow upwards, and like sturdy supports to help them on their way. Wall shrubs are happy to be trained and pruned closely against a wall. There are planting options for every type of soil and growing location. '),
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
        //////////9
        Hero(
          tag: 'ListTile-Hero',
          // Wrap the ListTile in a Material widget so the ListTile has someplace
          // to draw the animated colors during the hero transition.
          child: Material(
            child: ListTile(
              title: const Text('Hedges'),
              subtitle: const Text('Tap here for Hero transition'),
              tileColor:Color.fromARGB(255, 227, 237, 230),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute<Widget>(builder: (BuildContext context) {
                    return Scaffold(
                      appBar: AppBar(title: const Text('Hedges')),
                      body: Center(
                        child: Hero(
                          tag: 'ListTile-Hero',
                          child: Material(
                            child: ListTile(
                              title: const Text('Climbers and wall shrubs are a brilliant way to liven up dull walls, fences, obelisks and supports throughout the garden, especially when planting space is limited. There are many different types to suit all locations, and they provide shelter and food for wildlife too.'),
                              subtitle: const Text('Climbers love to grow upwards, and like sturdy supports to help them on their way. Wall shrubs are happy to be trained and pruned closely against a wall. There are planting options for every type of soil and growing location. '),
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
      ],
    );
  }
}
