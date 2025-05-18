import 'package:freezed_annotation/freezed_annotation.dart';

part '../../../.gen/features/graph/bloc/placement.freezed.dart';

@freezed
class GraphNodesPlacement with _$GraphNodesPlacement {
  const factory GraphNodesPlacement.circle({double? radius}) = _Circle;
  const factory GraphNodesPlacement.random() = _Random;
}
