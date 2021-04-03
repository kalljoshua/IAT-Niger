import 'package:iat_nigeria/config/api_config.dart';
import 'package:iat_nigeria/utils/urify.dart';

String basePath = CONFIG_MAP["BASE_PATH"];

class EndPoints {
  static Urify _urify = new Urify(basePath);

  static Uri checkUserAvailable(String userPhone) {
    return _urify.getUri("/userData/all/checkContact/$userPhone");
  }

  static Uri getRegisterUserPath() {
    return _urify.getUri("/api/register");
  }

  static Uri getPosts() {
    return _urify.getUri("/api/posts");
  }

  static Uri getUserPosts(int userId) {
    return _urify.getUri("/api/posts/users/$userId");
  }

  static Uri createPost() {
    return _urify.getUri("/api/posts");
  }

  // User
  static Uri getUserProfile(String userPhone) {
    return _urify.getUri("/api/user-profile/$userPhone");
  }

  //registration route
  static Uri registrationPath() {
    return _urify.getUri("/api/register");
  }

  //create post route
  static Uri createPostPath() {
    return _urify.getUri("/api/posts");
  }

  //post comments
  static Uri getComments(int id) {
    return _urify.getUri("/api/comments/posts/$id");
  }

  static Uri postComments(String id) {
    return _urify.getUri("/api/comments/posts/$id");
  }

  static Uri deleteComment(int commentId) {
    return _urify.getUri("/api/comments/$commentId/delete");
  }

  static Uri editComment(int commentId) {
    return _urify.getUri("/api/comments/$commentId/edit");
  }

  // Provide path from out
  static Uri getUri(String path) {
    return _urify.getUri(path);
  }

  static Uri getUserActivities(int userId) {
    return _urify.getUri("/api/user-activities/$userId");
  }

  // League routes
  static Uri getTeams() {
    return _urify.getUri("/api/teams/");
  }

  static Uri getAllFixtures() {
    return _urify.getUri("/api/fixtures");
  }

  static Uri getAllResults() {
    return _urify.getUri("/api/scores");
  }

  static Uri getTableStandings() {
    return _urify.getUri("/api/standings");
  }

  static Uri getTeamFixtures(int teamId) {
    return _urify.getUri("/api/fixtures/$teamId");
  }

  static Uri getTeamResults(int teamId) {
    return _urify.getUri("/api/scores/$teamId");
  }

  static Uri submitAttendance() {
    return _urify.getUri("/api/league/submit-attendance");
  }

  // Messenger
  static Uri getChatParticipants() {
    return _urify.getUri("/api/chats/users");
  }

  static Uri getUserChats(int userId) {
    return _urify.getUri("/api/chats/users/$userId");
  }

  static Uri getChatMessages(Map<String, dynamic> data) {
    return _urify.getUriWithParams("/api/chats/get-messages", data);
  }

  static Uri sendChatMessage() {
    return _urify.getUri("/api/chats/send-message");
  }

  static Uri updateUserFcmToken() {
    return _urify.getUri("/api/users/update-fcm-token");
  }

}
