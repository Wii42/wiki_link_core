import 'package:html/dom.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart';

class WikiLinkPageData {
  String title;
  final Uri url;
  final int? id;
  int? fetchTreeParentId;
  int foundAtDepth;
  DateTime? lastFetchedAt;

  WikiLinkPageData(
    this.url, {
    this.id,
    required this.title,
    required this.foundAtDepth,
    this.lastFetchedAt,
    this.fetchTreeParentId,
  });

  Future<Document> getHtml() async {
    Client client = Client();
    Response response = await client.get(url);
    return HtmlParser(response.body).parse();
  }

  @override
  bool operator ==(Object other) {
    if (other is WikiLinkPageData) {
      return other.url == url;
    }
    return false;
  }

  @override
  int get hashCode => url.hashCode;

  Map<String, dynamic> toJson() {
    return toMap();
  }

  String urlShortForm(Uri? url) {
    String urlString = url.toString();
    if (urlString.startsWith('https://${this.url.host}/wiki/')) {
      urlString =
          url.toString().replaceFirst('https://${this.url.host}/wiki', '');
    }
    return urlString;
  }

  @override
  String toString() {
    List<String> properties = [
      'title: $title',
      'url: $url',
      'id: $id',
      'foundAtDepth: $foundAtDepth',
      'lastFetched: $lastFetchedAt'
    ];
    return "WikiLinkPage{${properties.join(', ')}}";
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'url': url.toString(),
      'fetchTreeParent': fetchTreeParentId,
      'foundAtDepth': foundAtDepth,
      'lastFetched': lastFetchedAt?.toIso8601String(),
    };
  }

  factory WikiLinkPageData.fromMap(Map<String, dynamic> map) {
    return WikiLinkPageData(
      Uri.parse(map['url']),
      title: map['title'],
      id: map['id'],
      foundAtDepth: map['foundAtDepth'],
      fetchTreeParentId: map['fetchTreeParent'],
      lastFetchedAt: map['lastFetched'] == null
          ? null
          : DateTime.parse(map['lastFetched']),
    );
  }

  factory WikiLinkPageData.fromJson(Map<String, dynamic> json) {
    return WikiLinkPageData.fromMap(json);
  }
}
