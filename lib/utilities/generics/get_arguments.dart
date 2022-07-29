import 'package:flutter/cupertino.dart' show BuildContext, ModalRoute;

extension GetArgument on BuildContext{ // blabla. diye BuildContext türünden olan objelerin üstünde işlem yapacağız
  T? getArgument<T>(){ //T? cinsinden dönüyor ve kendini T cinsinden alıyor
    final modalRoute = ModalRoute.of(this);  // 
    if(modalRoute != null){ // üstünde işlem yapacağımız şeyin null olup olmadığını çekliyoruz
      final args = modalRoute.settings.arguments;
      if(args != null&& args is T){
        return args as T;

      }
    }
    return null;
  }



}