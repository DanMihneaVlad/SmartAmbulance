// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'patient_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PatientModel _$PatientModelFromJson(Map<String, dynamic> json) {
  return _PatientModel.fromJson(json);
}

/// @nodoc
mixin _$PatientModel {
  String get uid => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get cnp => throw _privateConstructorUsedError;
  String get diagnostic => throw _privateConstructorUsedError;
  String get imageUrl => throw _privateConstructorUsedError;
  String get paramedicName => throw _privateConstructorUsedError;
  String get destinationHospital => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PatientModelCopyWith<PatientModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PatientModelCopyWith<$Res> {
  factory $PatientModelCopyWith(
          PatientModel value, $Res Function(PatientModel) then) =
      _$PatientModelCopyWithImpl<$Res, PatientModel>;
  @useResult
  $Res call(
      {String uid,
      String name,
      String cnp,
      String diagnostic,
      String imageUrl,
      String paramedicName,
      String destinationHospital});
}

/// @nodoc
class _$PatientModelCopyWithImpl<$Res, $Val extends PatientModel>
    implements $PatientModelCopyWith<$Res> {
  _$PatientModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uid = null,
    Object? name = null,
    Object? cnp = null,
    Object? diagnostic = null,
    Object? imageUrl = null,
    Object? paramedicName = null,
    Object? destinationHospital = null,
  }) {
    return _then(_value.copyWith(
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      cnp: null == cnp
          ? _value.cnp
          : cnp // ignore: cast_nullable_to_non_nullable
              as String,
      diagnostic: null == diagnostic
          ? _value.diagnostic
          : diagnostic // ignore: cast_nullable_to_non_nullable
              as String,
      imageUrl: null == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      paramedicName: null == paramedicName
          ? _value.paramedicName
          : paramedicName // ignore: cast_nullable_to_non_nullable
              as String,
      destinationHospital: null == destinationHospital
          ? _value.destinationHospital
          : destinationHospital // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PatientModelImplCopyWith<$Res>
    implements $PatientModelCopyWith<$Res> {
  factory _$$PatientModelImplCopyWith(
          _$PatientModelImpl value, $Res Function(_$PatientModelImpl) then) =
      __$$PatientModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String uid,
      String name,
      String cnp,
      String diagnostic,
      String imageUrl,
      String paramedicName,
      String destinationHospital});
}

/// @nodoc
class __$$PatientModelImplCopyWithImpl<$Res>
    extends _$PatientModelCopyWithImpl<$Res, _$PatientModelImpl>
    implements _$$PatientModelImplCopyWith<$Res> {
  __$$PatientModelImplCopyWithImpl(
      _$PatientModelImpl _value, $Res Function(_$PatientModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uid = null,
    Object? name = null,
    Object? cnp = null,
    Object? diagnostic = null,
    Object? imageUrl = null,
    Object? paramedicName = null,
    Object? destinationHospital = null,
  }) {
    return _then(_$PatientModelImpl(
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      cnp: null == cnp
          ? _value.cnp
          : cnp // ignore: cast_nullable_to_non_nullable
              as String,
      diagnostic: null == diagnostic
          ? _value.diagnostic
          : diagnostic // ignore: cast_nullable_to_non_nullable
              as String,
      imageUrl: null == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      paramedicName: null == paramedicName
          ? _value.paramedicName
          : paramedicName // ignore: cast_nullable_to_non_nullable
              as String,
      destinationHospital: null == destinationHospital
          ? _value.destinationHospital
          : destinationHospital // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PatientModelImpl implements _PatientModel {
  const _$PatientModelImpl(
      {required this.uid,
      required this.name,
      required this.cnp,
      required this.diagnostic,
      required this.imageUrl,
      required this.paramedicName,
      required this.destinationHospital});

  factory _$PatientModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$PatientModelImplFromJson(json);

  @override
  final String uid;
  @override
  final String name;
  @override
  final String cnp;
  @override
  final String diagnostic;
  @override
  final String imageUrl;
  @override
  final String paramedicName;
  @override
  final String destinationHospital;

  @override
  String toString() {
    return 'PatientModel(uid: $uid, name: $name, cnp: $cnp, diagnostic: $diagnostic, imageUrl: $imageUrl, paramedicName: $paramedicName, destinationHospital: $destinationHospital)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PatientModelImpl &&
            (identical(other.uid, uid) || other.uid == uid) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.cnp, cnp) || other.cnp == cnp) &&
            (identical(other.diagnostic, diagnostic) ||
                other.diagnostic == diagnostic) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.paramedicName, paramedicName) ||
                other.paramedicName == paramedicName) &&
            (identical(other.destinationHospital, destinationHospital) ||
                other.destinationHospital == destinationHospital));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, uid, name, cnp, diagnostic,
      imageUrl, paramedicName, destinationHospital);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PatientModelImplCopyWith<_$PatientModelImpl> get copyWith =>
      __$$PatientModelImplCopyWithImpl<_$PatientModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PatientModelImplToJson(
      this,
    );
  }
}

abstract class _PatientModel implements PatientModel {
  const factory _PatientModel(
      {required final String uid,
      required final String name,
      required final String cnp,
      required final String diagnostic,
      required final String imageUrl,
      required final String paramedicName,
      required final String destinationHospital}) = _$PatientModelImpl;

  factory _PatientModel.fromJson(Map<String, dynamic> json) =
      _$PatientModelImpl.fromJson;

  @override
  String get uid;
  @override
  String get name;
  @override
  String get cnp;
  @override
  String get diagnostic;
  @override
  String get imageUrl;
  @override
  String get paramedicName;
  @override
  String get destinationHospital;
  @override
  @JsonKey(ignore: true)
  _$$PatientModelImplCopyWith<_$PatientModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
