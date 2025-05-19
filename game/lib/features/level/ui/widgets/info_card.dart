part of '../widget.dart';

class _InfoCardWidget extends StatefulWidget {
  final String title;
  final String? text;
  final InlineSpan? richText;

  const _InfoCardWidget({
    super.key,
    required this.title,
    this.text,
    this.richText,
  });

  @override
  State<_InfoCardWidget> createState() => _InfoCardWidgetState();
}

class _InfoCardWidgetState extends State<_InfoCardWidget> {
  bool _isExpanded = true;

  @override
  Widget build(BuildContext context) {
    assert(
      widget.text != null || widget.richText != null,
      'Either text or richText must be provided',
    );

    final textWidget = widget.text == null
        ? null
        : Text(
            widget.text ?? '',
            style: Theme.of(context).textTheme.bodyMedium,
          );

    final richTextWidget = widget.richText == null
        ? null
        : RichText(
            text: TextSpan(
              style: Theme.of(context).textTheme.bodyMedium,
              children: [widget.richText!],
            ),
          );

    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxWidth: GSettings.maxDialogWidth,
        maxHeight: GSettings.maxDialogHeight,
      ),
      child: Card(
        margin: EdgeInsets.zero,
        child: Padding(
          padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      widget.title,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      _isExpanded = !_isExpanded;
                      setState(() {});
                    },
                    icon: Icon(
                      _isExpanded ? Icons.expand_more : Icons.expand_less,
                    ),
                  ),
                ],
              ),
              Flexible(
                child: AnimatedSize(
                  duration: const Duration(milliseconds: 300),
                  alignment: Alignment.topCenter,
                  child: _isExpanded
                      ? Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Divider(),
                            SingleChildScrollView(
                              primary: false,
                              padding: const EdgeInsets.only(bottom: 16),
                              child:
                                  textWidget ??
                                  richTextWidget ??
                                  const SizedBox.shrink(),
                            ),
                          ],
                        )
                      : const SizedBox(height: 16, width: double.infinity),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
