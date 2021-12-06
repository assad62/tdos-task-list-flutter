import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_starter_app/component/snack_bar/snack_bar.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import '../../common/base_view.dart';
import '../../viewmodels/home_viewmodel.dart';
import 'edit_task.dart';


class HomeView extends StatelessWidget {
  final alertStyle = AlertStyle(
      animationType: AnimationType.fromBottom,
      isCloseButton: false,
      isOverlayTapDismiss: false,
      descStyle: TextStyle(fontWeight: FontWeight.bold),
      animationDuration: Duration(milliseconds: 400),
      alertBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0.0),
        side: BorderSide(
          color: Colors.grey,
        ),
      ),
      titleStyle: TextStyle(
        color: Colors.green,
      ),
      constraints: BoxConstraints.expand(width: 300),
      //First to chars "55" represents transparency of color
      overlayColor: Color(0x55000000),
      alertElevation: 0,
      alertAlignment: Alignment.center);

  @override
  Widget build(BuildContext context) {
    return BaseView<HomeModel>(
        onModelReady: (model) => model.onFirstLoad(),
        builder: (context, model, children) =>
            Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.white,
                elevation: 1,
                title: Text(
                  "Task Manager",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 26,
                      fontWeight: FontWeight.w800),
                ),
              ),
              body: ListView.builder(
                itemCount: 2,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text(
                            "Completed Tasks",
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.w500),
                          ),
                        ),
                        SizedBox(
                          height: 220,
                          child: model.completedTaskList.length == 0
                              ? SizedBox(
                              height: 200,
                              child: Center(
                                child: Text("No Completed Tasks"),
                              ))
                              : ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: model.completedTaskList.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      10, 5, 10, 0),
                                  child: Container(
                                    width: 220,
                                    height: 220,
                                    decoration: BoxDecoration(
                                        color: Colors.orange[500],
                                        border: Border.all(
                                          color: Colors.orange[500] ??
                                              Colors.black,
                                        ),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20))),
                                    child: Container(
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                        MainAxisAlignment.start,
                                        children: [
                                          model.completedTaskList[index] ==
                                              0
                                              ? Spacer()
                                              : Padding(
                                            padding:
                                            const EdgeInsets.all(
                                                8.0),
                                            child: Container(
                                              height: 120,
                                              width: 200,
                                              // child: Image.file(
                                              //   File(model.completedTaskList[index]
                                              //       .taskAttachments[0]),
                                              //   fit: BoxFit.cover,
                                              // ),
                                            ),
                                          ),
                                          Spacer(),
                                          Padding(
                                            padding:
                                            const EdgeInsets.all(12.0),
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceBetween,
                                              children: [
                                                // Flexible(child: Text(model.completedTaskList[index].title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color:Colors.white),)),
                                                // Spacer(),

                                                Container(
                                                    height: 40,
                                                    width: 40,
                                                    decoration:
                                                    BoxDecoration(
                                                      color: Colors.white,
                                                      shape:
                                                      BoxShape.circle,
                                                    ),
                                                    child: Icon(
                                                      Icons.check,
                                                      color: Colors.green,
                                                    ))
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }),
                        ),
                      ],
                    );
                  }

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Pending Tasks",
                              style: TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.w500),
                            ),
                            if (model.pendingTaskList.length == 0)
                              SizedBox(
                                height: 200,
                                child: Center(
                                  child: Text("No Pending Tasks"),
                                ),
                              )
                            else
                              ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: model.pendingTaskList.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            10, 5, 10, 0),
                                        child: Container(
                                          height: 150,
                                          child: Dismissible(
                                            background:
                                            Container(color: Colors.red),
                                            key: Key(
                                                model.pendingTaskList[index]
                                                    .sId ?? ""),
                                            onDismissed: (direction) async {
                                              //Save ref to title before deleting it;
                                              String? title = model
                                                  .pendingTaskList[index].title;
                                              await model.deleteTask(
                                                  model.pendingTaskList[index]
                                                      .sId ?? "");

                                              showSnackbar('$title dismissed');
                                            },
                                            child: GestureDetector(
                                              onTap: () async {
                                                bool showModal = model
                                                    .showEditModal();
                                                if (showModal) {
                                                  await editTask(
                                                      model
                                                          .pendingTaskList[index],
                                                      context,
                                                          () =>
                                                          onTaskUpdate(
                                                              model,
                                                              model
                                                                  .pendingTaskList[
                                                              index]
                                                                  .sId,
                                                              context));
                                                }
                                              },
                                              child: Card(
                                                  child: Row(
                                                      children: [
                                                  model.pendingTaskList[index].attachment?.length == 0
                                                  ? Container()
                                                  : Padding(
                                              padding:
                                              const EdgeInsets
                                                  .fromLTRB(
                                              10, 5, 10, 0),
                                              child: Container(
                                                  height: 120,
                                                  width: 120,
                                                  child:
                                                  Image.network(
                                                    model
                                                    .pendingTaskList[
                                                    index]
                                                    .attachment ?? "",
                                                    fit: BoxFit.cover,
                                                  )),
                                            ),

                                          SizedBox(
                                            width: 5,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                            MainAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                height: 10,
                                              ),

                                              Text(
                                                  model.pendingTaskList[index]
                                                      .title ?? "",
                                                  style: TextStyle(
                                                      fontSize: 22,
                                                      fontWeight:
                                                      FontWeight
                                                          .bold)),
                                              SizedBox(
                                                height: 8,
                                              ),
                                              Row(
                                                children: [
                                                  Icon(
                                                    Icons.event_outlined,
                                                  ),
                                                  SizedBox(width: 5,),
                                                  Text(model
                                                      .pendingTaskList[index]
                                                      .completeBy!.split(
                                                      "T")[0],
                                                      style: TextStyle(
                                                          fontSize: 16)),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 8,
                                              ),
                                              Row(
                                                children: [
                                                  Icon(
                                                    Icons.schedule_outlined,
                                                  ),
                                                  SizedBox(width: 5,),
                                                  Text(model
                                                      .pendingTaskList[index]
                                                      .completeBy!.split(
                                                      "T")[1],
                                                      style: TextStyle(
                                                          fontSize: 14)),
                                                ],
                                              ),

                                            ],
                                          )
                                          ],
                                        )),)
                                    ,
                                    )
                                    ,
                                    )
                                    ,
                                    );
                                  }),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
              floatingActionButton: FloatingActionButton(
                backgroundColor: Colors.black,
                onPressed: model.addNewTask,
                child: Icon(Icons.add),
              ), // This trailing comma makes auto-formatting nicer for build methods.
            ));
  }

  void onTaskUpdate(HomeModel model, String? taskId,
      BuildContext context) async {
    bool success = await model.onTaskComplete(taskId);
    if (success) {
      _onAlertWithStylePressed(context);
    }
  }

  _onAlertWithStylePressed(context) {
    // Alert dialog using custom alert style
    Alert(
      context: context,
      style: alertStyle,
      type: AlertType.success,
      title: "Success",
      desc: "Task updated",
      buttons: [
        DialogButton(
          child: Text(
            "Ok",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
          color: Color.fromRGBO(0, 179, 134, 1.0),
          radius: BorderRadius.circular(0.0),
        ),
      ],
    ).show();
  }
}
