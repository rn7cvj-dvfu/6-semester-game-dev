import 'package:flutter/material.dart';

import '../../../.gen/i18n/strings.g.dart';
import '../../graph/models/model.dart';
import '../../graph/ui/colors.dart';

class AdjacencyMatrixEditor extends StatefulWidget {
  final GraphModel initialGraph;
  final ValueChanged<List<List<int>>> onMatrixChanged;

  const AdjacencyMatrixEditor({
    super.key,
    required this.initialGraph,
    required this.onMatrixChanged,
  });

  @override
  State<AdjacencyMatrixEditor> createState() => _AdjacencyMatrixEditorState();
}

class _AdjacencyMatrixEditorState extends State<AdjacencyMatrixEditor> {
  late List<List<int>> _matrix;
  late int _size;

  @override
  void initState() {
    super.initState();
    _initializeMatrix();
  }

  @override
  void didUpdateWidget(AdjacencyMatrixEditor oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialGraph != oldWidget.initialGraph) {
      _initializeMatrix();
    }
  }

  void _initializeMatrix() {
    _size = widget.initialGraph.nodes.length;
    _matrix = List.generate(_size, (_) => List.generate(_size, (_) => 0));

    for (final edge in widget.initialGraph.edges) {
      final nodeIds = widget.initialGraph.nodes.map((n) => n.id).toList();
      final i = nodeIds.indexOf(edge.firstNodeId);
      final j = nodeIds.indexOf(edge.secondNodeId);
      if (i != -1 && j != -1) {
        _matrix[i][j] = 1;
        _matrix[j][i] = 1; // Assuming undirected graph
      }
    }
  }

  void _updateMatrixValue(int i, int j, int value) {
    setState(() {
      _matrix[i][j] = value;
      _matrix[j][i] = value; // Assuming undirected graph
      widget.onMatrixChanged(_matrix);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      clipBehavior: Clip.antiAlias,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 384),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (_size == 0)
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(context.t.strings.noNodesToEdit),
              )
            else
              Stack(
                children: [
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: _size + 1,
                      childAspectRatio: 2,
                    ),
                    itemCount: (_size + 1) * (_size + 1),
                    itemBuilder: (context, index) {
                      final col = index % (_size + 1);
                      final row = index ~/ (_size + 1);

                      // Top-left empty cell
                      if (row == 0 && col == 0) {
                        return Container(
                          margin: const EdgeInsets.all(8),
                          height: 16,
                          width: 16,
                        );
                      }

                      // Node color indicators in the first row
                      if (row == 0 || col == 0) {
                        final nodeIndex = row == 0 ? col - 1 : row - 1;

                        return Center(
                          child: Container(
                            height: 16,
                            width: 16,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: nodeColors[nodeIndex % nodeColors.length],
                            ),
                          ),
                        );
                      }

                      // Matrix cells
                      final rowIndex = row - 1;
                      final columnIndex = col - 1;

                      return Container(
                        height: 32,
                        width: 32,
                        alignment: Alignment.center,
                        child: Checkbox(
                          key: ValueKey('checkbox_${rowIndex}_$columnIndex'),
                          value: _matrix[rowIndex][columnIndex] == 1,
                          onChanged: rowIndex == columnIndex
                              ? null // Disable checkbox for diagonal elements
                              : (bool? newValue) {
                                  if (newValue != null) {
                                    _updateMatrixValue(
                                      rowIndex,
                                      columnIndex,
                                      newValue ? 1 : 0,
                                    );
                                  }
                                },
                          visualDensity: VisualDensity.compact,
                          activeColor: Theme.of(context).colorScheme.primary,
                        ),
                      );
                    },
                  ),
                ],
              ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              spacing: 8,
              children: [
                TextButton.icon(
                  icon: const Icon(Icons.remove),
                  label: Text(context.t.strings.removeLastNode),
                  onPressed: _size > 3
                      ? _removeLastNode
                      : null, // Disable if no nodes
                ),
                TextButton.icon(
                  icon: const Icon(Icons.add),
                  label: Text(context.t.strings.addNode),
                  onPressed: _size < 7 ? _addNode : null,
                ),
              ],
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  void _addNode() {
    final newSize = _size + 1;
    final newMatrix = List.generate(
      newSize,
      (_) => List.generate(newSize, (_) => 0),
    );

    // Copy old values
    for (int i = 0; i < _size; i++) {
      for (int j = 0; j < _size; j++) {
        newMatrix[i][j] = _matrix[i][j];
      }
    }
    _matrix = newMatrix;
    _size = newSize;
    widget.onMatrixChanged(_matrix);
    setState(() {});
  }

  void _removeLastNode() {
    if (_size == 0) return;
    final newSize = _size - 1;
    if (newSize < 0) return; // Should not happen if button is disabled

    final newMatrix = List.generate(
      newSize,
      (_) => List.generate(newSize, (_) => 0),
    );

    // Copy old values for the smaller matrix
    for (int i = 0; i < newSize; i++) {
      for (int j = 0; j < newSize; j++) {
        newMatrix[i][j] = _matrix[i][j];
      }
    }
    _matrix = newMatrix;
    _size = newSize;
    widget.onMatrixChanged(_matrix);
    setState(() {});
  }
}
