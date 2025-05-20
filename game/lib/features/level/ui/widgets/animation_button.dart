part of '../widget.dart';

class _AnimationButtonWidget extends StatelessWidget {
  final VoidCallback? onPlay;
  final VoidCallback? onPause;

  const _AnimationButtonWidget({super.key, this.onPlay, this.onPause});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: GSettings.maxDialogWidth),
      child: IntrinsicHeight(
        child: Row(
          spacing: 8,
          children: [
            Expanded(
              child: ElevatedButton.icon(
                onPressed: onPlay,
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12), // как у Card
                  ),
                ),
                icon: const Icon(Icons.play_arrow),
                label: Text(
                  context.t.strings.common.playAnimation,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Expanded(
              child: ElevatedButton.icon(
                onPressed: onPause,
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12), // как у Card
                  ),
                ),
                icon: const Icon(Icons.stop),
                label: Text(
                  context.t.strings.common.stopAnimation,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
