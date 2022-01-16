import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_list_task_manager/app/core/utils/extensions.dart';
import 'package:to_do_list_task_manager/app/data/models/task.dart';
import 'package:to_do_list_task_manager/app/modules/detail/view.dart';
import 'package:to_do_list_task_manager/app/modules/home/controller.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class TaskCard extends StatelessWidget {
  final homectrl = Get.find<HomeController>();
  final Task task;
  TaskCard({Key? key, required this.task}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = HexColor.fromHex(task.color);
    final sqareWidth = Get.width - 12.0.wp;
    return GestureDetector(
      onTap: () {
        homectrl.changeTask(task);
        homectrl.changeTodos(task.todos ?? []);
        Get.to(() => DetailPage());
      },
      child: Container(
        width: sqareWidth / 2,
        height: sqareWidth / 2,
        margin: EdgeInsets.all(3.0.wp),
        decoration: const BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 7,
            offset: Offset(0, 7),
          )
        ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            StepProgressIndicator(
              //indicator
              totalSteps: homectrl.isTodosEmpty(task) ? 1 : task.todos!.length,
              currentStep:
                  homectrl.isTodosEmpty(task) ? 0 : homectrl.getDoneTodo(task),
              size: 5,
              padding: 0,
              selectedGradientColor: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [color.withOpacity(0.5), color]),
              unselectedGradientColor: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Colors.white, Colors.white]),
            ),
            Padding(
              padding: EdgeInsets.all(6.0.wp),
              child: Icon(
                IconData(task.icon, fontFamily: "MaterialIcons"),
                color: color,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(6.0.wp),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    task.title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 10.0.sp,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 2.0.wp),
                  Text(
                    "${task.todos?.length ?? 0} Task",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 10.0.sp,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
