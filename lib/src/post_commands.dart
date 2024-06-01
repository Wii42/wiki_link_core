enum PostCommands {
  startGraphBuilding('start_graph_building'),
  stopGraphBuilding('stop_graph_building'),
  killServer('kill_server');

  final String command;

  const PostCommands(this.command);

  factory PostCommands.parse(String command) {
    PostCommands? c = tryParse(command);
    if (c != null) {
      return c;
    }
    throw ArgumentError('Unknown command: $command');
  }

  static PostCommands? tryParse(String command) {
    for (PostCommands c in PostCommands.values) {
      if (c.command == command) {
        return c;
      }
    }
    return null;
  }
}