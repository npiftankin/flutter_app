import 'package:flutter/material.dart';
import 'package:flutter_app/domain/models/card.dart';
import 'package:flutter_app/presentation/common/labels.dart';
import 'package:flutter_app/components/extensions/context_x.dart';

class DetailsPage extends StatelessWidget {
  final CardData data;

  const DetailsPage(this.data, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(data.text), backgroundColor: Colors.deepPurple),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 300,
              width: double.infinity,
              child: Image.network(
                data.imageUrl ?? '',
                fit: BoxFit.cover,
                errorBuilder: (_, _, _) => const Placeholder(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Expanded(
                    child: Text(data.text, style: Theme.of(context).textTheme.headlineLarge),
                  ),
                  Icon(data.icon, size: 40),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (data.status != null)
                    Text(
                      data.status?.label(context) ?? '',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  Text(
                    '${typeLabel(context, data.type)} • ${data.area ?? '-'} ${context.locale.squareMeters} • ${data.pricePerDay ?? '-'} ${context.locale.perDay}',
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${context.locale.district}: ${data.districtName ?? context.locale.notSpecified}',
                    style: const TextStyle(fontSize: 18),
                  ),
                  Text(
                    '${context.locale.agent}: ${data.agentName == null ? context.locale.notSpecified : '${data.agentName} (${data.agentPhone})'}',
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 16),
                  Text(data.descriptionText, style: const TextStyle(fontSize: 18)),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
