import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import '../../../data/constant/endpoint.dart';
import '../../../data/provider/ap-_provider.dart';
import '../../../data/provider/storage_provider.dart';

class AddPeminjamanController extends GetxController {
  //TODO: Implement AddPeminjamanController
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController tglPinjamController = TextEditingController();
  final TextEditingController tglKembaliController = TextEditingController();
  final TextEditingController idUser = TextEditingController();
  final TextEditingController parameters = TextEditingController();


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

  final loading = false.obs;

  Future<void> post() async {
    loading(true);
    try {
      FocusScope.of(Get.context!).unfocus();
      formKey.currentState?.save();
      if (formKey.currentState!.validate()) {
        final response = await ApiProvider.instance().post(
            Endpoint.pinjam, data: {
          "tanggal_pinjam": tglPinjamController.text.toString(),
          "tanggal_kembali": tglKembaliController.text.toString(),
          "user_id": int.parse(StorageProvider.read(StorageKey.idUser)),
          "book_id": int.parse(Get.parameters['id'].toString())
        });
        if (response.statusCode == 201) {
          Get.back();
        } else {
          Get.snackbar("Sorry", "Simpan Gagal", backgroundColor: Colors.orange);
        }
      }
      loading(false);
    } on dio.DioException catch (e) {
      loading(false);
      log("${e.response?.statusMessage}");
      if (e.response != null) {
        if (e.response?.data != null) {
          Get.snackbar("Sorry", "${e.response?.data['message']}",
              backgroundColor: Colors.orange);
        } else {
          Get.snackbar("Sorry", "${e.response?.statusMessage}",
              backgroundColor: Colors.orange);
        }
      } else {
        Get.snackbar("Sorry", e.message ?? "", backgroundColor: Colors.red);
      }
    } catch (e) {
      loading(false);
      Get.snackbar("Error", e.toString(), backgroundColor: Colors.red);
      throw Exception('Error: $e');
    }
  }

}
