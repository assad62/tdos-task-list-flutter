import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_starter_app/common/base_view.dart';
import 'package:flutter_starter_app/common/viewstate.dart';
import 'package:flutter_starter_app/viewmodels/login_viewmodel.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../router.dart';

class LoginView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseView<LoginModel>(
        onModelReady: (model) => model.onFirstLoad(),
        builder: (context, model, children) => Scaffold(

              body: Stack(
                children: [
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Task Manager",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 26,
                              fontWeight: FontWeight.w800),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: EdgeInsets.all(15),
                          child: TextFormField(
                            controller: model.emailEditingController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Email',
                              hintText: 'Enter Your Email',
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(15),
                          child: TextFormField(
                            controller: model.passwordEditingController,
                            obscureText: true,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),

                              labelText: 'Password',
                              hintText: 'Enter Password',
                            ),
                          ),
                        ),
                        SizedBox(
                          width: double.infinity,
                          height: 80,
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: ElevatedButton(

                              style: ElevatedButton.styleFrom(primary: Colors.black),
                              child: Text('Sign In',  style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w800)),
                              onPressed: () async{
                                bool signInSuccess = await model.signIn();

                                if(signInSuccess){
                                  Navigator.pushNamed(context, AppRoutes.homeRoute);
                                }
                              },
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Visibility(
                      visible: model.state == ViewState.Busy,
                      child: Center(child: CircularProgressIndicator())
                  ),
                ],

              ),
            ));
  }
}
