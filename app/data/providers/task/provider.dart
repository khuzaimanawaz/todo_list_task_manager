import 'dart:convert';

import 'package:get/get.dart';
import 'package:to_do_list_task_manager/app/core/utils/keys.dart';
import 'package:to_do_list_task_manager/app/data/models/task.dart';
import 'package:to_do_list_task_manager/app/data/services/storage/services.dart';

class TaskProvider {
  final _storage = Get.find<StorageService>();

  List<Task> readTasks() {
    // ignore: non_constant_identifier_names, unused_local_variable
    var tasks = <Task>[];

    jsonDecode(_storage.read(taskKey).toString())
        .forEach((e) => tasks.add(Task.fromJson(e)));
    return tasks;
  }

  void writeTasks(List<Task> tasks) {
    _storage.write(taskKey, jsonEncode(tasks));
  }
}
