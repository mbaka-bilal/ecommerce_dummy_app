import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginFormStatus extends Cubit<bool>{
  LoginFormStatus(): super(false);

  void checkLoginFormStatus(GlobalKey<FormState> key){
    // print ("validating");
    if (!key.currentState!.validate()) {
      // print ("not validates");
      emit(false);
    }
    if (key.currentState!.validate()) {
      // print ("validated successfully");
      emit(true);
    }
  }

  void reset() {
    emit(false);
  }

}