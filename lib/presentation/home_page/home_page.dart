import 'package:flutter/material.dart';
import 'package:flutter_app/components/utils/debounce.dart';
import 'package:flutter_app/domain/models/card.dart';
import 'package:flutter_app/presentation/common/status_label.dart';
import 'package:flutter_app/presentation/details_page/details_page.dart';
import 'package:flutter_app/presentation/home_page/bloc/bloc.dart';
import 'package:flutter_app/presentation/home_page/bloc/events.dart';
import 'package:flutter_app/presentation/home_page/bloc/state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  double _price = _sliderMax;

  // крайнее правое положение ползунка означает отсутствие ограничения
  int? get _maxPrice => _price >= _sliderMax ? null : _price.round();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HomeBloc>().add(const HomeLoadDataEvent());
    });
  }

  void _onTypeSelected(String? type) {
    context.read<HomeBloc>().add(HomeLoadDataEvent(type: type, maxPrice: _maxPrice));
  }

  void _onPriceChanged(double value) {
    // ползунок двигается сразу, а запрос уходит, когда пользователь остановился
    setState(() => _price = value);

    Debounce.run(() {
      final bloc = context.read<HomeBloc>();
      bloc.add(HomeLoadDataEvent(type: bloc.state.type, maxPrice: _maxPrice));
    });
  }

  void _onRetry() {
    final bloc = context.read<HomeBloc>();
    bloc.add(HomeLoadDataEvent(type: bloc.state.type, maxPrice: bloc.state.maxPrice));
  }

  Future<void> _onRefresh() async {
    final bloc = context.read<HomeBloc>();
    bloc.add(HomeLoadDataEvent(type: bloc.state.type, maxPrice: bloc.state.maxPrice));

    // индикатор обновления крутится, пока блок не закончит загрузку
    await bloc.stream.firstWhere((state) => !state.isLoading);
  }

  @override
  Widget build(BuildContext context) {
    final int? maxPrice = _maxPrice;

    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
              child: Wrap(
                spacing: 8,
                children: [
                  ChoiceChip(
                    label: const Text('Все'),
                    selected: state.type == null,
                    onSelected: (_) => _onTypeSelected(null),
                  ),
                  ..._types.map(
                    (type) => ChoiceChip(
                      label: Text(type),
                      selected: state.type == type,
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
            if (state.isLoading) const LinearProgressIndicator(),
            if (state.error != null)
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Text(
                      state.error ?? '',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.red),
                    ),
                    TextButton(onPressed: _onRetry, child: const Text('Повторить')),
                  ],
                ),
              ),
            Expanded(child: _buildList(state)),
          ],
        );
      },
    );
  }

  Widget _buildList(HomeState state) {
    final List<CardData>? items = state.data?.data;

    // список всегда прокручиваемый, иначе пустой экран нельзя потянуть для обновления
    return RefreshIndicator(
      onRefresh: _onRefresh,
      child: ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: items == null ? 0 : (items.isEmpty ? 1 : items.length),
        itemBuilder: (context, index) {
          if (items == null || items.isEmpty) {
            return const Padding(
              padding: EdgeInsets.all(32),
              child: Center(child: Text('Ничего не найдено')),
            );
          }

          final CardData item = items[index];
          return _Card(
            item,
            onTap: () =>
                Navigator.push(context, MaterialPageRoute(builder: (context) => DetailsPage(item))),
          );
        },
      ),
    );
  }
}
