import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import '../di.config.dart';
import 'common/net/network_client.dart';
import 'common/utils/log.dart';

final getIt = GetIt.instance;

@injectableInit
Future<void> configureDependencies() async => $initGetIt(getIt);

@module
abstract class CommonModule {
  @lazySingleton
  Log get log => Log();
}

@module
abstract class NetworkModule {
  @lazySingleton
  Dio get dio => Dio();

  @lazySingleton
  NetworkClient get networkClient => NetworkClient(dio);
}
