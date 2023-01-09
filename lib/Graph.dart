import 'dart:math';

import 'package:flutter/material.dart';
import 'package:graphview/GraphView.dart';
import 'package:myapp/Crud/ConnectionDL.dart';
import 'package:myapp/Crud/UserDL.dart';

class UserGraph extends StatefulWidget {
  const UserGraph({Key? key}) : super(key: key);

  @override
  State<UserGraph> createState() => _UserGraphState();
}

class _UserGraphState extends State<UserGraph> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: InteractiveViewer(
                  constrained: false,
                  boundaryMargin: EdgeInsets.all(100),
                  minScale: 0.01,
                  maxScale: 5.6,
                  child: GraphView(
                    graph: graph,
                    algorithm:
                    BuchheimWalkerAlgorithm(builder, TreeEdgeRenderer(builder)),
                    paint: Paint()
                      ..color = Colors.green
                      ..strokeWidth = 1
                      ..style = PaintingStyle.stroke,
                    builder: (Node node) {
                      // I can decide what widget should be shown here based on the id
                      String? a = node.key?.value as String?;
                      return rectangleWidget(a.toString());
                    },
                  )),
            ),
          ],
        ));
  }

  Random r = Random();

  Widget rectangleWidget(String a) {
    return InkWell(
      onTap: () {
        print('clicked');
      },
      child: Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            boxShadow: const [
              BoxShadow(color: Colors.teal, spreadRadius: 1),
            ],
          ),
          child: Text(
            a,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
            ),
          )),
    );
  }

  final Graph graph = Graph()..isTree = true;
  BuchheimWalkerConfiguration builder = BuchheimWalkerConfiguration();

  void drawGraph() async {
    Map<String, Node> userMap = {};
    print("object");
    var v = await UserDL.GetAllUsers();
    for (int i = 0; i < v.length; i++) {
      userMap[v[i]['email']] = Node.Id(v[i]['email']);
      print(userMap[v[i]['email']]);
    }
    print(userMap.length);
    // graph.addEdge(root1, root2);

    var cons = await ConnectionDL.getAllConnections();
    cons.forEach((element) {
      graph.addEdge(userMap[element['user1']]!, userMap[element['user2']]!);
    });



    final node1 = Node.Id('ali');
    final node2 = Node.Id('umar');
    final node3 = Node.Id('Usman');
    final node4 = Node.Id("Neha");
    final node5 = Node.Id("farid");
    final node6 = Node.Id("6");
    final node8 = Node.Id("7");
    final node7 = Node.Id("8");
    final node9 = Node.Id("9");
    final node10 = Node.Id("10");
    final node11 = Node.Id("11");
    final node12 = Node.Id("12");

    graph.addEdge(node1, node3, paint: Paint()..color = Colors.red);
    graph.addEdge(node1, node4, paint: Paint()..color = Colors.blue);
    graph.addEdge(node2, node5);
    graph.addEdge(node2, node6);
    graph.addEdge(node6, node7, paint: Paint()..color = Colors.red);
    graph.addEdge(node6, node8, paint: Paint()..color = Colors.red);
    graph.addEdge(node4, node9);
    graph.addEdge(node4, node10, paint: Paint()..color = Colors.black);
    graph.addEdge(node4, node11, paint: Paint()..color = Colors.red);
    graph.addEdge(node11, node12);


    builder
      ..siblingSeparation = (250)
      ..levelSeparation = (250)
      ..subtreeSeparation = (250)
      ..orientation = (BuchheimWalkerConfiguration.DEFAULT_SIBLING_SEPARATION);

  }

  @override
  void initState() {
    drawGraph();
    super.initState();
  }
}