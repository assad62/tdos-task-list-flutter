import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_starter_app/common/base_view.dart';
import 'package:flutter_starter_app/viewmodels/login_viewmodel.dart';

class LoginView extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return BaseView<LoginModel>(
        onModelReady: (model) => model.onFirstLoad(),
        builder: (context, model, children) =>
            Scaffold(
              appBar: AppBar(),
            )
    );
  }

}