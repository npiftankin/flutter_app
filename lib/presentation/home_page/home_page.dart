import 'package:flutter/material.dart';
import 'package:flutter_app/data/repositories/api_interface.dart';
import 'package:flutter_app/data/repositories/property_repository.dart';
import 'package:flutter_app/domain/models/card.dart';
import 'package:flutter_app/domain/models/home.dart';
import 'package:flutter_app/presentation/common/status_label.dart';
import 'package:flutter_app/presentation/details_page/details_page.dart';

part 'card.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final Color _color = Colors.deepPurple;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: _color, title: Text(widget.title)),
      body: const Body(),
    );
  }
}

const List<String> _types = ['Квартира', 'Дом', 'Офис'];
const double _sliderMin = 1000;
const double _sliderMax = 20000;

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final ApiInterface _repo = PropertyRepository();

  HomeData? _data;
  bool _isLoading = false;
  String? _error;

  String? _type;
  double _price = _sliderMax;

  // номер последнего запроса: ответы на устаревшие запросы игнорируются
  int _requestId = 0;

  // крайнее правое положение ползунка означает отсутствие ограничения
  int? get _maxPrice => _price >= _sliderMax ? null : _price.round();

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final int requestId = ++_requestId;
    setState(() {
      _isLoading = true;
      _error = null;
    });

    String? error;
    final HomeData? data = await _repo.loadData(
      type: _type,
      maxPrice: _maxPrice,
      onError: (e) => error = e,
    );

    if (!mounted || requestId != _requestId) {
      return;
    }
    setState(() {
      _data = data ?? _data;
      _error = error;
      _isLoading = false;
    });
  }

  void _onTypeSelected(String? type) {
    setState(() => _type = type);
    _load();
  }

  void _onPriceChanged(double value) {
    setState(() => _price = value);
    _load();
  }

  @override
  Widget build(BuildContext context) {
    final int? maxPrice = _maxPrice;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
          child: Wrap(
            spacing: 8,
            children: [
              ChoiceChip(
                label: const Text('Все'),
                selected: _type == null,
                onSelected: (_) => _onTypeSelected(null),
              ),
              ..._types.map(
                (type) => ChoiceChip(
                  label: Text(type),
                  selected: _type == type,
                  onSelected: (_) => _onTypeSelected(type),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              maxPrice == null ? 'Любая цена' : 'До $maxPrice ₽ в сутки',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
        ),
        Slider(
          value: _price,
          min: _sliderMin,
          max: _sliderMax,
          divisions: 19,
          onChanged: _onPriceChanged,
        ),
        if (_isLoading) const LinearProgressIndicator(),
        if (_error != null)
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              _error ?? '',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.red),
            ),
          ),
        Expanded(child: _buildList()),
      ],
    );
  }

  Widget _buildList() {
    final List<CardData>? items = _data?.data;

    if (items == null) {
      return const SizedBox.shrink();
    }
    if (items.isEmpty) {
      return const Center(child: Text('Ничего не найдено'));
    }

    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        final CardData item = items[index];
        return _Card(
          item,
          onTap: () =>
              Navigator.push(context, MaterialPageRoute(builder: (context) => DetailsPage(item))),
        );
      },
    );
  }
}
