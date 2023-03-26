import 'package:flutter/material.dart';

void main() {
  runApp(const CardExamplesApp2());
}

class CardExamplesApp2 extends StatelessWidget {
  const CardExamplesApp2({super.key});
  
 

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          colorSchemeSeed: Color.fromARGB(255, 47, 120, 75), useMaterial3: true),
      home: Scaffold(
        appBar: AppBar(title: const Text('Alpines')),
        body: Column(
          children: const <Widget>[
            Spacer(),
            ElevatedCardExample(),
            FilledCardExample(),
            OutlinedCardExample(),
            Spacer(),
          ],
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


class ElevatedCardExample extends StatelessWidget {
  const ElevatedCardExample({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Card(
        child: SizedBox(
          width: 400,
          height: 200,
          child: Center(child: Text('Alpines are small and highly collectable plants, producing exquisite little flowers in a range of vibrant hues. As they come from mountainous regions, .')),
        ),
      ),
    );
  }
  
}


class FilledCardExample extends StatelessWidget {
  const FilledCardExample({super.key});

 @override
  Widget build(BuildContext context) {
    return const Center(
      child: Card(
        child: SizedBox(
          width: 400,
          height: 200,
          child: Center(child: Text('Most alpines like dry, sunny conditions, so are happy in containers, rock gardens, gravel gardens and raised beds. They prefer a mulch of grit or gravel on the soil surface, so their foliage doesn’t rest on damp ground. ')),
        ),
      ),
    );
  }
}

class OutlinedCardExample extends StatelessWidget {
  const OutlinedCardExample({super.key});

 @override
  Widget build(BuildContext context) {
    return const Center(
      child: Card(
        child: SizedBox(
          width: 400,
          height: 200,
          child: Center(child: Text(' Alpines won’t survive in consistently damp conditions, so give them free-draining soil or compost. If growing in a container, make sure there are plenty of drainage holes,')),
        ),
      ),
      
    );
  }
}
