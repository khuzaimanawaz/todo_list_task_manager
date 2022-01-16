import 'package:get/get.dart';
import 'package:to_do_list_task_manager/app/data/providers/task/provider.dart';
import 'package:to_do_list_task_manager/app/data/services/storage/repository.dart';
import 'package:to_do_list_task_manager/app/modules/home/controller.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => HomeController(
        taskRespository: TaskRespository(
          taskProvider: TaskProvider(),
        ),
      ),
    );
  }
}
