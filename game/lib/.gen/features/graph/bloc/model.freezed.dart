// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of '../../../../features/graph/bloc/model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$GraphModel {
  List<NodeModel> get nodes => throw _privateConstructorUsedError;
  List<EdgeModel> get edges => throw _privateConstructorUsedError;
  bool get movable => throw _privateConstructorUsedError;
  bool get clickable => throw _privateConstructorUsedError;

  /// Create a copy of GraphModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GraphModelCopyWith<GraphModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GraphModelCopyWith<$Res> {
  factory $GraphModelCopyWith(
          GraphModel value, $Res Function(GraphModel) then) =
      _$GraphModelCopyWithImpl<$Res, GraphModel>;
  @useResult
  $Res call(
      {List<NodeModel> nodes,
      List<EdgeModel> edges,
      bool movable,
      bool clickable});
}

/// @nodoc
class _$GraphModelCopyWithImpl<$Res, $Val extends GraphModel>
    implements $GraphModelCopyWith<$Res> {
  _$GraphModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GraphModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? nodes = null,
    Object? edges = null,
    Object? movable = null,
    Object? clickable = null,
  }) {
    return _then(_value.copyWith(
      nodes: null == nodes
          ? _value.nodes
          : nodes // ignore: cast_nullable_to_non_nullable
              as List<NodeModel>,
      edges: null == edges
          ? _value.edges
          : edges // ignore: cast_nullable_to_non_nullable
              as List<EdgeModel>,
      movable: null == movable
          ? _value.movable
          : movable // ignore: cast_nullable_to_non_nullable
              as bool,
      clickable: null == clickable
          ? _value.clickable
          : clickable // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GraphModelImplCopyWith<$Res>
    implements $GraphModelCopyWith<$Res> {
  factory _$$GraphModelImplCopyWith(
          _$GraphModelImpl value, $Res Function(_$GraphModelImpl) then) =
      __$$GraphModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<NodeModel> nodes,
      List<EdgeModel> edges,
      bool movable,
      bool clickable});
}

/// @nodoc
class __$$GraphModelImplCopyWithImpl<$Res>
    extends _$GraphModelCopyWithImpl<$Res, _$GraphModelImpl>
    implements _$$GraphModelImplCopyWith<$Res> {
  __$$GraphModelImplCopyWithImpl(
      _$GraphModelImpl _value, $Res Function(_$GraphModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of GraphModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? nodes = null,
    Object? edges = null,
    Object? movable = null,
    Object? clickable = null,
  }) {
    return _then(_$GraphModelImpl(
      nodes: null == nodes
          ? _value._nodes
          : nodes // ignore: cast_nullable_to_non_nullable
              as List<NodeModel>,
      edges: null == edges
          ? _value._edges
          : edges // ignore: cast_nullable_to_non_nullable
              as List<EdgeModel>,
      movable: null == movable
          ? _value.movable
          : movable // ignore: cast_nullable_to_non_nullable
              as bool,
      clickable: null == clickable
          ? _value.clickable
          : clickable // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$GraphModelImpl implements _GraphModel {
  _$GraphModelImpl(
      {required final List<NodeModel> nodes,
      required final List<EdgeModel> edges,
      this.movable = false,
      this.clickable = false})
      : _nodes = nodes,
        _edges = edges;

  final List<NodeModel> _nodes;
  @override
  List<NodeModel> get nodes {
    if (_nodes is EqualUnmodifiableListView) return _nodes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_nodes);
  }

  final List<EdgeModel> _edges;
  @override
  List<EdgeModel> get edges {
    if (_edges is EqualUnmodifiableListView) return _edges;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_edges);
  }

  @override
  @JsonKey()
  final bool movable;
  @override
  @JsonKey()
  final bool clickable;

  @override
  String toString() {
    return 'GraphModel(nodes: $nodes, edges: $edges, movable: $movable, clickable: $clickable)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GraphModelImpl &&
            const DeepCollectionEquality().equals(other._nodes, _nodes) &&
            const DeepCollectionEquality().equals(other._edges, _edges) &&
            (identical(other.movable, movable) || other.movable == movable) &&
            (identical(other.clickable, clickable) ||
                other.clickable == clickable));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_nodes),
      const DeepCollectionEquality().hash(_edges),
      movable,
      clickable);

  /// Create a copy of GraphModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GraphModelImplCopyWith<_$GraphModelImpl> get copyWith =>
      __$$GraphModelImplCopyWithImpl<_$GraphModelImpl>(this, _$identity);
}

abstract class _GraphModel implements GraphModel {
  factory _GraphModel(
      {required final List<NodeModel> nodes,
      required final List<EdgeModel> edges,
      final bool movable,
      final bool clickable}) = _$GraphModelImpl;

  @override
  List<NodeModel> get nodes;
  @override
  List<EdgeModel> get edges;
  @override
  bool get movable;
  @override
  bool get clickable;

  /// Create a copy of GraphModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GraphModelImplCopyWith<_$GraphModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$NodeModel {
  String get id => throw _privateConstructorUsedError;

  /// Create a copy of NodeModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $NodeModelCopyWith<NodeModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NodeModelCopyWith<$Res> {
  factory $NodeModelCopyWith(NodeModel value, $Res Function(NodeModel) then) =
      _$NodeModelCopyWithImpl<$Res, NodeModel>;
  @useResult
  $Res call({String id});
}

