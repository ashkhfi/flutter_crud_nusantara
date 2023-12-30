import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user_model.dart';
import '../services/api_service.dart';

class AuthController extends GetxController {
  final ApiService _apiService = ApiService();
  final RxBool isAuthenticated = false.obs;
  final RxString token = ''.obs;
  final Rx<UserModel?> userProfile = Rx<UserModel?>(null);

  Future<void> registerUser(Map<String, dynamic> userData) async {
    try {
      final response = await _apiService.registerUser(userData);
      if (response.statusCode == 200) {
        Get.snackbar("Pendaftaran berhasil", "Pendaftaran anda berhasil");
      } else {
        Get.snackbar("Eror ", "Pendaftaran anda gagal");
      }
    } catch (error) {
      Get.snackbar("Eror ", "terjadi kesalahan");
    }
  }

  Future<void> loginUser(Map<String, dynamic> loginData) async {
    try {
      final response = await _apiService.loginUser(loginData);

      if (response.statusCode == 200) {
        await saveTokenToSharedPreferences(response.data['token']);
        await getUserProfile();
        Get.snackbar("Login berhasil", "Anda berhasil masuk");
      } else {
        Get.snackbar("eror", "Terjadi kesalahan");
      }
    } catch (error) {
      Get.snackbar("eror", "Terjadi kesalahan");
    }
  }

  Future<void> logout() async {
    try {
      final response = await _apiService.logout(token.value);
      if (response.statusCode == 200) {
        isAuthenticated.value = false;
        final prefs = await SharedPreferences.getInstance();
        await prefs.remove('token');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> getUserProfile() async {
    try {
      final response = await _apiService.getUserProfile(token.value);
      if (response.statusCode == 200) {
        final userProfileData = response.data as Map<String, dynamic>;
        final userModel = UserModel.fromJson(userProfileData);
        userProfile.value = userModel;
      } else {
        print("eror");
      }
    } catch (error) {
      print('Error a: $error');
    }
  }

  Future<void> saveTokenToSharedPreferences(String userToken) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', userToken);
    token.value = userToken;
    isAuthenticated.value = true;
  }

  Future<void> clearUserData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('token');
      token.value = '';
      isAuthenticated.value = false;
    } catch (error) {
      print('Error while clearing user data: $error');
    }
  }
}
