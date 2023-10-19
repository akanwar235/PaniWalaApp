import 'package:freezed_annotation/freezed_annotation.dart';

part 'remove_item_cart_dto.freezed.dart';
part 'remove_item_cart_dto.g.dart';

@freezed
class RemoveItemCartDto with _$RemoveItemCartDto {
  const RemoveItemCartDto._();

  const factory RemoveItemCartDto({
    required int userId,
    required int productId,
    @Default("removeProduct")
     String type,
  }) = _RemoveItemCartDto;

  factory RemoveItemCartDto.fromJson(Map<String, dynamic> json) =>
      _$RemoveItemCartDtoFromJson(json);
}
