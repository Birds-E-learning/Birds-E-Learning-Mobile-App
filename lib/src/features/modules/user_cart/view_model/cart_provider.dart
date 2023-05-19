import 'package:birds_learning_network/src/features/modules/home/model/response_model/get_courses.dart';
import 'package:birds_learning_network/src/features/modules/user_cart/model/repository/cart_repository.dart';
import 'package:birds_learning_network/src/features/modules/user_cart/model/response_model/general_response.dart';
import 'package:birds_learning_network/src/features/modules/user_cart/model/response_model/get_all_cart.dart';
import 'package:birds_learning_network/src/features/modules/user_cart/model/response_model/get_section.dart';
import 'package:birds_learning_network/src/utils/helper_widgets/response_snack.dart';
import 'package:birds_learning_network/src/utils/ui_utils/animations/favorite_toast.dart';
import 'package:birds_learning_network/src/utils/ui_utils/animations/unfavorite_toast.dart';
import 'package:birds_learning_network/src/utils/ui_utils/app_dialogs/success_dialog.dart';
import 'package:flutter/material.dart';

class CartProvider extends ChangeNotifier {
  CartRepository repo = CartRepository();
  List<Courses> _myCart = [];
  List<Courses> _wishlist = [];
  List<bool> selectedCart = [];
  List<bool> selectedWish = [];
  bool _cartClicked = false;
  bool _wishlistClicked = false;
  bool _removeCartIconClicked = false;
  bool _removewishIconClicked = false;
  bool isCartLoading = false;
  bool isWishlistLoading = false;

  List<Courses> get myCartList => _myCart;
  List<Courses> get wishlist => _wishlist;
  bool get cartClicked => _cartClicked;
  bool get wishlistClicked => _wishlistClicked;
  bool get removeCartIcon => _removeCartIconClicked;
  bool get removeWishIcon => _removewishIconClicked;

  void onCartClick() {
    _cartClicked = !_cartClicked;
    notifyListeners();
  }

  void onCartSelected(index) {
    selectedCart[index] = !selectedCart[index];
    notifyListeners();
  }

  void onWishSelected(index) {
    selectedWish[index] = !selectedWish[index];
    notifyListeners();
  }

  void onWishlistClick() {
    _wishlistClicked = !_wishlistClicked;
    notifyListeners();
  }

  void onRemoveCartIconClick() {
    _removeCartIconClicked = !_removeCartIconClicked;
    notifyListeners();
  }

  void onRemoveWishIconClick() {
    _removewishIconClicked = !_removewishIconClicked;
    notifyListeners();
  }

  void refreshList(context) async {
    await getAllCarts(context);
    await getAllWishlists(context);
  }

  Future getAllCarts(context) async {
    try {
      selectedCart = [];
      isCartLoading = true;
      GetCartResponse response = await repo.getCartService(context);
      if (response.responseCode == "00") {
        _myCart = response.responseData!;
        notifyListeners();
      } else {
        showSnack(context, response.responseCode!, response.responseMessage!);
      }
      isCartLoading = false;
    } catch (e) {
      isCartLoading = false;
      throw Exception(e);
    }
    notifyListeners();
  }

  Future getAllWishlists(context) async {
    try {
      selectedWish = [];
      isWishlistLoading = true;
      GetCartResponse response = await repo.getWishlistService(context);
      if (response.responseCode == "00") {
        _wishlist = response.responseData!;
        notifyListeners();
      } else {
        showSnack(context, response.responseCode!, response.responseMessage!);
      }
      isWishlistLoading = false;
    } catch (e) {
      isWishlistLoading = false;
      throw Exception(e);
    }
    notifyListeners();
  }

  Future addCart(context, String id) async {
    try {
      GeneralCartResponse response =
          await repo.addToCartService(context, id.toString());
      _cartClicked ? onCartClick() : null;
      if (response.responseCode == "00") {
        successDialog(context, response.responseMessage!,
            "Course successfully added to cart", "OK", () {
          Navigator.pop(context);
          Navigator.pop(context);
        });
      } else {
        showSnack(context, response.responseCode!, response.responseMessage!);
      }
      notifyListeners();
    } catch (e) {
      _cartClicked ? onCartClick() : null;
      throw Exception(e);
    }
  }

  Future addWishlist(context, String id, GlobalKey key, {page = "home"}) async {
    try {
      GeneralCartResponse response =
          await repo.addToWishlistService(context, id.toString());
      _wishlistClicked ? onWishlistClick() : null;
      if (response.responseCode == "00") {
        page == "home"
            ? showToast(context, key)
            : successDialog(context, "Success",
                "Course successfully added to wishlist", "OK", () {
                Navigator.pop(context);
                Navigator.pop(context);
              });
        // await Provider.of<HomeProvider>(context, listen: false)
        //     .refreshData(context, reload: false);
      } else {
        showSnack(context, response.responseCode!, response.responseMessage!);
      }
    } catch (e) {
      _wishlistClicked ? onWishlistClick() : null;
      throw Exception(e);
    }
  }

  Future deleteCart(context, String id, key) async {
    try {
      GeneralCartResponse response =
          await repo.deleteCartService(context, id.toString());
      _removeCartIconClicked ? onRemoveCartIconClick() : null;
      if (response.responseCode == "00") {
        showRemoveToast(context, key);
        await getAllCarts(context);
      } else {
        showSnack(context, response.responseCode!, response.responseMessage!);
      }
    } catch (e) {
      _removeCartIconClicked ? onRemoveCartIconClick() : null;
      throw Exception(e);
    }
  }

  Future deleteWishlist(context, String id, GlobalKey key,
      {page = "home"}) async {
    try {
      GeneralCartResponse response =
          await repo.deleteWishlistService(context, id.toString());
      _removewishIconClicked ? onRemoveWishIconClick() : null;
      _wishlistClicked ? onWishlistClick() : null;
      if (response.responseCode == "00") {
        page == "home"
            ? showRemoveToast(context, key)
            : successDialog(context, "Success",
                "Course successfully removed from wishlist", "OK", () {
                Navigator.pop(context);
              });
        await getAllWishlists(context);
      } else {
        showSnack(context, response.responseCode!, response.responseMessage!);
      }
    } catch (e) {
      _removewishIconClicked ? onRemoveWishIconClick() : null;
      throw Exception(e);
    }
  }

  Future getCourseSection(context, String id) async {
    try {
      GetCourseSection response = await repo.getPickedSections(context, id);
      if (response.responseCode == "00") {
        return response.responseData;
      } else {
        showSnack(context, response.responseCode!, response.responseMessage!);
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
