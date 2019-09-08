import 'package:flutter/services.dart';

class CurrencyInputFormatter extends TextInputFormatter {

  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {

    if(newValue.selection.baseOffset == 0){
      return newValue;
    }

    String newText;
    String x = newValue.text;

    if(x.length < 10)
      for(int i = 0; i < x.length; i++){
        if(i % 3 == 0 && i != 0){
          if(newText == null)
            newText = x.substring(0, x.length - i) + ',' + x.substring(x.length - i , x.length);
          else
            newText = newText.substring(0, x.length - i) + ',' + newText.substring(x.length - i , newText.length);
        }
        else if(x.length < 4){
          newText = newValue.text;
        }
      }
    else
      newText = oldValue.text;

    return newValue.copyWith(
        text: newText,
        selection: new TextSelection.collapsed(offset: newText.length));
  }
}



TextFormField(
  controller: _textController,
  keyboardType: TextInputType.number,
  maxLength: 11,
  inputFormatters: [
    WhitelistingTextInputFormatter.digitsOnly,
    LengthLimitingTextInputFormatter(11),
    CurrencyInputFormatter()
  ],
  decoration: InputDecoration(
    labelText: "salary",
    labelStyle: TextStyle(fontSize: 15),
    counterStyle: TextStyle(
      height: double.minPositive,
    ),
    counterText: "",
  ),
)
