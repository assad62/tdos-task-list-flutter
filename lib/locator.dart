import 'package:flutter_starter_app/viewmodels/login_viewmodel.dart';
import 'package:flutter_starter_app/viewmodels/new_task_viewmodel.dart';
import 'package:get_it/get_it.dart';
import 'common/navigation_service.dart';
import 'viewmodels/home_viewmodel.dart';



GetIt locator = GetIt.instance;

void setupLocator() {

   //navigation service for global app context
   locator.registerLazySingleton(() => NavigationService());

   locator.registerFactory(() => HomeModel());
   locator.registerFactory(() => LoginModel());
   locator.registerFactory(() => NewTaskModel());

}