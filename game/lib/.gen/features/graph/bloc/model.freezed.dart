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
  List<List<int>> get adjacencyMatrix => throw _privateConstructorUsedError;

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
  $Res call({List<List<int>> adjacencyMatrix});
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
    Object? adjacencyMatrix = null,
  }) {
    return _then(_value.copyWith(
      adjacencyMatrix: null == adjacencyMatrix
          ? _value.adjacencyMatrix
          : adjacencyMatrix // ignore: cast_nullable_to_non_nullable
              as List<List<int>>,
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
  $Res call({List<List<int>> adjacencyMatrix});
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
    Object? adjacencyMatrix = null,
  }) {
    return _then(_$GraphModelImpl(
      adjacencyMatrix: null == adjacencyMatrix
          ? _value._adjacencyMatrix
          : adjacencyMatrix // ignore: cast_nullable_to_non_nullable
              as List<List<int>>,
    ));
  }
}

/// @nodoc

class _$GraphModelImpl implements _GraphModel {
  _$GraphModelImpl({required final List<List<int>> adjacencyMatrix})
      : _adjacencyMatrix = adjacencyMatrix;

  final List<List<int>> _adjacencyMatrix;
  @override
  List<List<int>> get adjacencyMatrix {
    if (_adjacencyMatrix is EqualUnmodifiableListView) return _adjacencyMatrix;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_adjacencyMatrix);
  }

  @override
  String toString() {
    return 'GraphModel(adjacencyMatrix: $adjacencyMatrix)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GraphModelImpl &&
            const DeepCollectionEquality()
                .equals(other._adjacencyMatrix, _adjacencyMatrix));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_adjacencyMatrix));

  /// Create a copy of GraphModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GraphModelImplCopyWith<_$GraphModelImpl> get copyWith =>
      __$$GraphModelImplCopyWithImpl<_$GraphModelImpl>(this, _$identity);
}

abstract class _GraphModel implements GraphModel {
  factory _GraphModel({required final List<List<int>> adjacencyMatrix}) =
      _$GraphModelImpl;

  @override
  List<List<int>> get adjacencyMatrix;

  /// Create a copy of GraphModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GraphModelImplCopyWith<_$GraphModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