/// @nodoc
class _$NodeModelCopyWithImpl<$Res, $Val extends NodeModel>
    implements $NodeModelCopyWith<$Res> {
  _$NodeModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of NodeModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NodeModelImplCopyWith<$Res>
    implements $NodeModelCopyWith<$Res> {
  factory _$$NodeModelImplCopyWith(
          _$NodeModelImpl value, $Res Function(_$NodeModelImpl) then) =
      __$$NodeModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id});
}

/// @nodoc
class __$$NodeModelImplCopyWithImpl<$Res>
    extends _$NodeModelCopyWithImpl<$Res, _$NodeModelImpl>
    implements _$$NodeModelImplCopyWith<$Res> {
  __$$NodeModelImplCopyWithImpl(
      _$NodeModelImpl _value, $Res Function(_$NodeModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of NodeModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
  }) {
    return _then(_$NodeModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$NodeModelImpl implements _NodeModel {
  _$NodeModelImpl({required this.id});

  @override
  final String id;

  @override
  String toString() {
    return 'NodeModel(id: $id)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NodeModelImpl &&
            (identical(other.id, id) || other.id == id));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id);

  /// Create a copy of NodeModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NodeModelImplCopyWith<_$NodeModelImpl> get copyWith =>
      __$$NodeModelImplCopyWithImpl<_$NodeModelImpl>(this, _$identity);
}

abstract class _NodeModel implements NodeModel {
  factory _NodeModel({required final String id}) = _$NodeModelImpl;

  @override
  String get id;

  /// Create a copy of NodeModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NodeModelImplCopyWith<_$NodeModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$EdgeModel {
  String get id => throw _privateConstructorUsedError;
  String get firstNodeId => throw _privateConstructorUsedError;
  String get secondNodeId => throw _privateConstructorUsedError;

  /// Create a copy of EdgeModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EdgeModelCopyWith<EdgeModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EdgeModelCopyWith<$Res> {
  factory $EdgeModelCopyWith(EdgeModel value, $Res Function(EdgeModel) then) =
      _$EdgeModelCopyWithImpl<$Res, EdgeModel>;
  @useResult
  $Res call({String id, String firstNodeId, String secondNodeId});
}

/// @nodoc
class _$EdgeModelCopyWithImpl<$Res, $Val extends EdgeModel>
    implements $EdgeModelCopyWith<$Res> {
  _$EdgeModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of EdgeModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? firstNodeId = null,
    Object? secondNodeId = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      firstNodeId: null == firstNodeId
          ? _value.firstNodeId
          : firstNodeId // ignore: cast_nullable_to_non_nullable
              as String,
      secondNodeId: null == secondNodeId
          ? _value.secondNodeId
          : secondNodeId // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$EdgeModelImplCopyWith<$Res>
    implements $EdgeModelCopyWith<$Res> {
  factory _$$EdgeModelImplCopyWith(
          _$EdgeModelImpl value, $Res Function(_$EdgeModelImpl) then) =
      __$$EdgeModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String firstNodeId, String secondNodeId});
}

/// @nodoc
class __$$EdgeModelImplCopyWithImpl<$Res>
    extends _$EdgeModelCopyWithImpl<$Res, _$EdgeModelImpl>
    implements _$$EdgeModelImplCopyWith<$Res> {
  __$$EdgeModelImplCopyWithImpl(
      _$EdgeModelImpl _value, $Res Function(_$EdgeModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of EdgeModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? firstNodeId = null,
    Object? secondNodeId = null,
  }) {
    return _then(_$EdgeModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      firstNodeId: null == firstNodeId
          ? _value.firstNodeId
          : firstNodeId // ignore: cast_nullable_to_non_nullable
              as String,
      secondNodeId: null == secondNodeId
          ? _value.secondNodeId
          : secondNodeId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$EdgeModelImpl implements _EdgeModel {
  _$EdgeModelImpl(
      {required this.id,
      required this.firstNodeId,
      required this.secondNodeId});

  @override
  final String id;
  @override
  final String firstNodeId;
  @override
  final String secondNodeId;

  @override
  String toString() {
    return 'EdgeModel(id: $id, firstNodeId: $firstNodeId, secondNodeId: $secondNodeId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EdgeModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.firstNodeId, firstNodeId) ||
                other.firstNodeId == firstNodeId) &&
            (identical(other.secondNodeId, secondNodeId) ||
                other.secondNodeId == secondNodeId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, firstNodeId, secondNodeId);

  /// Create a copy of EdgeModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EdgeModelImplCopyWith<_$EdgeModelImpl> get copyWith =>
      __$$EdgeModelImplCopyWithImpl<_$EdgeModelImpl>(this, _$identity);
}

abstract class _EdgeModel implements EdgeModel {
  factory _EdgeModel(
      {required final String id,
      required final String firstNodeId,
      required final String secondNodeId}) = _$EdgeModelImpl;

  @override
  String get id;
  @override
  String get firstNodeId;
  @override
  String get secondNodeId;

  /// Create a copy of EdgeModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EdgeModelImplCopyWith<_$EdgeModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
