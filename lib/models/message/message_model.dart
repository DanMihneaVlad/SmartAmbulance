import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:smart_ambulance/models/serializers/timestamp_serializer.dart';

part 'message_model.freezed.dart';
part 'message_model.g.dart';

@unfreezed
class MessageModel with _$MessageModel {
  factory MessageModel({
    required String senderUid,
    required String senderEmail,
    required String receiverUid,
    required String message,
    @TimestampSerializer() required DateTime timestamp,
  }) = _MessageModel;

  factory MessageModel.fromJson(Map<String, dynamic> json) => _$MessageModelFromJson(json);
}