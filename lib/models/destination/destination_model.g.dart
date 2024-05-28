// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'destination_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DestinationModelImpl _$$DestinationModelImplFromJson(
        Map<String, dynamic> json) =>
    _$DestinationModelImpl(
      uid: json['uid'] as String,
      userUid: json['userUid'] as String,
      hospitalUid: json['hospitalUid'] as String,
      latStart: (json['latStart'] as num).toDouble(),
      lngStart: (json['lngStart'] as num).toDouble(),
      latCurrent: (json['latCurrent'] as num).toDouble(),
      lngCurrent: (json['lngCurrent'] as num).toDouble(),
      latDestination: (json['latDestination'] as num).toDouble(),
      lngDestination: (json['lngDestination'] as num).toDouble(),
      paramedicName: json['paramedicName'] as String,
    );

Map<String, dynamic> _$$DestinationModelImplToJson(
        _$DestinationModelImpl instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'userUid': instance.userUid,
      'hospitalUid': instance.hospitalUid,
      'latStart': instance.latStart,
      'lngStart': instance.lngStart,
      'latCurrent': instance.latCurrent,
      'lngCurrent': instance.lngCurrent,
      'latDestination': instance.latDestination,
      'lngDestination': instance.lngDestination,
      'paramedicName': instance.paramedicName,
    };
