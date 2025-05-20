import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../.gen/i18n/strings.g.dart';
import '../../../navigation/navigator.dart';
import '../../graph/ui/widget.dart';
import '../../settings.dart';
import '../../ui/back_button.dart';
import '../models/stage.dart';

part 'widgets/info_card.dart';
part 'widgets/step_button.dart';
part 'widgets/animation_button.dart';

class LevelWidget extends StatefulWidget {
  final List<LevelStageModel> stages;
  final VoidCallback? onBackTap;
  final VoidCallback onFinish;

  const LevelWidget({
    super.key,
    required this.stages,
    this.onBackTap,
    required this.onFinish,
  });

  @override
  State<LevelWidget> createState() => _LevelWidgetState();
}

class _LevelWidgetState extends State<LevelWidget> {
  GraphWidget? _graphWidget;

  int _currentStageIndex = 0;
  int _totalStages = 0;
  LevelStageModel? _currentStage;

  int? _questionInput;
  String? _errorText;

  @override
  void initState() {
    super.initState();
    assert(widget.stages.isNotEmpty, 'Stages cannot be empty');
    _totalStages = widget.stages.length;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _initGraphWidget();
    _initStages();
  }

  void _initStages() {
    if (_currentStage != null) {
      return;
    }

    _currentStage = widget.stages[_currentStageIndex];
  }

  void _initGraphWidget() {
    if (_graphWidget != null) {
      return;
    }

    _graphWidget = GraphWidget(
      graphModel: widget.stages[0].graphModel,
      backgroundColorValue: Theme.of(context).scaffoldBackgroundColor,
      nodeColorValue: Theme.of(context).colorScheme.primary,
      edgeColorValue: Theme.of(context).colorScheme.primaryContainer,
      onEdgeClick: (edgeId) {},
      onNodeClick: (nodeId) {},
    );
  }

  bool _validate(int correctAnswer) {
    if (_questionInput == null) {
      _errorText = context.t.strings.enterNumber;
      setState(() {});
      return false;
    }

    if (_questionInput != correctAnswer) {
      _errorText = context.t.strings.wrongAnswer;
      setState(() {});
      return false;
    }

    _errorText = null;
    setState(() {});
    return true;
  }

  void _previousStage() {
    if (_currentStageIndex < 1) {
      return;
    }

    if (_graphWidget == null) {
      _initGraphWidget();
    }

    final newStage = widget.stages[_currentStageIndex - 1];

    setState(() {
      _currentStageIndex--;
      _graphWidget!.replaceGraphModel(newStage.graphModel);
      _currentStage = newStage;
    });
  }

  void _nextStage() {
    if (_currentStageIndex >= _totalStages - 1) {
      return;
    }

    if (_graphWidget == null) {
      _initGraphWidget();
    }

    final newStage = widget.stages[_currentStageIndex + 1];

    setState(() {
      _currentStageIndex++;
      _graphWidget!.replaceGraphModel(newStage.graphModel);
      _currentStage = newStage;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.widthOf(context) <= GSettings.maxPhoneWidth;

    final sidePadding = isMobile ? 8.0 : 16.0;
    final topPadding = isMobile ? 8.0 : 16.0 + 64;
    final bottomPadding = isMobile ? 8.0 : 16.0 + 64;
    final rightPadding = isMobile ? 8.0 : GSettings.maxDialogWidth + 16 + 16;
    final maxDialogWidth = isMobile
        ? double.infinity
        : GSettings.maxDialogWidth;

    final onBack = _currentStageIndex > 0 ? _previousStage : null;

    final onNext = _currentStage?.maybeMap(
      question: (value) => () {
        if (!_validate(value.correctAnswer)) {
          return;
        }

        return _currentStageIndex < _totalStages - 1
            ? _nextStage()
            : widget.onFinish();
      },
      orElse: () =>
          _currentStageIndex < _totalStages - 1 ? _nextStage : widget.onFinish,
    );

    return Material(
      child: Stack(
        children: [
          if (_graphWidget != null)
            Positioned.fill(
              child: Padding(
                padding: EdgeInsets.only(
                  top: topPadding,
                  right: rightPadding,
                  bottom: bottomPadding,
                  left: sidePadding,
                ),
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 500),
                  reverseDuration: const Duration(milliseconds: 500),
                  child: GameWidget(game: _graphWidget!),
                ),
              ),
            ),
          Positioned(
            top: 16,
            left: 16,
            child: GBackButton(
              onTap: widget.onBackTap ?? AppNavigator.openLevels,
            ),
          ),
          if (!isMobile)
            Positioned(
              top: 0,
              right: 16,
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: maxDialogWidth,
                  maxHeight: MediaQuery.sizeOf(context).height,
                ),
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  primary: false,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    spacing: 8,
                    children: [
                      _InfoCardWidget(
                        title: widget.stages[_currentStageIndex].title,
                        text: widget.stages[_currentStageIndex].text,
                        richText: widget.stages[_currentStageIndex].richText,
                      ),
                      if (_totalStages > 1)
                        _StepButtonWidget(
                          currentStage: _currentStageIndex,
                          totalStages: _totalStages,
                          onBack: onBack,
                          onNext: onNext,
                        ),
                      if (_currentStage != null)
                        _currentStage?.mapOrNull(
                              question: (data) => _QuestionStageWidget(
                                answerHint: data.answerHint ?? '',
                                correctAnswer: data.correctAnswer,
                                onChanged: (value) => setState(() {
                                  _questionInput = int.tryParse(value);
                                }),
                                errorText: _errorText,
                              ),
                            ) ??
                            SizedBox.shrink(),
                    ],
                  ),
                ),
              ),
            ),
          if (isMobile)
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: SafeArea(
                top: false,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 8,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _InfoCardWidget(
                        title: widget.stages[_currentStageIndex].title,
                        text: widget.stages[_currentStageIndex].text,
                        richText: widget.stages[_currentStageIndex].richText,
                      ),
                      if (_totalStages > 1)
                        _StepButtonWidget(
                          currentStage: _currentStageIndex,
                          totalStages: _totalStages,
                          onBack: onBack,
                          onNext: onNext,
                        ),
                      if (_currentStage != null)
                        _currentStage?.mapOrNull(
                              question: (data) => _QuestionStageWidget(
                                answerHint: data.answerHint ?? '',
                                correctAnswer: data.correctAnswer,
                                onChanged: (value) => setState(() {
                                  _questionInput = int.tryParse(value);
                                }),
                                errorText: _errorText,
                              ),
                            ) ??
                            SizedBox.shrink(),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _QuestionStageWidget extends StatelessWidget {
  final String answerHint;
  final int correctAnswer;
  final void Function(String) onChanged;
  final String? errorText;

  const _QuestionStageWidget({
    required this.answerHint,
    required this.correctAnswer,
    required this.onChanged,
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: TextFormField(
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
          ],
          onChanged: onChanged,
          decoration: InputDecoration(
            labelText: answerHint,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            errorText: errorText,
          ),
        ),
      ),
    );
  }
}
