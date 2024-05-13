import 'package:freezed_annotation/freezed_annotation.dart';

part 'hospital_model.freezed.dart';
part 'hospital_model.g.dart';

@freezed
class HospitalModel with _$HospitalModel {
  const factory HospitalModel({
    required String uid,
    required String name,
    required String address,
    required double lat,
    required double lng,
  }) = _HospitalModel;

  factory HospitalModel.fromJson(Map<String, dynamic> json) => _$HospitalModelFromJson(json);
}