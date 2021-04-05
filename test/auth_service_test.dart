import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:iat_nigeria/services/auth/auth_service.dart';
import 'package:iat_nigeria/services/auth/user_signup_data.dart';
import 'package:iat_nigeria/session/session_storage.dart';


void main() {
  AuthenticationService authService;

  setUp(() {
    var client = http.Client();
    var sessionStorage = new SessionStorage();
    authService = new AuthenticationService(client, sessionStorage);
  });

  test('Test can sign up user', () async {
    // Arrange
    String responseData =
        '{"jwt":"THIS IS THE TOKEN"}';

    UserSignUpData signUpData = new UserSignUpData(
        email: "ttt@mail.com",
        passWord: "123456",
        contact: "0789059987");

    // Act
    var isSuccessful = await authService.signUpUser(signUpData);

    // Assert
    expect(isSuccessful,true);
  });
}
