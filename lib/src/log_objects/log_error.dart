import 'dart:convert';

import 'log_object.dart';

class LogError extends LogObject {
  final String message, stackTrace;

  LogError({required this.message, required this.stackTrace});

  @override
  String encode() {
    return jsonEncode({
      'type': 'LogError',
      'message': message,
      'stackTrace': stackTrace,
    });
  }

  static isJson(String json) {
    try {
      Map<String, dynamic> map = jsonDecode(json);
      return map['type'] == 'LogError';
    } catch (e) {
      return false;
    }
  }

  factory LogError.decode(String json) {
    Map<String, dynamic> map = jsonDecode(json);
    return LogError(
      message: map['message'],
      stackTrace: map['stackTrace'],
    );
  }

  @override
  String toString() {
    return 'Exception: $message\nStack trace:\n${stackTrace.trim()}';
  }
}
