class CardValidator {
  cardNoValidator(String? value) {
    if (value!.isEmpty) {
      return "Card Number is required";
    } else if (value.length < 19) {
      return "Card Number must be 16-Digit";
    }
    return null;
  }

  dateValidator(String? value) {
    if (value!.isEmpty) {
      return "Expiry Date is required";
    } else if (value.length < 5) {
      return "A valid Date is required";
    }
    return null;
  }

  cvvValidator(String? value) {
    if (value!.isEmpty) {
      return "CVV is required";
    } else if (value.length < 3) {
      return "Enter a valid CVV";
    }
    return null;
  }

  pinValidator(String? value) {
    if (value!.isEmpty) {
      return "Pin is required";
    } else if (value.length < 4) {
      return "Enter a valid PIN";
    }
    return null;
  }
}
