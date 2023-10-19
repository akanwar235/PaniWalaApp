import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_item_cart_dto.freezed.dart';
part 'update_item_cart_dto.g.dart';

@freezed
class UpdateItemCartDto with _$UpdateItemCartDto {
  const UpdateItemCartDto._();

  const factory UpdateItemCartDto({
    required int userId,
    required int productId,
    required int quantity,
    @Default("updateQuantity")
     String type,
  }) = _UpdateItemCartDto;

  factory UpdateItemCartDto.fromJson(Map<String, dynamic> json) =>
      _$UpdateItemCartDtoFromJson(json);
}
