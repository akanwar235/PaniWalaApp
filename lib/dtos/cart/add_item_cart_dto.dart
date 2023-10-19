import 'package:freezed_annotation/freezed_annotation.dart';

part 'add_item_cart_dto.freezed.dart';
part 'add_item_cart_dto.g.dart';

@freezed
class AddItemCartDto with _$AddItemCartDto {
  const AddItemCartDto._();

  const factory AddItemCartDto({
    required int userId,
    required int productId,
    required int quantity,
    @Default("addProduct")
     String type,
  }) = _AddItemCartDto;

  factory AddItemCartDto.fromJson(Map<String, dynamic> json) =>
      _$AddItemCartDtoFromJson(json);
}
