import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../.gen/i18n/strings.g.dart';
import '../../graph/ui/info_card.dart';
import '../../graph/ui/step_button.dart';
import '../../settings.dart';

class SecondLevelInfo extends StatefulWidget {
  final int initialStageIndex;
  final int totalStages;

  final String title;
  final String? text;
  final TextSpan? richText;

  final void Function(int stageIndex) onStageChanged;
  final void Function() onComplete;

  const SecondLevelInfo({
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
  State<SecondLevelInfo> createState() => _SecondLevelInfoState();
}

class _SecondLevelInfoState extends State<SecondLevelInfo> {
  int _currentStageIndex = 0;
  int? _enteredConnectivityComponents;
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

  void _finalStage() {
    if (_enteredConnectivityComponents == null) {
      _errorText = context.t.strings.enterNumber;
      setState(() {});
      return;
    }

    if (_enteredConnectivityComponents != 4) {
      _errorText = context.t.strings.wrongAnswer;
      setState(() {});
      return;
    }

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
              3 => _enteredConnectivityComponents == null ? null : _finalStage,
              _ => _nextStage,
            },
          ),
          if (_currentStageIndex == 3)
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
                        _enteredConnectivityComponents = null;
                        setState(() {});
                        return;
                      }
                      _enteredConnectivityComponents = int.tryParse(value);
                      setState(() {});
                    },
                    decoration: InputDecoration(
                      labelText:
                          context.t.strings.enterNumberOfConnectivityComponents,
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
