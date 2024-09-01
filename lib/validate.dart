import 'package:restapi_php/constants/message.dart';

validatoInput(String val, int max, int min) {
  if (val.length > max) {
    return "$messagemax $max";
  }
  if (val.isEmpty) {
    return messageempty;
  }
  if (val.length < min) {
    return "$messagemin $min";
  }
}
