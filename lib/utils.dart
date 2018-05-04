import 'package:flutter/material.dart';

bool isAndroid(BuildContext context) => Theme.of(context).platform == TargetPlatform.android;

bool isIos(BuildContext context) => Theme.of(context).platform == TargetPlatform.iOS;