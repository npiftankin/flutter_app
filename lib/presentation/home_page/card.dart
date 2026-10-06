part of 'home_page.dart';

typedef OnLikeCallback = void Function(CardData data, bool isLiked)?;

class _Card extends StatelessWidget {
  final CardData data;
  final VoidCallback? onTap;
  final OnLikeCallback onLike;
  final bool isLiked;

  const _Card(this.data, {this.onTap, this.onLike, this.isLiked = false});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white70,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.grey),
          boxShadow: const [BoxShadow(color: Colors.redAccent, spreadRadius: 4)],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              child: SizedBox(
                height: 200,
                width: double.infinity,
                child: Image.network(
                  data.imageUrl ?? '',
                  fit: BoxFit.cover,
                  errorBuilder: (_, _, _) {
                    return const Placeholder();
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(data.text, style: Theme.of(context).textTheme.headlineSmall),
                      ),
                      Icon(data.icon),
                      const SizedBox(width: 12),
                      GestureDetector(
                        onTap: () => onLike?.call(data, isLiked),
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 200),
                          child: isLiked
                              ? const Icon(
                                  Icons.favorite,
                                  color: Colors.amber,
                                  key: ValueKey<int>(0),
                                )
                              : const Icon(Icons.favorite_border, key: ValueKey<int>(1)),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  if (data.status != null)
                    Text(
                      data.status?.label(context) ?? '',
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                  Text(
                    '${typeLabel(context, data.type)} • ${data.area ?? '-'} ${context.locale.squareMeters} • ${data.pricePerDay ?? '-'} ${context.locale.perDay}',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  Text(
                    '${context.locale.district}: ${data.districtName ?? context.locale.notSpecified}',
                  ),
                  Text(
                    '${context.locale.agent}: ${data.agentName == null ? context.locale.notSpecified : '${data.agentName} (${data.agentPhone})'}',
                  ),
                  const SizedBox(height: 8),
                  Text(data.descriptionText),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
