import 'package:flutter/material.dart';
import 'package:flutter_app/components/utils/debounce.dart';
import 'package:flutter_app/domain/models/card.dart';
import 'package:flutter_app/presentation/common/labels.dart';
import 'package:flutter_app/components/extensions/context_x.dart';
import 'package:flutter_app/presentation/details_page/details_page.dart';
import 'package:flutter_app/presentation/home_page/bloc/bloc.dart';
import 'package:flutter_app/presentation/home_page/bloc/events.dart';
import 'package:flutter_app/presentation/home_page/bloc/state.dart';
import 'package:flutter_app/presentation/common/svg_objects.dart';
import 'package:flutter_app/presentation/like_bloc/like_bloc.dart';
import 'package:flutter_app/presentation/like_bloc/like_event.dart';
import 'package:flutter_app/presentation/like_bloc/like_state.dart';
import 'package:flutter_app/presentation/locale_bloc/locale_bloc.dart';
import 'package:flutter_app/presentation/locale_bloc/locale_events.dart';
import 'package:flutter_app/presentation/locale_bloc/locale_state.dart';
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
      appBar: AppBar(
        backgroundColor: _color,
        title: Text(widget.title),
        actions: [
          GestureDetector(
            onTap: () => context.read<LocaleBloc>().add(const ChangeLocaleEvent()),
            child: SizedBox.square(
              dimension: 40,
              child: Padding(
                padding: const EdgeInsets.only(right: 12),
                child: BlocBuilder<LocaleBloc, LocaleState>(
                  builder: (context, state) {
                    return state.currentLocale.languageCode == 'ru' ? const SvgRu() : const SvgUk();
                  },
                ),
              ),
            ),
          ),
        ],
      ),
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

  int? get _maxPrice => _price >= _sliderMax ? null : _price.round();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HomeBloc>().add(const HomeLoadDataEvent());
      context.read<LikeBloc>().add(const LoadLikesEvent());
    });
  }

  void _onTypeSelected(String? type) {
    context.read<HomeBloc>().add(HomeLoadDataEvent(type: type, maxPrice: _maxPrice));
  }

  void _onPriceChanged(double value) {
    setState(() => _price = value);

    Debounce.run(() {
      if (!mounted) {
        return;
      }

      final bloc = context.read<HomeBloc>();
      bloc.add(HomeLoadDataEvent(type: bloc.state.type, maxPrice: _maxPrice));
    });
  }

  void _onLike(CardData data, bool isLiked) {
    final int? id = data.id;
    if (id == null) {
      return;
    }

    context.read<LikeBloc>().add(ChangeLikeEvent(id));

    final String message = isLiked ? context.locale.disliked : context.locale.liked;
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${data.text} $message'),
        backgroundColor: Colors.deepPurple,
        duration: const Duration(seconds: 1),
      ),
    );
  }

  void _onRetry() {
    final bloc = context.read<HomeBloc>();
    bloc.add(HomeLoadDataEvent(type: bloc.state.type, maxPrice: bloc.state.maxPrice));
  }

  Future<void> _onRefresh() async {
    final bloc = context.read<HomeBloc>();
    bloc.add(HomeLoadDataEvent(type: bloc.state.type, maxPrice: bloc.state.maxPrice));

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
                    label: Text(context.locale.all),
                    selected: state.type == null,
                    onSelected: (_) => _onTypeSelected(null),
                  ),
                  ..._types.map(
                    (type) => ChoiceChip(
                      label: Text(typeLabel(context, type)),
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
                  maxPrice == null ? context.locale.anyPrice : context.locale.priceUpTo(maxPrice),
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
            Expanded(child: _buildList(state)),
          ],
        );
      },
    );
  }

  Widget _buildList(HomeState state) {
    final List<CardData> items = state.data?.data ?? [];

    final bool hasError = state.error != null;
    final bool showEmpty = state.data != null && items.isEmpty;
    final int offset = hasError ? 1 : 0;

    return BlocBuilder<LikeBloc, LikeState>(
      builder: (context, likeState) {
        return RefreshIndicator(
          onRefresh: _onRefresh,
          child: ListView.builder(
            physics: const AlwaysScrollableScrollPhysics(),
            itemCount: offset + (showEmpty ? 1 : items.length),
            itemBuilder: (context, index) {
              if (hasError && index == 0) {
                return Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Text(
                        state.error ?? '',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.red),
                      ),
                      TextButton(onPressed: _onRetry, child: Text(context.locale.retry)),
                    ],
                  ),
                );
              }
              if (showEmpty) {
                return Padding(
                  padding: const EdgeInsets.all(32),
                  child: Center(child: Text(context.locale.nothingFound)),
                );
              }

              final CardData item = items[index - offset];
              return _Card(
                item,
                onLike: _onLike,
                isLiked: likeState.likedIds.contains(item.id),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DetailsPage(item)),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
