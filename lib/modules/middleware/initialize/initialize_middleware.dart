import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:functional_rx_bloc/modules/middleware/common/error/failures.dart';

abstract class GeneralConfigMiddleware {
  Future<Either<Failure,Unit>> init();
  Future<ThemeData> _retrieveThemePreference();
  Future<bool> _checkIsFirstVisit();
}