import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:iat_nigeria/endPoints/end_points.dart';
import 'package:iat_nigeria/services/transactions/models/last_transaction_data.dart';
import 'package:iat_nigeria/services/wallet/model/user_wallet.dart';
import 'package:iat_nigeria/session/session_storage.dart';

import 'model/flutter_wave.dart';
import 'model/isp_data.dart';
import 'model/ott_payment_data.dart';

class WalletService {
  http.Client client;

  SessionStorage sessionStorage;

  WalletService(http.Client client, SessionStorage sessionStorage) {
    this.client = client;
    this.sessionStorage = sessionStorage;
  }

  Future<UserWallet> getUserWalletInfo() async {
    String userToken = await sessionStorage.getToken();
    Map<String, String> headers = {
      HttpHeaders.authorizationHeader: 'Bearer $userToken',
      'Content-Type': 'application/json; charset=UTF-8'
    };
    final response =
        await client.get(EndPoints.getUserWallet(), headers: headers);

    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON.
      return UserWallet.fromJson(jsonDecode(response.body));
    } else {
      // If that call was not successful, throw an error.
      print("***Response Error body: " + response.statusCode.toString());
      print("***Response Error body: " + response.body);
      throw Exception(jsonDecode(response.body)['message']);

    }
  }

  Future<FlutterWave> getUserTopLink(String amount) async {
    String userToken = await sessionStorage.getToken();
    Map<String, String> headers = {
      HttpHeaders.authorizationHeader: 'Bearer $userToken',
      'Content-Type': 'application/json; charset=UTF-8'
    };
    final response =
        await client.post(EndPoints.getTopupLink(amount), headers: headers);
    print("***Response body: " + response.body);
    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON.
      print("***Response body: " + response.statusCode.toString());
      return FlutterWave.fromJson(jsonDecode(response.body));
    } else {
      // If that call was not successful, throw an error.
      throw Exception(jsonDecode(response.body)['message']);
    }
  }

  Future<List<IspData>> getIspPageData() async {
    String userToken = await sessionStorage.getToken();
    Map<String, String> headers = {
      HttpHeaders.authorizationHeader: 'Bearer $userToken',
      'Content-Type': 'application/json; charset=UTF-8'
    };

    final response = await client.get(EndPoints.getIsps(), headers: headers);
    if (response.statusCode != 200) {
      throw Exception(jsonDecode(response.body)['message']);
    }

    var responseData = jsonDecode(response.body);
    var teams = responseData;

    List<IspData> teamList = [];
    for (var team in teams) {
      var teamData = IspData.fromJson(team);
      teamList.add(teamData);
    }
    return teamList;
  }

  Future<bool> payOtt(OttData data) async {
    String userToken = await sessionStorage.getToken();
    Map<String, String> headers = {
      HttpHeaders.authorizationHeader: 'Bearer $userToken',
      'Content-Type': 'application/json; charset=UTF-8'
    };
    final msg = jsonEncode(data.toMap());
    final response =
        await client.post(EndPoints.payOttPath(), headers: headers, body: msg);

    print("***Response Code: " + response.statusCode.toString());

    if (response.statusCode != 200) {
      print("***Response body: " + response.body);
      return false;
    }
    //_createUserSession(response.body);
    return true;
  }

  Future<PaymentsData> sendMoney(String phone, String amount) async {
    String userToken =  await sessionStorage.getToken();
    Map<String, String> headers = {
      HttpHeaders.authorizationHeader: 'Bearer $userToken',
      'Content-Type': 'application/json; charset=UTF-8'
    };
    final response =
    await client.put(EndPoints.sendWalletMoney(amount,phone), headers: headers);
    print("***Response body: " + response.body);
    print("***Response Code: "+response.statusCode.toString());

    if (response.statusCode != 200 && response.statusCode != 201) {
      print("***Response body: "+response.body);
      throw Exception(jsonDecode(response.body)['message']);
    }
    return PaymentsData.fromJson(jsonDecode(response.body));
  }
}
