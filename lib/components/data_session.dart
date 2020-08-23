import 'package:shared_preferences/shared_preferences.dart';

class DataSession{
  final String email         = 'email';
  final String password      = 'password';
  final String username      = 'username';
  final String fcmToken      = 'fcm_token';
  final String authToken     = '';
  final String refreshToken  = '';
  final String statusLogin   = 'is_login';
  final String subscriptionStatus = 'is_subscribed';
  final String addProductStatus = 'is_from_add_product';
  final String rememberLogin = 'remember_login';
  final String userId = 'user_id';
  final String userRole = 'user_role';

  DataSession();

  void setEmail(String paramEmail) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(email, paramEmail);
  }

  Future<String> getEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(email);
  }

  void setPassword(String paramPassword) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(password, paramPassword);
  }

  Future<String> getPassword() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(password);
  }

  void setUsername(String paramName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(username, paramName);
  }

  Future<String> getUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(username);
  }

  void setFcmToken(String paramFcm) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(fcmToken, paramFcm);
  }

  Future<String> getFcmToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(fcmToken);
  }

  void setAuthToken(String paramToken) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(authToken, paramToken);
  }

  Future<String> getAuthToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(authToken);
  }

  void setRefreshToken(String paramToken) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(refreshToken, paramToken);
  }

  Future<String> getRefreshToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(refreshToken);
  }

  void setStatusLogin(bool stateLogin) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(statusLogin, stateLogin);
  }

  Future<bool> getStatusLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(statusLogin) ?? false;
  }

  void setRememberLogin(bool stateLogin) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(rememberLogin, stateLogin);
  }

  Future<bool> getRememberLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(rememberLogin) ?? false;
  }

  void setSubscriptionStatus(bool isSubscribed) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(subscriptionStatus, isSubscribed);
  }

  Future<bool> getSubscriptionStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(subscriptionStatus);
  }

  void setAddProductStatus(bool isFromAddProduct) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(addProductStatus, isFromAddProduct);
  }

  Future<bool> getAddProductStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(addProductStatus);
  }

  void setUserId(String currentUserId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(userId, currentUserId);
  }

  Future<String> getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userId);
  }

  void setUserRole(int currentUserRole) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(userRole, currentUserRole);
  }

  Future<int> getUserRole() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(userRole);
  }

  void removeSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(email);
    prefs.remove(password);
    prefs.remove(username);
    prefs.remove(fcmToken);
    prefs.remove(authToken);
    prefs.remove(statusLogin);
    prefs.remove(rememberLogin);
  }

}