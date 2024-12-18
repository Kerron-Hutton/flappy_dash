import 'package:flame/flame.dart';
import 'package:flappy_dash/audio_helper.dart';
import 'package:flappy_dash/presentation/bloc/game/game_cubit.dart';
import 'package:flappy_dash/presentation/pages/main_page.dart';
import 'package:flappy_dash/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Flame.device.fullScreen();

  setupServiceLocator();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flappy Dash',
      home: BlocProvider(
        create: (context) => GameCubit(getIt.get<AudioHelper>()),
        child: MainPage(),
      ),
    );
  }
}
