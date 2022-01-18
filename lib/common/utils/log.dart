import 'package:logger/logger.dart';

class Log {
  Log._internal();

  factory Log() => _instance;

  static final _instance = Log._internal();

  final Logger _logger = Logger();

  void d(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _logger.d(message, error, stackTrace);
  }

  void e(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _logger.e(message, error, stackTrace);
  }
}
