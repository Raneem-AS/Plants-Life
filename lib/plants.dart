import 'package:flutter/material.dart';

class Plants {
  const Plants({required this.name});

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
                
                Navigator.pop(context);
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
        const ShowColorSchemeColors(),
        const SizedBox(height: 16),
            

      ],
    );
  }
}

class BottomAppBarShowcase extends StatelessWidget {
  const BottomAppBarShowcase({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Row(
        children: <Widget>[
          const Spacer(),
          IconButton(
            tooltip: 'Search',
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}


/// Draw a number of boxes showing the colors of key theme color properties
///
/// Draw a number of boxes showing the colors of key theme color properties
/// in the ColorScheme of the inherited ThemeData and its color properties.
class ShowColorSchemeColors extends StatelessWidget {
  const ShowColorSchemeColors({super.key, this.onBackgroundColor});

  
  final Color? onBackgroundColor;

  static bool _isLight(final Color color) =>
      ThemeData.estimateBrightnessForColor(color) == Brightness.light;

  static Color _onColor(final Color color, final Color bg) =>
      _isLight(Color.alphaBlend(color, bg)) ? Colors.black : Colors.white;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;
    final bool useMaterial3 = theme.useMaterial3;

    ShapeBorder? border = theme.cardTheme.shape;
    if (border is RoundedRectangleBorder) {
      border = border.copyWith(
        side: BorderSide(
          color: theme.dividerColor,
          width: 1,
        ),
      );
      // 
    } else {
      border ??= RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(useMaterial3 ? 12 : 15)),
        side: BorderSide(
          color: theme.dividerColor,
          width: 1,
        ),
      );
    }

    // Get effective background color.
    final Color background =
        onBackgroundColor ?? theme.cardTheme.color ?? theme.cardColor;

    // Wrap this widget branch in a custom theme where card has a border outline
    // if it did not have one, but retains in ambient themed border radius.
    return Theme(
      data: Theme.of(context).copyWith(
        cardTheme: CardTheme.of(context).copyWith(
          elevation: 0,
          shape: border,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Text(
              'THE PLANTS',
              style: theme.textTheme.titleLarge,
            ),
          ),
          Wrap(
            alignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 40,
            runSpacing: 20,
            children: <Widget>[
              ColorCard(
                label: 'Alpines',
                color: colorScheme.outlineVariant,
                textColor: _onColor(colorScheme.outlineVariant, background),
              ),
              ColorCard(
                label: 'Aquatic and bog plants',
                color: colorScheme.outlineVariant,
                textColor: _onColor(colorScheme.outlineVariant, background),
              ),
              ColorCard(
                label: 'Bulbs',
                color: colorScheme.outlineVariant,
                textColor: _onColor(colorScheme.outlineVariant, background),
              ),
              ColorCard(
          
                label: 'Carnivorous plants',
                color: colorScheme.outlineVariant,
                textColor: _onColor(colorScheme.outlineVariant, background),
              ),
              ColorCard(
                label: 'Grasses',
                color: colorScheme.outlineVariant,
                textColor: _onColor(colorScheme.outlineVariant, background),
              ),
              ColorCard(
                label: 'Ferns',
                color: colorScheme.outlineVariant,
                textColor: _onColor(colorScheme.outlineVariant, background),
              ),
              ColorCard(
                label: 'Hedges',
                color: colorScheme.outlineVariant,
                textColor: _onColor(colorScheme.outlineVariant, background),
              ),
              ColorCard(
                label: 'Shrubs',
                color: colorScheme.outlineVariant,
                textColor: _onColor(colorScheme.outlineVariant, background),
              ),
              ColorCard(
                label: 'Perennials',
                color: colorScheme.outlineVariant,
                textColor: _onColor(colorScheme.outlineVariant, background),
              ),
              ColorCard(
                label: 'Climbing plants',
                color: colorScheme.outlineVariant,
                textColor: _onColor(colorScheme.outlineVariant, background),
              ),
              ColorCard(
                label: 'Cacti and succulents',
                color: colorScheme.outlineVariant,
                textColor: _onColor(colorScheme.outlineVariant, background),
              ),
              ColorCard(
                label: 'Carnivorous plants',
                color: colorScheme.outlineVariant,
                textColor: _onColor(colorScheme.outlineVariant, background),
              ),
              ColorCard(
                label: 'Houseplants',
                color: colorScheme.outlineVariant,
                textColor: _onColor(colorScheme.outlineVariant, background),
              ),
              
            ],
          ),
        ],
      ),
    );
  }
}

/// Some of the theme colors may have semi-transparent fill color. To compute
/// a legible text color for the sum when it shown on a background color, we
/// need to alpha merge it with background and we need the exact background

class ColorCard extends StatelessWidget {
  const ColorCard({
    super.key,
    required this.label,
    required this.color,
    required this.textColor,
    this.size,
  });

  final String label;
  final Color color;
  final Color textColor;
  final Size? size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250,
      height: 100,
      child: Card(
        margin: EdgeInsets.zero,
        clipBehavior: Clip.antiAlias,
        color: color,
        child: Center(
          child: Text(
            label,
            style: TextStyle(color: textColor, fontSize: 25),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}




