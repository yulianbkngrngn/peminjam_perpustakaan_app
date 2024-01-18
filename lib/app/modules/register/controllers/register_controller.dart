import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/constant/endpoint.dart';
import '../../../data/provider/ap-_provider.dart';


class RegisterController extends GetxController {
  //TODO: Implement RegisterController
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController namaController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController telpController = TextEditingController();
  final TextEditingController alamatController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();


  final count = 0.obs;

  @override
  void onInit() {
    super.onInit();

  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
  final loadingRegister = false.obs;
  addRegist() async {
    loadingRegister(true);
    try {
      FocusScope.of(Get.context!).unfocus();
      formKey.currentState?.save();
      if (formKey.currentState!.validate()) {
        final response = await ApiProvider.instance().post(Endpoint.register,
            data: {
              "nama": namaController.text.toString(),
              "username": usernameController.text.toString(),
              "telp": int.parse(telpController.text.toString()),
              "alamat": alamatController.text.toString(),
              "password": passwordController.text.toString(),

            }

        );
        if (response.statusCode == 201) {
          Get.back();
        } else {
          Get.snackbar("Sorry", "Gagal menyimpan data",
              backgroundColor: Colors.orange);
        }
      }
      loadingRegister(false);
    } on dio.DioException catch (e) {
      loadingRegister(false);
      Get.snackbar("Sorry", e.message ?? "", backgroundColor: Colors.red);
    } catch (e) {
      loadingRegister(false);
      Get.snackbar("Error", e.toString(), backgroundColor: Colors.red);
      throw Exception('Error: $e');
    }
  }
}