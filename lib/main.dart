import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_app/components/locale/l10n/app_locale.dart';
import 'package:flutter_app/data/repositories/api_interface.dart';
import 'package:flutter_app/data/repositories/like_repository.dart';
import 'package:flutter_app/data/repositories/property_repository.dart';
import 'package:flutter_app/data/repositories/sqlite_like_repository.dart';
import 'package:flutter_app/presentation/home_page/bloc/bloc.dart';
import 'package:flutter_app/presentation/home_page/home_page.dart';
import 'package:flutter_app/presentation/like_bloc/like_bloc.dart';
import 'package:flutter_app/presentation/locale_bloc/locale_bloc.dart';
import 'package:flutter_app/presentation/locale_bloc/locale_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

// Язык системы, если он не поддерживается, то русский
Locale _defaultLocale() {
  final Locale system = PlatformDispatcher.instance.locale;
  return AppLocale.supportedLocales.firstWhere(
    (e) => e.languageCode == system.languageCode,
    orElse: () => const Locale('ru'),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LocaleBloc>(
      lazy: false,
      create: (context) => LocaleBloc(_defaultLocale()),
      child: BlocBuilder<LocaleBloc, LocaleState>(
        builder: (context, state) {
          return MaterialApp(
            title: 'Flutter Demo',
            locale: state.currentLocale,
            localizationsDelegates: AppLocale.localizationsDelegates,
            supportedLocales: AppLocale.supportedLocales,
            debugShowCheckedModeBanner: false,
            theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
            home: RepositoryProvider<ApiInterface>(
              create: (_) => PropertyRepository(),
              child: RepositoryProvider<LikeRepository>(
                create: (_) => SqliteLikeRepository(),
                child: BlocProvider<LikeBloc>(
                  create: (context) => LikeBloc(context.read<LikeRepository>()),
                  child: BlocProvider<HomeBloc>(
                    create: (context) => HomeBloc(context.read<ApiInterface>()),
                    child: const MyHomePage(title: 'CityHome'),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
