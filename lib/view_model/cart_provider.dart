import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:water_order/dtos/cart/add_item_cart_dto.dart';
import 'package:water_order/dtos/cart/fetch_cart_item_dto.dart';
import 'package:water_order/dtos/cart/remove_item_cart_dto.dart';
import 'package:water_order/dtos/cart/update_item_cart_dto.dart';
import 'package:water_order/models/product_model.dart';
import 'package:water_order/services/module.dart';
import 'package:water_order/utils/global.dart';
import 'package:water_order/widget/snakbar.dart';

/// state notifier provider
final cartSNProvider =
    StateNotifierProvider<CartProvider, List<ProductModel>>((ref) {
  return CartProvider(ref);
});

class CartProvider extends StateNotifier<List<ProductModel>> {
  final Ref _ref;
  CartProvider(this._ref) : super([]) {
    loadCartItemList();
  }

  late final _cartService = _ref.read(cartServiceProvider);
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
  }

  Future<void> loadCartItemList() async {
    isLoading = true;
    FetchCardItemDto dto = FetchCardItemDto(userId: VarGlobal.userId!);
    print("loadCartItemList started".toUpperCase());
    await _cartService.fetchCartItem(dto).then(
      (value) {
        value.fold(
          (l) {
            return showCustomSnackBar(l.message);
          },
          (r) {
            state = r;
          },
        );
      },
    );
    print("loadCartItemList ended".toUpperCase());
    isLoading = false;
  }

  addItemIntocart(ProductModel item) async {
    final AddItemCartDto dto = AddItemCartDto(
        userId: VarGlobal.userId!,
        productId: item.product_id!,
        quantity: item.quantity);
    await _ref.read(cartServiceProvider).addToCart(dto).then(
          (value) => value.fold(
            (l) => showCustomSnackBar(l.message),
            (r) async {
              loadCartItemList();
              showCustomSnackBar("Item Added to Cart");
            },
          ),
        );
  }

  removeItemFromCart(ProductModel item) async {
    final RemoveItemCartDto dto = RemoveItemCartDto(
        userId: VarGlobal.userId!, productId: item.product_id!);
    await _ref.read(cartServiceProvider).removeFromCart(dto).then(
          (value) => value.fold(
            (l) => showCustomSnackBar(l.message),
            (r) {
              state = [
                ...state
                    .where((element) => element.product_id != item.product_id)
              ];
              showCustomSnackBar("Item Removed");
            },
          ),
        );
  }

  updateItemCountIntoCart(ProductModel item) async {
    final UpdateItemCartDto dto = UpdateItemCartDto(
        userId: VarGlobal.userId!,
        productId: item.product_id!,
        quantity: item.quantity);
    await _ref.read(cartServiceProvider).updateItemCount(dto).then(
          (value) => value.fold(
            (l) => showCustomSnackBar(l.message),
            (r) {
              int index = state.indexWhere(
                  (element) => element.product_id == item.product_id);
              state[index] = state[index].copyWith(quantity: item.quantity);
            },
          ),
        );
  }
}
