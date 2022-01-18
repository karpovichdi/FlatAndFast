import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

part 'network_client.g.dart';

@RestApi(baseUrl: '')
abstract class NetworkClient {
  factory NetworkClient(Dio dio, {String baseUrl}) = _NetworkClient;
}
