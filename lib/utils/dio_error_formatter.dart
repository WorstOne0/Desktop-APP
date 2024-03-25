// Flutter Packages
import 'package:dio/dio.dart';

// Maybe filter more in the future. Like a Switch-Case
String dioErrorFormatter(DioException exception) {
  return "[${exception.response?.statusCode}] - ${exception.message}";
}
