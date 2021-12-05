import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_starter_app/common/navigation_service.dart';

import '../../../locator.dart';

void showSnackbar(String message) {
  ScaffoldMessenger.of(locator<NavigationService>().navigatorKey.currentContext!).showSnackBar(SnackBar(content: Text(message)));
}