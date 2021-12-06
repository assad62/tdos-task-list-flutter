import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_starter_app/common/base_view.dart';
import 'package:flutter_starter_app/common/viewstate.dart';
import 'package:flutter_starter_app/viewmodels/new_task_viewmodel.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_image_picker/form_builder_image_picker.dart';


class NewTaskView extends StatelessWidget{
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return BaseView<NewTaskModel>(
        onModelReady: (model) => model.onFirstLoad(),
        builder: (context, model, children) =>
            Scaffold(
                appBar: AppBar(
                  iconTheme: IconThemeData(
                    color: Colors.black, //change your color here
                  ),
                  backgroundColor: Colors.white,
                  elevation: 1,
                  title:
                  Text("Add New Task", style: TextStyle(color: Colors.black, fontSize: 24),),
                ),
                body: Stack(
                  children: [
                    SingleChildScrollView(
                      child: Column(
                          children:[
                            Padding(
                              padding: const EdgeInsets.all(14.0),
                              child: FormBuilder(
                                key: _formKey,
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Text("Date:", style:TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                                        SizedBox(width:10),
                                        Text(model.getFormattedDateTime(), style:TextStyle(fontSize: 18)),
                                      ],
                                    ),
                                    SizedBox(height: 20,),
                                    FormBuilderTextField(
                                      name: 'title',

                                      decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                            // width: 0.0 produces a thin "hairline" border
                                            borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                            borderSide:  BorderSide(
                                              color: Colors.black,
                                            ),
                                            //borderSide: const BorderSide(),
                                          ),
                                          labelText: 'Title'
                                      ),
                                    ),
                                    SizedBox(height: 20,),
                                    FormBuilderTextField(
                                      textAlign: TextAlign.start,
                                      textAlignVertical: TextAlignVertical.center,
                                      name: 'Description',
                                      maxLines: 10,
                                      decoration: InputDecoration(
                                          alignLabelWithHint: true,
                                          border: OutlineInputBorder(
                                            // width: 0.0 produces a thin "hairline" border
                                            borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                            borderSide:  BorderSide(
                                              color: Colors.black,
                                            ),
                                            //borderSide: const BorderSide(),
                                          ),
                                          labelText: 'Description'
                                      ),
                                    ),
                                    FormBuilderImagePicker(
                                      name: 'photos',
                                      decoration: const InputDecoration(labelText: 'Pick Photos'),
                                      maxImages: 1,
                                    ),

                                    const SizedBox(height: 50),
                                    SizedBox(
                                      width:200,
                                      height:50,
                                      child: ElevatedButton(

                                        child: const Text('Submit', style:TextStyle(fontSize: 18)),
                                        style: ElevatedButton.styleFrom(
                                          primary: Colors.black, // background
                                          onPrimary: Colors.white, // foreground
                                        ),
                                        onPressed: () async{
                                          if (_formKey.currentState?.saveAndValidate() == true) {

                                            await model.addToTaskList(_formKey.currentState!.value);
                                            Navigator.pop(context);
                                          }
                                        },
                                      ),
                                    ),

                                  ],
                                ),
                              ),
                            ),
                          ]
                      ),
                    ),
                    Visibility(
                        visible: model.state == ViewState.Busy,
                        child: Center(child: CircularProgressIndicator())
                    ),
                  ],

                )

            )
    );
  }
}