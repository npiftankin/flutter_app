import 'package:flutter/material.dart';

class DetailsPage extends StatelessWidget {
  final String text;
  final String descriptionText;
  final String? imageUrl;
  final IconData icon;

  const DetailsPage({
    super.key,
    required this.text,
    required this.descriptionText,
    required this.imageUrl,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(text),
        backgroundColor: Colors.deepPurple,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 300,
              width: double.infinity,
              child: Image.network(
                imageUrl ?? '',
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) =>
                const Placeholder(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Icon(
                    icon,
                    size: 40,
                  ),
                  const SizedBox(width: 16),
                  Text(
                    text,
                    style:
                    Theme.of(context).textTheme.headlineLarge,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Text(
                descriptionText,
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}