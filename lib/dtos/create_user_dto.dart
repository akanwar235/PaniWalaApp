import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_user_dto.freezed.dart';
part 'create_user_dto.g.dart';

@freezed
class CreateUserDto with _$CreateUserDto {
  const CreateUserDto._();

  const factory CreateUserDto({
    required String phone,
    required String firstName,
    required String lastName,
    required String email,
  }) = _CreateUserDto;

  factory CreateUserDto.fromJson(Map<String, dynamic> json) =>
      _$CreateUserDtoFromJson(json);
}
