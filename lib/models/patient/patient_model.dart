import 'package:freezed_annotation/freezed_annotation.dart';

part 'patient_model.freezed.dart';
part 'patient_model.g.dart';

@freezed
class PatientModel with _$PatientModel {
  const factory PatientModel({
    required String uid,
    required String name,
    required String cnp,
    required String diagnostic,
    required String imageUrl,
    required String paramedicName,
    required String destinationHospital,
  }) = _PatientModel;

  factory PatientModel.fromJson(Map<String, dynamic> json) => _$PatientModelFromJson(json);
}