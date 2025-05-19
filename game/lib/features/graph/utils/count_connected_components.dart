import '../models/model.dart';

int countConnectedComponentsInGraph(GraphModel graph) {
  if (graph.nodes.isEmpty) {
    return 0;
  }

  final visited = <String>{};
  int components = 0;

  final adjacencyList = <String, List<String>>{};
  for (final node in graph.nodes) {
    adjacencyList[node.id] = [];
  }
  for (final edge in graph.edges) {
    adjacencyList[edge.firstNodeId]?.add(edge.secondNodeId);
    adjacencyList[edge.secondNodeId]?.add(edge.firstNodeId);
  }

  void dfs(String nodeId) {
    visited.add(nodeId);
    for (final neighborId in adjacencyList[nodeId]!) {
      if (!visited.contains(neighborId)) {
        dfs(neighborId);
      }
    }
  }

  for (final node in graph.nodes) {
    if (!visited.contains(node.id)) {
      dfs(node.id);
      components++;
    }
  }

  return components;
}
