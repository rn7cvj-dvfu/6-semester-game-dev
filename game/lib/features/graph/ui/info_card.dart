import 'package:flutter/material.dart';

class InfoCardWidget extends StatefulWidget {
  final String title;
  final String text;

  const InfoCardWidget({
    super.key,
    required this.title,
    required this.text,
  });

  @override
  State<InfoCardWidget> createState() => _InfoCardWidgetState();
}

class _InfoCardWidgetState extends State<InfoCardWidget> {
  bool _isExpanded = true;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxWidth: 384,
        maxHeight: 384,
      ),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.only(
            top: 16,
            left: 16,
            right: 16,
          ),
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
                  duration: Duration(milliseconds: 300),
                  child: _isExpanded
                      ? Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Divider(),
                            Flexible(
                              child: SingleChildScrollView(
                                primary: false,
                                padding: EdgeInsets.only(
                                  right: 16,
                                  bottom: 16,
                                ),
                                child: Text(widget.text),
                              ),
                            ),
                          ],
                        )
                      : SizedBox(
                          height: 16,
                          width: double.infinity,
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
