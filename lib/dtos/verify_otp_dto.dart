import 'package:freezed_annotation/freezed_annotation.dart';

part 'verify_otp_dto.freezed.dart';
part 'verify_otp_dto.g.dart';

@freezed
class VerifyOtpDto with _$VerifyOtpDto {
  const factory VerifyOtpDto({required String phone, required int otp}) =
      _VerifyOtpDto;


  factory VerifyOtpDto.fromJson(Map<String, dynamic> json) =>
      _$VerifyOtpDtoFromJson(json);
}
