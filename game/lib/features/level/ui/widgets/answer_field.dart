part of '../widget.dart';

class _AnswerFieldWidget extends StatelessWidget {
  final String answerHint;
  final int correctAnswer;
  final void Function(String) onChanged;
  final String? errorText;

  const _AnswerFieldWidget({
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
