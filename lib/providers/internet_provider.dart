import 'dart:async';
import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

import '../components/empty_state.dart';

class InternetProvider extends ChangeNotifier {
  bool _hasInternet = false;
  bool get hasInternet => _hasInternet;

  InternetProvider(BuildContext context) {
    checkInternetConnection(context);
  }

  Future<void> checkInternetConnection(context) async {
    final result = await Connectivity().checkConnectivity();

    if (result.contains(ConnectivityResult.none)) {
      _hasInternet = false;
      log('No Internet connection: 5566789');

      showEmptyState(
        context,
        icon: 'assets/icons/home.svg',
        header: 'Oops! No Internet Connection',
        subtitle: 'No internet connection found. Please check your connection',
        buttonText: 'Try again',
        onPressed: () => retryCheckInternetConnection(context),
      );
    } else {
      _hasInternet = true;
    }

    notifyListeners();
  }

  void retryCheckInternetConnection(BuildContext context) {
    Navigator.pop(context);
    checkInternetConnection(context);
  }
}
