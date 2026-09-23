import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Пифтанкин Н. А. ПИбд-31'),
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
  final Color _color = Colors.orangeAccent;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: _color,
        title: Text(widget.title),
      ),
      body: const MyWidget(),
    );
  }
}

class _CardData {
  final String text;
  final IconData icon;
  final String? imageUrl;

  _CardData(
      this.text, {
        this.icon = Icons.home,
        this.imageUrl,
      });
}

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final data = [
      _CardData(
        'Дом',
        imageUrl:
        'https://m.terem-pro.ru/upload/iblock/27c/27cd22f5560e08e5e7e106370c0cdf8b.jpg',
      ),
      _CardData(
        'Квартира',
        imageUrl:
        'https://s0.rbk.ru/v6_top_pics/media/img/4/60/756113122114604.jpg',
      ),
    ];

    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: data.map((e) => _Card.fromData(e)).toList(),
        ),
      ),
    );
  }
}

class _Card extends StatelessWidget {
  final String text;
  final IconData icon;
  final String? imageUrl;

  const _Card(
      this.text, {
        this.icon = Icons.ac_unit_outlined,
        this.imageUrl,
      });

  factory _Card.fromData(_CardData data) => _Card(
    data.text,
    icon: data.icon,
    imageUrl: data.imageUrl,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white70,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey),
        boxShadow: [
          BoxShadow(
            color: Colors.redAccent,
            spreadRadius: 4,
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: SizedBox(
              height: 200,
              width: 200,
              child: Image.network(
                imageUrl ?? '',
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => const Placeholder(),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    text,
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Icon(icon),
          ),
        ],
      ),
    );
  }
}
