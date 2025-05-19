import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../.gen/i18n/strings.g.dart';

import '../../settings.dart';
import '../widgets/info_card.dart';
import '../widgets/step_button.dart';

class ThirdLevelInfo extends StatefulWidget {
  final int initialStageIndex;
  final int totalStages;

  final String title;
  final String? text;
  final TextSpan? richText;

  final void Function(int stageIndex) onStageChanged;
  final void Function() onComplete;

  const ThirdLevelInfo({
    super.key,
    required this.title,
    this.text,
    this.richText,
    this.initialStageIndex = 0,
    required this.totalStages,
    required this.onStageChanged,
    required this.onComplete,
  });

  @override
  State<ThirdLevelInfo> createState() => _ThirdLevelInfoState();
}

class _ThirdLevelInfoState extends State<ThirdLevelInfo> {
  int _currentStageIndex = 0;
  int? _enteredLenPath;
  String? _errorText;

  @override
  void initState() {
    super.initState();
    _currentStageIndex = widget.initialStageIndex;
  }

  void _previousStage() {
    if (_currentStageIndex > 0) {
      _currentStageIndex--;
      setState(() {});
      widget.onStageChanged(_currentStageIndex);
    }
  }

  void _nextStage() {
    if (_currentStageIndex < widget.totalStages - 1) {
      _currentStageIndex++;
      setState(() {});
      widget.onStageChanged(_currentStageIndex);
    }
  }

  void _checkStage() {
    if (_enteredLenPath == null) {
      _errorText = context.t.strings.enterNumber;
      setState(() {});
      return;
    }

    if (_enteredLenPath != 5) {
      _errorText = context.t.strings.wrongAnswer;
      setState(() {});
      return;
    }

    // _nextStage();
    widget.onComplete();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      primary: false,
      padding: EdgeInsets.symmetric(vertical: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: 8,
        children: [
          InfoCardWidget(
            title: widget.title,
            text: widget.text,
            richText: widget.richText,
          ),
          StepButton(
            currentStage: _currentStageIndex,
            totalStages: widget.totalStages,
            onBack: _currentStageIndex == 0 ? null : _previousStage,
            onNext: switch (_currentStageIndex) {
              2 => _enteredLenPath == null ? null : _checkStage,
              _ => _nextStage,
            },
          ),
          if (_currentStageIndex == 2)
            ConstrainedBox(
              constraints: BoxConstraints(maxWidth: GSettings.maxDialogWidth),
              child: Card(
                margin: EdgeInsets.zero,
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 16,
                    left: 8,
                    right: 8,
                    bottom: 8,
                  ),
                  child: TextFormField(
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                    ],
                    onChanged: (value) {
                      _errorText = null;

                      if (value.isEmpty) {
                        _enteredLenPath = null;
                        setState(() {});
                        return;
                      }
                      _enteredLenPath = int.tryParse(value);
                      setState(() {});
                    },
                    decoration: InputDecoration(
                      labelText: context.t.strings.enterPathLength,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      errorText: _errorText,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
