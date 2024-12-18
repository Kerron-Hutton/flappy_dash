import 'package:flappy_dash/audio_helper.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setupServiceLocator() {
  getIt.registerLazySingleton<AudioHelper>(() => AudioHelper());
}
