import 'dart:convert';

import 'package:connectivity/connectivity.dart';
import 'package:http/http.dart' as http;

class NetworkHelper {
  NetworkHelper(this.url);

  final String url;

  Future getData() async {
    var connectivityResult = await (Connectivity().checkConnectivity());

    //print(state);
    if (connectivityResult == ConnectivityResult.wifi ||
        connectivityResult == ConnectivityResult.mobile) {
      final http.Response response = await http.get(url);

      if (response.statusCode >= 200 && response.statusCode <= 226) {
        final String data = response.body;

        return jsonDecode(data);
        // } else if (response.statusCode >= 400 && response.statusCode <= 511) {
        //   return 1;
        // }
      }
    } else {
      return 0;
    }
  }
}
