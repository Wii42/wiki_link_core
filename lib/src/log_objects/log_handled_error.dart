import 'dart:convert';

import 'log_object.dart';

class LogHandledError extends LogObject {
  final String message;
  final String? details, actions;

  LogHandledError({required this.message, this.details, this.actions});

  @override
  String encode() {
    return jsonEncode({
      'type': 'LogHandledError',
      'message': message,
      'details': details,
      'actions': actions,
    });
  }

  static isJson(String json) {
    try {
      Map<String, dynamic> map = jsonDecode(json);
      return map['type'] == 'LogHandledError';
    } catch (e) {
      return false;
    }
  }

  factory LogHandledError.decode(String json) {
    Map<String, dynamic> map = jsonDecode(json);
    return LogHandledError(
      message: map['message'],
      details: map['details'],
      actions: map['actions'],
    );
  }

  @override
  String toString() {
    return "Handled error: $message\nDetails: $details\nActions: $actions";
  }
}
