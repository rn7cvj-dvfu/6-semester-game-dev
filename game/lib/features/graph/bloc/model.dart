import 'package:freezed_annotation/freezed_annotation.dart';

part '../../../.gen/features/graph/bloc/model.freezed.dart';

@freezed
class GraphModel with _$GraphModel {
  factory GraphModel({
    required List<NodeModel> nodes,
    required List<EdgeModel> edges,
    @Default(false) bool movable,
    @Default(false) bool clickable,
  }) = _GraphModel;
}

@freezed
class NodeModel with _$NodeModel {
  factory NodeModel({
    required String id,
  }) = _NodeModel;
}

@freezed
class EdgeModel with _$EdgeModel {
  factory EdgeModel({
    required String id,
    required String firstNodeId,
    required String secondNodeId,
  }) = _EdgeModel;
}
