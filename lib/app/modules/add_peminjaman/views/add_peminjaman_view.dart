import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/add_peminjaman_controller.dart';

class AddPeminjamanView extends GetView<AddPeminjamanController> {
  const AddPeminjamanView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('AddPeminjamanView'),
          centerTitle: true,
        ),
        body: Form(
            key: controller.formKey,
            child: Column(children: [
              TextFormField(
                controller: controller.tglPinjamController,
                decoration: InputDecoration(hintText: "tulis tanggal meminjam"),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Tanggal meminjam tidak boleh kosong";
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: controller.tglKembaliController,
                decoration:
                    InputDecoration(hintText: "Masukkan tanggal Pengembalian"),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Tanggal pengembalian tidak boleh kosong";
                  }
                  return null;
                },
              ),
              Obx(() {
                return controller.loading.value
                    ? const CircularProgressIndicator()
                    : ElevatedButton(
                        onPressed: () => controller.post(),
                        child: const Text("Pinjam"));
              }).paddingOnly(top: 16)
            ]).paddingOnly(top: 16)));
  }
}
