// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patient_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PatientModelImpl _$$PatientModelImplFromJson(Map<String, dynamic> json) =>
    _$PatientModelImpl(
      uid: json['uid'] as String,
      name: json['name'] as String,
      cnp: json['cnp'] as String,
      diagnostic: json['diagnostic'] as String,
      imageUrl: json['imageUrl'] as String,
      paramedicName: json['paramedicName'] as String,
      destinationHospital: json['destinationHospital'] as String,
      timestamp: const TimestampSerializer().fromJson(json['timestamp']),
    );

Map<String, dynamic> _$$PatientModelImplToJson(_$PatientModelImpl instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'name': instance.name,
      'cnp': instance.cnp,
      'diagnostic': instance.diagnostic,
      'imageUrl': instance.imageUrl,
      'paramedicName': instance.paramedicName,
      'destinationHospital': instance.destinationHospital,
      'timestamp': const TimestampSerializer().toJson(instance.timestamp),
    };
