import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'injection.config.dart';

abstract class Env {
  static const dev = 'dev';
  static const prod = 'prod';
}

final getIt = GetIt.instance;

@InjectableInit(
  initializerName: r'$initGetIt', // default
  preferRelativeImports: true, // default
  asExtension: false, // default
)
@injectableInit
void configureDependencies(String environment) => $initGetIt(getIt, environment: environment);
