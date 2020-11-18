import 'dart:convert';

import 'package:connectivity/connectivity.dart';
import 'package:http/http.dart' as http;

class NetworkHelper {
  NetworkHelper(this.url);

  final String url;

  Future<dynamic> getData() async {
    final ConnectivityResult connectivityResult =
        await Connectivity().checkConnectivity();

    if (connectivityResult == ConnectivityResult.wifi ||
        connectivityResult == ConnectivityResult.mobile) {
      final http.Response response = await http.get(url);

      if (response.statusCode >= 200 && response.statusCode <= 226) {
        final String data = response.body;

        return jsonDecode(data);
      }
    } else {
      return 0;
    }
  }
}
