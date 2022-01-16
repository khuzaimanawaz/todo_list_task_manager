// ignore_for_file: non_constant_identifier_names, avoid_types_as_parameter_names

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:to_do_list_task_manager/app/core/values/colors.dart';
import 'package:to_do_list_task_manager/app/data/models/task.dart';
import 'package:to_do_list_task_manager/app/modules/home/controller.dart';
import 'package:to_do_list_task_manager/app/modules/home/widgets/icons.dart';
import 'package:to_do_list_task_manager/app/core/utils/extensions.dart';
import 'package:dotted_border/dotted_border.dart';

class AddCart extends StatelessWidget {
  final HomeCtrl = Get.find<HomeController>();
  AddCart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final icons = getIcons();
    var squareWidth = Get.width - 12.0.wp;

    return Container(
      width: squareWidth / 2,
      height: squareWidth / 2,
      margin: EdgeInsets.all(3.0.wp),
      child: InkWell(
        onTap: () async {
          await Get.defaultDialog(
              titlePadding:
                  EdgeInsets.symmetric(horizontal: 5.0.wp, vertical: 15.0),
              radius: 5,
              title: "Task Type",
              content: Form(
                key: HomeCtrl.formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 3.0.wp, vertical: 25.0),
                      child: TextFormField(
                        controller: HomeCtrl.editCtrl,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Title",
                        ),
                        validator: (Value) {
                          if (Value == null || Value.trim().isEmpty) {
                            return "Please enter your Task Title";
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 5.0.wp),
                      child: Wrap(
                        spacing: 2.0.wp,
                        children: icons
                            .map((e) => Obx(() {
                                  final index = icons.indexOf(e);
                                  return ChoiceChip(
                                    selectedColor: Colors.grey[200],
                                    pressElevation: 0,
                                    backgroundColor: Colors.white,
                                    label: e,
                                    selected: HomeCtrl.chipIndex.value == index,
                                    onSelected: (bool selected) {
                                      // ignore: unrelated_type_equality_checks
                                      HomeCtrl.chipIndex.value =
                                          selected ? index : 0;
                                    },
                                  );
                                }))
                            .toList(),
                      ),
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: blue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            minimumSize: const Size(150, 40)),
                        onPressed: () {
                          if (HomeCtrl.formKey.currentState!.validate()) {
                            int icon =
                                icons[HomeCtrl.chipIndex.value].icon!.codePoint;
                            String color =
                                icons[HomeCtrl.chipIndex.value].color!.toHex();
                            var task = Task(
                                title: HomeCtrl.editCtrl.text,
                                icon: icon,
                                color: color);
                            Get.back();
                            HomeCtrl.addTask(task)
                                ? EasyLoading.showSuccess("Succrssful")
                                : EasyLoading.showError("Duplicated Task");
                          }
                        },
                        child: const Text("Confirm"))
                  ],
                ),
              ));
          HomeCtrl.editCtrl.clear();
          HomeCtrl.changeChipIndex(0);
        },
        child: DottedBorder(
          color: Colors.grey,
          dashPattern: const [8, 4],
          child: Center(
            child: Icon(
              Icons.add,
              size: 10.0.wp,
              color: Colors.grey,
            ),
          ),
        ),
      ),
    );
  }
}
