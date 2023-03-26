import 'package:flutter/material.dart';

void main() {
  runApp(const Aquatic());
}

class Aquatic extends StatelessWidget {
  const Aquatic({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          colorSchemeSeed: Color.fromARGB(255, 47, 120, 75),
          useMaterial3: true),
      home: Scaffold(
        appBar: AppBar(title: const Text('Aquatic')),
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
          child: Center(
              child: Text(
                  ' No pond should be without plants – they bring it to life, add colour and interest, help to hide the liner, and attract wildlife of all kinds. Whether growing in the water itself, or around the damp margins, these often bold and beautiful plants can turn your pond into the star feature of your garden.')),
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
          child: Center(
              child: Text(
                  'Aquatic plants like to grow permanently in water, and many are quite specific about the depth of water they need. Some enjoy a lot of space, others are more compact, and they usually like plenty of sun ')),
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
          child: Center(
              child: Text(
                  ' Many aquatics need a specific depth of water, so will struggle if planted outside their comfort zone. Some also dislike flowing water. Bog plants don’t tend to enjoy drying out, or spending long periods in standing water – most prefer something in between')),
       
        ),
      ),
    );
  }
}
