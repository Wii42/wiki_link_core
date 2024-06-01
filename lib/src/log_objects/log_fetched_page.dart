import 'dart:convert';

import 'package:intl/intl.dart';
import '../wiki_link_page_data.dart';

import 'log_object.dart';

class LogFetchedPage extends LogObject {
  final int fetchedPages, knownPages;
  final DateTime? fetchedAt;
  final String fetchPath;
  final String pageTitle;
  final Uri pageUrl;
  final int foundLinks, newFoundPages;

  LogFetchedPage({
    required this.fetchedPages,
    required this.knownPages,
    required this.fetchedAt,
    required this.fetchPath,
    required this.pageTitle,
    required this.pageUrl,
    required this.foundLinks,
    required this.newFoundPages,
  });

  factory LogFetchedPage.fromPage({
    required WikiLinkPageData page,
    required int numberOfKnownPages,
    required int fetchQueueLength,
    required int newFoundPages,
    required int foundLinks,
    String? fetchPath,
  }) {
    return LogFetchedPage(
      fetchedPages: numberOfKnownPages - fetchQueueLength,
      knownPages: numberOfKnownPages,
      fetchedAt: page.lastFetchedAt,
      fetchPath: '${fetchPath ?? "<Root>"} ->',
      pageTitle: page.title,
      pageUrl: page.url,
      foundLinks: foundLinks,
      newFoundPages: newFoundPages,
    );
  }

  @override
  String encode() {
    return jsonEncode({
      'type': 'LogFetchedPage',
      'fetchedPages': fetchedPages,
      'knownPages': knownPages,
      'lastFetchedAt': fetchedAt?.toIso8601String(),
      'fetchPath': fetchPath,
      'pageTitle': pageTitle,
      'pageUrl': pageUrl.toString(),
      'foundLinks': foundLinks,
      'newFoundPages': newFoundPages,
    });
  }

  static isJson(String json) {
    try {
      Map<String, dynamic> map = jsonDecode(json);
      return map['type'] == 'LogFetchedPage';
    } catch (e) {
      return false;
    }
  }

  factory LogFetchedPage.decode(String json) {
    Map<String, dynamic> map = jsonDecode(json);
    return LogFetchedPage(
      fetchedPages: map['fetchedPages'],
      knownPages: map['knownPages'],
      fetchedAt: map['lastFetchedAt'] != null
          ? DateTime.parse(map['lastFetchedAt'])
          : null,
      fetchPath: map['fetchPath'],
      pageTitle: map['pageTitle'],
      pageUrl: Uri.parse(map['pageUrl']),
      foundLinks: map['foundLinks'],
      newFoundPages: map['newFoundPages'],
    );
  }

  @override
  String toString() {
    return [
      '${formatNumber(fetchedPages)}/${formatNumber(knownPages)}',
      if (fetchedAt != null) formatDate(fetchedAt!),
      fetchPath,
      pageTitle,
      pageUrl,
      '[${formatNumber(foundLinks)} (+${formatNumber(newFoundPages)})]',
    ].join(' ');
  }

  static DateFormat get _dateFormat => DateFormat("HH:mm:ss");
  static NumberFormat get _numberFormat =>
      NumberFormat.decimalPatternDigits(locale: 'de-ch', decimalDigits: 0);

  static String formatDate(DateTime date) => _dateFormat.format(date);
  static String formatNumber(int number) => _numberFormat.format(number);
}
