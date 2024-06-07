import 'dart:convert';
import 'dart:io';

class ShortestPathError {
  ShortestPathErrorType type;
  String? message;

  ShortestPathError({required this.type, this.message});

  String encode() {
    return jsonEncode({
      'error': 'ShortestPathError',
      'type': type.encode(),
      'message': message,
    });
  }

  factory ShortestPathError.decode(String json) {
    Map<String, dynamic> map = jsonDecode(json);
    if (map['error'] != 'ShortestPathError') {
      throw ArgumentError('Not a ShortestPathError');
    }
    return ShortestPathError(
      type: ShortestPathErrorType.decode(map['type']),
      message: map['message'],
    );
  }

  @override
  String toString() {
    return 'ShortestPathError: ${type.toString()}${message != null ? ': $message' : ''}';
  }

  static bool isJson(String json) {
    try {
      Map<String, dynamic> map = jsonDecode(json);
      return map['error'] == 'ShortestPathError';
    } catch (e) {
      return false;
    }
  }
}

enum ShortestPathErrorType {
  nodeNotFound(HttpStatus.notFound, 'Node not found'),
  noPathFound(HttpStatus.unprocessableEntity, 'No path found'),
  internalError(HttpStatus.internalServerError, 'Internal server error'),
  other(HttpStatus.badRequest, 'Unknown Error'),
  ;

  final int httpStatusCode;
  final String errorNameError;

  const ShortestPathErrorType(this.httpStatusCode, this.errorNameError);

  String encode() {
    return toString();
  }

  factory ShortestPathErrorType.decode(String json) {
    for (ShortestPathErrorType type in ShortestPathErrorType.values) {
      if (json == type.encode()) {
        return type;
      }
    }
    return ShortestPathErrorType.other;
  }
}
