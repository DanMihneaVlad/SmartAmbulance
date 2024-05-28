import 'package:freezed_annotation/freezed_annotation.dart';

part 'destination_model.freezed.dart';
part 'destination_model.g.dart';

@unfreezed
class DestinationModel with _$DestinationModel {
  factory DestinationModel({
    required String uid,
    required String userUid,
    required String hospitalUid,
    required double latStart,
    required double lngStart,
    required double latCurrent,
    required double lngCurrent,
    required double latDestination,
    required double lngDestination,
    required String paramedicName,
  }) = _DestinationModel;

  factory DestinationModel.fromJson(Map<String, dynamic> json) => _$DestinationModelFromJson(json);
}