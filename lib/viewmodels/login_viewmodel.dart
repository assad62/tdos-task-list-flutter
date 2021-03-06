import 'package:flutter/material.dart';
import 'package:flutter_starter_app/api/api_service.dart';
import 'package:flutter_starter_app/api/endpoints.dart';
import 'package:flutter_starter_app/common/base_model.dart';
import 'package:flutter_starter_app/common/viewstate.dart';
import 'package:flutter_starter_app/models/AppLoginModel.dart';
import 'package:flutter_starter_app/utils/storage/secure_local_storage.dart';

class LoginModel extends BaseModel{

  late TextEditingController emailEditingController;
  late TextEditingController passwordEditingController;
  void onFirstLoad(){
     emailEditingController = TextEditingController();
     passwordEditingController = TextEditingController();
  }

  Future<bool>signIn() async {

    setState(ViewState.Busy);

    var loginMapBody = {
      "email": emailEditingController.text,
      "password":passwordEditingController.text
    };

    try {
      var response = await APIService().postEndpointData(
          endpoint: Endpoint.login, postBody: loginMapBody);
      if (response.statusCode == 200){
        var loginModel = AppLoginModel.fromJson(response.data);

        SecureLocalStorage().saveValue("token", loginModel.body!.token);
        setState(ViewState.Idle);
        return true;
      }
    }
    catch(e){
      print("e is $e");
    }
    setState(ViewState.Idle);
    return false;


  }


}