import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_starter_app/models/TaskModel.dart';
import 'package:flutter_starter_app/services/location_service/location_service.dart';

Future editTask(Task task, BuildContext context, Function onComplete) {
  var locationService = LocationService();
  double cWidth = MediaQuery.of(context).size.width*0.45;

  return showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return FractionallySizedBox(
          heightFactor: 0.4,
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Container(
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
                          child: Container(
                              height: 150,
                              width: 150,
                              child: Image.network(
                                task.attachment ?? "",
                                fit: BoxFit.cover,
                              )),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 8,
                            ),
                            Text(task.title ?? "",
                                style: TextStyle(
                                    fontSize: 22, fontWeight: FontWeight.bold)),
                            SizedBox(
                              height: 8,
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.event_outlined,
                                ),
                                SizedBox(width: 5,),
                                Text(task.completeBy.toString().split("T")[0],
                                    style: TextStyle(fontSize: 16)),
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
                                Text(task.completeBy.toString().split("T")[1],
                                    style: TextStyle(fontSize: 16)),
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            FutureBuilder<String>(
                              future: locationService.getAddress(task.lat ?? 0.00, task.lng ?? 0.00),
                              initialData: 'Waiting...',
                              builder: (BuildContext context, AsyncSnapshot<String> snapshot,) {
                                if(snapshot.hasData){
                                  return Container(
                                      width: cWidth,
                                      child: Text(snapshot.data ?? "", style: TextStyle(fontSize: 14)));
                                }
                                if(snapshot.hasError){
                                  return Text("Location cant be calculated");
                                }
                                return Text("Location is being calculated..please wait");

                              },
                            ),

                          ],
                        )
                      ],
                    ),
                  ),
                ),

                // Spacer(),
                Flexible(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.black, // background
                        // foreground
                      ),
                      onPressed: () {
                        onComplete();
                        Navigator.pop(context);
                      },
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'Done',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Icon(
                              Icons.check,
                              color: Colors.white,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      });
}