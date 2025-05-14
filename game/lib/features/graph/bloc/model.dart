import 'package:freezed_annotation/freezed_annotation.dart';

part '../../../.gen/features/graph/bloc/model.freezed.dart';

@freezed
class GraphModel with _$GraphModel {
  factory GraphModel({
    required List<List<int>> adjacencyMatrix,
  }) = _GraphModel;
}
