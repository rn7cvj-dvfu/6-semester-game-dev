import 'package:freezed_annotation/freezed_annotation.dart';

part '../../../.gen/features/graph/bloc/placement.freezed.dart';

@freezed
class GraphNodesPlacement with _$GraphNodesPlacement {
  const factory GraphNodesPlacement.circle({double? radius}) = _Circle;
  const factory GraphNodesPlacement.random({@Default(42.0) double seed}) =
      _Random;
  const factory GraphNodesPlacement.tree({required String topNodeId}) = _Tree;
}
