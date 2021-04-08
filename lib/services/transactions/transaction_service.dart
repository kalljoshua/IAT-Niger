import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:iat_nigeria/endPoints/end_points.dart';

import 'package:iat_nigeria/session/session_storage.dart';

import 'models/last_transaction_data.dart';

class TransactionService {
  http.Client client;

  SessionStorage sessionStorage;

  TransactionService(http.Client client, SessionStorage sessionStorage) {
    this.client = client;
    this.sessionStorage = sessionStorage;
  }

  Future<List<PaymentsData>> getLastPaymentData() async {
    String userToken = await sessionStorage.getToken();
    Map<String, String> headers = {
      HttpHeaders.authorizationHeader: 'Bearer $userToken',
      'Content-Type': 'application/json; charset=UTF-8'
    };

    final response =
        await client.get(EndPoints.getLastPayments(), headers: headers);

    if (response.statusCode == 200) {
      print('RESPONSE** ' + response.body);
      List<PaymentsData> transactionList = paymentsDataFromJson(response.body);
      return transactionList;
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load transactions');
    }
  }

  Future<List<PaymentsData>> getPaymentData() async {
    String userToken = await sessionStorage.getToken();
    Map<String, String> headers = {
      HttpHeaders.authorizationHeader: 'Bearer $userToken',
      'Content-Type': 'application/json; charset=UTF-8'
    };

    final response =
    await client.get(EndPoints.getPayments(), headers: headers);

    if (response.statusCode == 200) {
      print('RESPONSE** ' + response.body);
      List<PaymentsData> transactionList = paymentsDataFromJson(response.body);
      return transactionList;
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load transactions');
    }
  }
}
