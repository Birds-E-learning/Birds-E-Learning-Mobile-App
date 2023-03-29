import 'package:birds_learning_network/src/features/modules/profile/model/repository/profile_repository.dart';
import 'package:birds_learning_network/src/features/modules/profile/model/request_model/add_card_model.dart';
import 'package:birds_learning_network/src/features/modules/profile/model/response_model/delete_card_response.dart';
import 'package:birds_learning_network/src/features/modules/profile/model/response_model/get_card_response.dart';
import 'package:birds_learning_network/src/utils/helper_widgets/response_snack.dart';
import 'package:birds_learning_network/src/utils/ui_utils/app_dialogs/success_dialog.dart';
import 'package:flutter/material.dart';

class CardProvider extends ChangeNotifier {
  bool _addClicked = false;
  List<CardResponseData> cardList = [];
  ProfileRepository repo = ProfileRepository();
  int _currentPosition = 0;
  bool _confirmClicked = false;

  bool get confirmClicked => _confirmClicked;
  set resetCurrentPosition(value) => _currentPosition = value;
  bool get addClicked => _addClicked;
  int get currentPosition => _currentPosition;

  void onAddClick() {
    _addClicked = !_addClicked;
    notifyListeners();
  }

  void onConfirmClick() {
    _confirmClicked = !_confirmClicked;
    notifyListeners();
  }

  void getCurrentPosition(int value) {
    _currentPosition = value;
    notifyListeners();
  }

  Future addCardRequest(context, String cardNo, String date, String cvv) async {
    try {
      AddCardModel data =
          AddCardModel(cardNo: cardNo, expiryDate: date, cvv: cvv);
      String response = await repo.addUserCardDetails(context, data);
      if (response == "00") {
        addClicked ? onAddClick() : null;
        await getAllDebitCards(context);
        successDialog(
            context, "Successful!", "Debit Card successfuly added", "OK", () {
          Navigator.pop(context);
          Navigator.pop(context);
        });
      }
    } catch (e) {
      // print(e);
      addClicked ? onAddClick() : null;
    }
  }

  Future getAllDebitCards(context) async {
    try {
      List<CardResponseData> response = await repo.getAlllDebitCard(context);
      cardList = response;
      notifyListeners();
    } catch (e) {
      throw Exception(e);
    }
  }

  Future deleteCard(context, String cardNo) async {
    try {
      DeleteCardResponse response = await repo.deleteDebitCard(context, cardNo);
      if (response.responseCode == "00") {
        _currentPosition = 0;
        await getAllDebitCards(context);
        confirmClicked ? onConfirmClick() : null;
        Navigator.pop(context);
        Navigator.pop(context);
      } else {
        confirmClicked ? onConfirmClick() : null;
        showSnack(context, response.responseCode!, response.responseMessage!);
      }
    } catch (e) {
      confirmClicked ? onConfirmClick() : null;
      throw Exception(e);
    }
  }
}
