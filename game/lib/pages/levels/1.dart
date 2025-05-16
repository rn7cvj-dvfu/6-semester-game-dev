import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import '../../.gen/i18n/strings.g.dart';
import '../../features/graph/bloc/model.dart';
import '../../features/graph/ui/info_card.dart';
import '../../features/graph/ui/widget.dart';
import '../../features/ui/back_button.dart';
import '../../navigation/navigator.dart';

// Data class for sub-stage information
class _SubStage {
  final String infoTitle;
  final String infoText;
  final GraphModel graphModel;

  _SubStage({
    required this.infoTitle,
    required this.infoText,
    required this.graphModel,
  });
}

class FirstLevelPage extends StatefulWidget {
  const FirstLevelPage({super.key});

  @override
  State<FirstLevelPage> createState() => _FirstLevelPageState();
}

class _FirstLevelPageState extends State<FirstLevelPage> {
  int _currentStageIndex = 0;

  late final List<_SubStage> _stages = [
    _SubStage(
      infoTitle: "Этап 1: Знакомство",
      infoText:
          "Это первый этап. Посмотрите на граф. Он состоит из двух точек и одной связи.",
      graphModel: GraphModel.fromAdjacencyMatrix(
        [
          [0, 1],
          [1, 0],
        ],
        clickable: true,
      ),
    ),
    _SubStage(
      infoTitle: "Этап 2: Больше точек",
      infoText: "Теперь точек три, и они соединены по кругу.",
      graphModel: GraphModel.fromAdjacencyMatrix(
        [
          [0, 1, 1],
          [1, 0, 1],
          [1, 1, 0],
        ],
        clickable: true,
      ),
    ),
    _SubStage(
      infoTitle: "Этап 3: Изолированная точка",
      infoText: "На этом этапе одна из точек не имеет связей.",
      graphModel: GraphModel.fromAdjacencyMatrix(
        [
          [0, 1, 0],
          [1, 0, 0],
          [0, 0, 0],
        ],
        clickable: true,
      ),
    ),
  ];

  void _previousStage() {
    if (_currentStageIndex > 0) {
      setState(() {
        _currentStageIndex--;
      });
    }
  }

  void _nextStage() {
    if (_currentStageIndex < _stages.length - 1) {
      setState(() {
        _currentStageIndex++;
      });
    } else {
      AppNavigator.openLevels();
    }
  }

  @override
  Widget build(BuildContext context) {
    // Ensure _stages is initialized before accessing it.
    // This is crucial because didChangeDependencies might be called after the first build in some scenarios.
    if (_stages == null) {
      // If _stages is still null, it means didChangeDependencies hasn't run or completed.
      // Call it here to ensure initialization. This might happen if context wasn't fully ready.
      // Or, show a loading indicator until it's ready.
      didChangeDependencies(); // Attempt to initialize if null.
      // If it's still null after attempting, show loading.
      // This might occur if Translations.of(context) isn't ready.
      if (_stages == null) {
        return const Scaffold(body: Center(child: CircularProgressIndicator()));
      }
    }

    // At this point, _stages should not be null. Use ! to assert non-null.
    final currentStageData = _stages![_currentStageIndex];
    const transitionDuration = Duration(milliseconds: 300);
    final t =
        Translations.of(context); // Get translations instance for build method

    return Material(
      child: Stack(
        children: [
          AnimatedSwitcher(
            duration: Duration(milliseconds: 500),
            child: Positioned.fill(
              key: ValueKey(currentStageData.graphModel),
              child: GameWidget(
                game: GraphWidget(
                  graphModel: currentStageData.graphModel,
                  backgroundColorValue:
                      Theme.of(context).scaffoldBackgroundColor,
                  dotColorValue: Theme.of(context).colorScheme.primary,
                  connectionEdgeColorValue:
                      Theme.of(context).colorScheme.primaryContainer,
                  onNodeClick: (nodeId) {
                    // print('Node $nodeId clicked');
                  },
                  onEdgeClick: (edgeId) {
                    // print('Edge $edgeId clicked');
                  },
                ),
              ),
            ),
          ),
          Positioned(
            top: 16,
            left: 16,
            child: GBackButton(
              onTap: AppNavigator.openLevels,
            ),
          ),
          Positioned(
            top: 16,
            right: 16,
            child: AnimatedSwitcher(
              duration: transitionDuration,
              key: ValueKey('ui_stage_$_currentStageIndex'),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                spacing: 8,
                children: [
                  InfoCardWidget(
                    title: currentStageData.infoTitle,
                    text: currentStageData.infoText,
                  ),
                  ConstrainedBox(
                    constraints: const BoxConstraints(
                      maxWidth: 384,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      spacing: 8,
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed:
                                _currentStageIndex > 0 ? _previousStage : null,
                            child: Text(t.strings.back),
                          ),
                        ),
                        Text('${_currentStageIndex + 1} / ${_stages!.length}'),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: _nextStage,
                            child: Text(_currentStageIndex < _stages!.length - 1
                                ? t.strings.common.next
                                : t.strings.common.finish),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
