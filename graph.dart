//  Author: abdullah khaled
//  Date: Aug 23 2019
import 'dart:collection';

/**
 * Graph represntation in dart
 * *Feature and implemented algorithms:
 *    *functionl DFS  *functionl BFS
 */
class Graph<T> {
  int _length = 0;
  get length => this._length;
  List<List<_Edge>> edges;
  List<_Node> nodes;

  /// Graph constructor with initialized length
  ///
  ///     Graph<object> graph = Graph<>(5);
  ///
  ///returns a graph of objects with 5 nodes length

  Graph(length) {
    edges = List<List<_Edge<T>>>(length);
    nodes = List<_Node<T>>(length);
  }

  /// add node Contains data T to your graph.
  ///
  /// returned value is the index of your current node make sure to save
  /// if you will need it later
  ///
  ///     int personGraphId = graph.addNode(person);
  ///
  int addNode(T data) {
    int oldLength = length;
    _Node<T> node = _Node<T>(oldLength, data: data);
    nodes[oldLength] = node;
    List<_Edge<T>> init = List<_Edge<T>>();
    edges[oldLength] = init;
    _length++;
    return oldLength;
  }

  /// make a connection/edge between parent node and child node with a optional weight using paren and child ids
  /// Note: weight and directed params are oprtional.
  ///
  /// defaults:
  /// weight = 1 and directed= false
  /// Example:
  ///
  ///     graph.connect(user1.graphId,user2.graphId,weight: 50,directed: true);
  ///
  connect(
      {int parentNodeIndex,
      int childNodeIndex,
      weight = 1,
      bool directed = false}) {
    if (parentNodeIndex == null ||
        childNodeIndex == null ||
        edges[parentNodeIndex] == null ||
        edges[childNodeIndex] == null) {
      throw Exception("double check your indices");
    }
    edges[parentNodeIndex].add(_Edge<T>(
        parentNode: nodes[parentNodeIndex],
        childNode: nodes[childNodeIndex],
        weight: weight));
    if (!directed) {
      edges[childNodeIndex].add(_Edge<T>(
          childNode: nodes[parentNodeIndex],
          parentNode: nodes[childNodeIndex],
          weight: weight));
    }
  }

  /// apply a givin function (func parameter) on each node of your graph with BFS manner.
  ///
  /// Example:
  /// 
  ///     graph1.BFS((node){graph2.addNode(node)});
  /// 

  BFS(dynamic func(_Node<T> node)) {
    List<bool> visited = List<bool>(length);
    Queue<_Node> iteratorQueue = Queue<_Node>();
    iteratorQueue.add(nodes[0]);
    visited[iteratorQueue.first.id] = true;
    while (iteratorQueue.isNotEmpty) {
      _Node iteratorNode = iteratorQueue.removeFirst();
      func(iteratorNode);
      List<_Edge> temp = edges[iteratorNode.id];
      temp.forEach((edge) {
        if (visited[edge.childNode.id] == null)
          iteratorQueue.add(edge.childNode);
        visited[edge.childNode.id] = true;
      });
    }
  }

  /// apply a givin function (func parameter) on each node of your graph with DFS manner.
  ///
  /// Example:
  /// 
  ///     graph1.DFS((node){graph2.addNode(node)});
  /// 

  DFS(dynamic func(_Node<T> node)) {
    List<bool> visited = List<bool>(length);
    _DFS(0, visited, func);
  }

  void _DFS(int startingIndex, List<bool> visited, dynamic func(_Node<T> node)) {
    if (nodes[startingIndex] != null) {
      visited[startingIndex] = true;
      edges[startingIndex].forEach((edge) {
        if (visited[edge.childNode.id] == null)
          _DFS(edge.childNode.id, visited, func);
      });
      func(nodes[startingIndex]);
    }
  }
}

class _Node<T> {
  int id;
  T data;
  _Node(id, {this.data}) : this.id = id;
}

class _Edge<T> {
  _Node<T> parentNode;
  _Node<T> childNode;
  int weight = 1;
  _Edge({this.weight, this.parentNode, this.childNode});
}

