import 'package:flutter/material.dart';
// import 'dart:math';

class ForestScreen extends StatefulWidget {
  const ForestScreen({super.key});

  @override
  State<ForestScreen> createState() => _ForestScreenState();
}

class _ForestScreenState extends State<ForestScreen> {
  int currentTreeIndex = 0;
  int growthStage = 0;

  final List<TreeSpecies> treeSpeciesList = [
    TreeSpecies(stages: 2, color: Colors.green, name: 'Bonsai'),
    TreeSpecies(stages: 3, color: Colors.orange, name: 'Maple'),
    TreeSpecies(stages: 4, color: Colors.teal, name: 'Pine'),
  ];

  final List<Offset> treePositions = [
    const Offset(80, 400),
    const Offset(180, 420),
    const Offset(280, 410),
    const Offset(100, 430),
    const Offset(250, 390),
  ];

  void growTree() {
    setState(() {
      growthStage++;
      if (growthStage >= treeSpeciesList[currentTreeIndex].stages) {
        growthStage = 0;
        currentTreeIndex = (currentTreeIndex + 1) % treeSpeciesList.length;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    growTree();
  }

  @override
  Widget build(BuildContext context) {
    final currentTree = treeSpeciesList[currentTreeIndex];

    return Scaffold(
      backgroundColor: const Color(0xFFd0f0c0),
      body: Stack(
        children: [
          CustomPaint(
            size: MediaQuery.of(context).size,
            painter: LandPainter(),
          ),
          ...List.generate(currentTreeIndex + 1, (index) {
            final tree = treeSpeciesList[index];
            final stage =
                index == currentTreeIndex ? growthStage : tree.stages - 1;
            return Positioned(
              left: treePositions[index].dx,
              top: treePositions[index].dy,
              child: CustomPaint(
                size: const Size(80, 120),
                painter: TreePainter(stage: stage, color: tree.color),
              ),
            );
          }),
          Positioned(
            top: 30,
            left: 16,
            child: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          Positioned(
            top: 80,
            left: 20,
            right: 20,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.95),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.green.shade300,
                    blurRadius: 6,
                    offset: const Offset(2, 2),
                  )
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '🌳 Forest Details',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Colors.green[800],
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 8),
                  detailRow('Current Tree', currentTree.name),
                  detailRow('Growth Stage',
                      '${growthStage + 1} / ${currentTree.stages}'),
                  detailRow('Trees Planted', '${currentTreeIndex}'),
                  detailRow(
                      'Species Planted',
                      currentTreeIndex == 0
                          ? '-'
                          : treeSpeciesList
                              .sublist(0, currentTreeIndex)
                              .map((e) => e.name)
                              .join(', ')),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget detailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(top: 6.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label: ',
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}

class TreeSpecies {
  final int stages;
  final Color color;
  final String name;

  TreeSpecies({required this.stages, required this.color, required this.name});
}

class TreePainter extends CustomPainter {
  final int stage;
  final Color color;

  TreePainter({required this.stage, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final trunkPaint = Paint()..color = Colors.brown;
    final leafPaint = Paint()..color = color;

    canvas.drawRect(
      Rect.fromLTWH(size.width / 2 - 5, size.height - 40, 10, 40),
      trunkPaint,
    );

    for (int i = 0; i <= stage; i++) {
      double radius = 20 + i * 5;
      Offset center = Offset(size.width / 2, size.height - 40 - i * 20);
      canvas.drawCircle(center, radius, leafPaint);
    }
  }

  @override
  bool shouldRepaint(TreePainter oldDelegate) =>
      oldDelegate.stage != stage || oldDelegate.color != color;
}

class LandPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final groundPaint = Paint()..color = const Color(0xFFa3c785);
    final hillPaint = Paint()..color = const Color(0xFF7db57b);

    canvas.drawRect(
      Rect.fromLTWH(0, size.height * 0.7, size.width, size.height * 0.3),
      groundPaint,
    );

    final path = Path()
      ..moveTo(0, size.height * 0.7)
      ..quadraticBezierTo(size.width * 0.25, size.height * 0.6,
          size.width * 0.5, size.height * 0.7)
      ..quadraticBezierTo(
          size.width * 0.75, size.height * 0.8, size.width, size.height * 0.7)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();

    canvas.drawPath(path, hillPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
