enum ConnectionEndpoints {
  stream('/stream'),
  command('/command'),
  shortestPath('/shortest_path'),
  unknown_('_unknown_');

  final String path;

  const ConnectionEndpoints(this.path);

  factory ConnectionEndpoints.fromPath(String path) {
    for (ConnectionEndpoints endpoint in ConnectionEndpoints.values) {
      if (endpoint.path == path) {
        return endpoint;
      }
    }
    return unknown_;
  }
}
