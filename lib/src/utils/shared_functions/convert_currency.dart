
String convertCurrency(String? currency){
  if(currency == "USD"){
    return "\$";
  }else if(currency == "GBP" || currency == "GB"){
    return "£";
  }else if(currency == "NGN"){
    return "₦";
  }
  return "\$";
}