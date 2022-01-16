import 'package:to_do_list_task_manager/app/data/models/task.dart';
import 'package:to_do_list_task_manager/app/data/providers/task/provider.dart';

class TaskRespository {
  TaskProvider taskProvider;

  TaskRespository({required this.taskProvider});
  List<Task> readTasks() => taskProvider.readTasks();
  void writeTasks(List<Task> tasks) => taskProvider.writeTasks(tasks);
}
