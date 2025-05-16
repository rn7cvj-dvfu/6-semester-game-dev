import 'package:flutter/material.dart';

import '../../../.gen/i18n/strings.g.dart';
import '../widget.dart';

const List<Color> _colors = [
  Colors.white,
  Colors.amber,
  Colors.purple,
  Colors.lightGreen,
  Colors.lime,
];

class SeedColorToggle extends StatelessWidget {
  const SeedColorToggle({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = GTheme.of(context);

    return LayoutBuilder(
      builder: (_, constraints) {
        final padding = 16.0;
        final dimension =
            (constraints.maxWidth - padding * (_colors.length - 1)) /
            _colors.length;

        return Column(
          children: [
            ListTile(title: Text(context.t.strings.useSeedColor)),
            Row(
              children: List.generate(_colors.length, (index) {
                final color = _colors[index];
                final isSelected = theme.seedColor == color;

                return Padding(
                  padding: EdgeInsets.only(
                    right: index == _colors.length - 1 ? 0 : padding,
                  ),
                  child: _ColorCard(
                    color: color,
                    checkColor: isSelected ? Colors.black : Colors.transparent,
                    onTap: () => theme.toggleSeedColor(color),
                    dimension: dimension,
                  ),
                );
              }),
            ),
          ],
        );
      },
    );
  }
}

class _ColorCard extends StatelessWidget {
  final Color color;
  final Color checkColor;
  final VoidCallback onTap;
  final double dimension;

  const _ColorCard({
    required this.color,
    required this.checkColor,
    required this.onTap,
    required this.dimension,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      margin: EdgeInsets.zero,
      color: color,
      child: InkWell(
        onTap: onTap,
        child: SizedBox.square(
          dimension: dimension,
          child: Center(
            child: Icon(Icons.check, color: checkColor, size: dimension / 2),
          ),
        ),
      ),
    );
  }
}
