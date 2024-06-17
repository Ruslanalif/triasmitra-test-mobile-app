import 'package:shared_preferences/shared_preferences.dart';

class SessionService {
  static const String _keyToken = 'token';
  static const String _keyID = 'id';
  static const String _keyUsername = 'username';
  static const String _keyName = 'name';
  static const String _keyPhone = 'phone';
  static const String _keyEmail = 'email';
  static const String _keyExpiry = 'expiry';

  // Set session data
  Future<void> setSession({
    required String token,
    required String id,
    required String username,
    required String name,
    required String phone,
    required String email,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyToken, token);
    await prefs.setString(_keyID, id);
    await prefs.setString(_keyUsername, username);
    await prefs.setString(_keyName, name);
    await prefs.setString(_keyPhone, phone);
    await prefs.setString(_keyEmail, email);

    // Set expiry time to 24 hours from now
    final expiryDate = DateTime.now().add(Duration(days: 1));
    await prefs.setString(_keyExpiry, expiryDate.toIso8601String());
  }

  // Get session data
  Future<Map<String, String?>> getSession() async {
    final prefs = await SharedPreferences.getInstance();

    if (!_isSessionValid(prefs)) {
      await clearSession();
      return {};
    }

    return {
      'token': prefs.getString(_keyToken),
      'id': prefs.getString(_keyID),
      'username': prefs.getString(_keyUsername),
      'name': prefs.getString(_keyName),
      'phone': prefs.getString(_keyPhone),
      'email': prefs.getString(_keyEmail),
    };
  }

  // Clear session data
  Future<void> clearSession() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyToken);
    await prefs.remove(_keyID);
    await prefs.remove(_keyUsername);
    await prefs.remove(_keyName);
    await prefs.remove(_keyPhone);
    await prefs.remove(_keyEmail);
    await prefs.remove(_keyExpiry);
  }

  // Check if session is valid
  bool _isSessionValid(SharedPreferences prefs) {
    final expiryDateString = prefs.getString(_keyExpiry);
    if (expiryDateString == null) return false;

    final expiryDate = DateTime.parse(expiryDateString);
    return DateTime.now().isBefore(expiryDate);
  }
}
