String hashCardNo(String text) {
  String newString = "";
  for (var i = 0; i < text.length; i++) {
    if (i == text.length - 4) {
      newString += " ${text.substring(i)}";
      break;
    } else if (i % 4 == 0) {
      newString += " *";
    } else {
      newString += "*";
    }
  }
  return newString;
}
