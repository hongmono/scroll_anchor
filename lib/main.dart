import 'package:flutter/material.dart';
import 'package:scroll_anchor/scroll_anchor_mixin.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with ScrollAnchor {
  GlobalKey firstKey = GlobalKey();
  GlobalKey secondKey = GlobalKey();
  GlobalKey thirdKey = GlobalKey();

  @override
  void initState() {
    anchorKeys = [firstKey, secondKey, thirdKey];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        controller: scrollController,
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: Column(
              children: [
                ...List.generate(
                  100,
                  (index) => ListTile(
                    key: switch (index) {
                      30 => firstKey,
                      60 => secondKey,
                      90 => thirdKey,
                      _ => null,
                    },
                    title: Text('Item $index'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: scrollToNext,
            child: const Icon(Icons.navigate_next),
          ),
          const SizedBox(height: 8),
          FloatingActionButton(
            onPressed: scrollToPrevious,
            child: const Icon(Icons.navigate_before),
          ),
          const SizedBox(height: 8),
          FloatingActionButton(
            onPressed: scrollToTop,
            child: const Icon(Icons.arrow_upward),
          ),
        ],
      ),
    );
  }
}
