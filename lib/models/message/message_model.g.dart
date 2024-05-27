// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MessageModelImpl _$$MessageModelImplFromJson(Map<String, dynamic> json) =>
    _$MessageModelImpl(
      senderUid: json['senderUid'] as String,
      senderEmail: json['senderEmail'] as String,
      receiverUid: json['receiverUid'] as String,
      message: json['message'] as String,
      timestamp: const TimestampSerializer().fromJson(json['timestamp']),
    );

Map<String, dynamic> _$$MessageModelImplToJson(_$MessageModelImpl instance) =>
    <String, dynamic>{
      'senderUid': instance.senderUid,
      'senderEmail': instance.senderEmail,
      'receiverUid': instance.receiverUid,
      'message': instance.message,
      'timestamp': const TimestampSerializer().toJson(instance.timestamp),
    };
