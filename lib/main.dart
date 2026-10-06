import 'package:flutter/material.dart';
import 'package:flutter_app/data/repositories/api_interface.dart';
import 'package:flutter_app/data/repositories/property_repository.dart';
import 'package:flutter_app/presentation/home_page/bloc/bloc.dart';
import 'package:flutter_app/presentation/home_page/home_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
      home: RepositoryProvider<ApiInterface>(
        create: (_) => PropertyRepository(),
        child: BlocProvider<HomeBloc>(
          create: (context) => HomeBloc(context.read<ApiInterface>()),
          child: const MyHomePage(title: 'CityHome'),
        ),
      ),
    );
  }
}
