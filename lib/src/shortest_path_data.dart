import 'wiki_link_page_data.dart';

class ShortestPathData {
  final List<WikiLinkPageData> shortestPath;
  final Duration duration;
  final int encounteredNodesCount;

  ShortestPathData(
      this.shortestPath, this.duration, this.encounteredNodesCount);

  Map<String, dynamic> toJson() {
    return {
      'shortestPath': shortestPath.map((e) => e.toJson()).toList(),
      'duration': duration.inMilliseconds,
      'encounteredNodesCount': encounteredNodesCount
    };
  }

  factory ShortestPathData.fromJson(Map<String, dynamic> json) {
    return ShortestPathData(
      json['shortestPath']
          .toList()
          .map((e) => WikiLinkPageData.fromJson(e))
          .toList()
          .cast<WikiLinkPageData>(),
      Duration(milliseconds: json['duration']),
      json['encounteredNodesCount'],
    );
  }

  @override
  String toString() {
    return "ShortestPathData{shortestPath: $shortestPath, duration: $duration, encounteredNodesCount: $encounteredNodesCount}";
  }
}
