part of 'home_page.dart';

class _CardData {
  final String text;
  final String descriptionText;
  final IconData icon;
  final String? imageUrl;

  _CardData(
      this.text, {
        required this.descriptionText,
        this.icon = Icons.home,
        this.imageUrl,
      });
}

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    final data = [
      _CardData(
        'Дом',
        descriptionText: 'Большой загородный дом с участком.',
        icon: Icons.home,
        imageUrl:
        'https://m.terem-pro.ru/upload/iblock/27c/27cd22f5560e08e5e7e106370c0cdf8b.jpg',
      ),
      _CardData(
        'Квартира',
        descriptionText: 'Современная квартира в центре города.',
        icon: Icons.apartment,
        imageUrl:
        'https://s0.rbk.ru/v6_top_pics/media/img/4/60/756113122114604.jpg',
      ),
    ];

    return Center(
      child: SingleChildScrollView(
        child: Column(
          children: data
              .map(
                (e) => _Card.fromData(e),
          )
              .toList(),
        ),
      ),
    );
  }
}

class _Card extends StatefulWidget {
  final String text;
  final String descriptionText;
  final IconData icon;
  final String? imageUrl;

  const _Card(
      this.text, {
        required this.descriptionText,
        this.icon = Icons.home,
        this.imageUrl,
      });

  factory _Card.fromData(_CardData data) {
    return _Card(
      data.text,
      descriptionText: data.descriptionText,
      icon: data.icon,
      imageUrl: data.imageUrl,
    );
  }

  @override
  State<_Card> createState() => _CardState();
}

class _CardState extends State<_Card> {
  bool isLiked = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailsPage(
              text: widget.text,
              descriptionText: widget.descriptionText,
              imageUrl: widget.imageUrl,
              icon: widget.icon,
            ),
          ),
        );
      },
      child: Container(
        width: 340,
        margin: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white70,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: Colors.grey,
          ),
          boxShadow: const [
            BoxShadow(
              color: Colors.redAccent,
              spreadRadius: 4,
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
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
                  widget.imageUrl ?? '',
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) {
                    return const Placeholder();
                  },
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      widget.text,
                      style:
                      Theme.of(context).textTheme.headlineSmall,
                    ),
                  ),

                  Icon(widget.icon),

                  const SizedBox(width: 12),

                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isLiked = !isLiked;
                      });

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            isLiked
                                ? '${widget.text} добавлено в избранное'
                                : '${widget.text} удалено из избранного',
                          ),
                          backgroundColor: Colors.deepPurple,
                          duration:
                          const Duration(seconds: 1),
                        ),
                      );
                    },
                    child: AnimatedSwitcher(
                      duration:
                      const Duration(milliseconds: 200),
                      child: isLiked
                          ? const Icon(
                        Icons.favorite,
                        color: Colors.amber,
                        key: ValueKey<int>(0),
                      )
                          : const Icon(
                        Icons.favorite_border,
                        key: ValueKey<int>(1),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}