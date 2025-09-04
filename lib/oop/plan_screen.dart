import 'package:flutter/material.dart';
import 'package:dalell/oop/plan.dart';
import 'package:dalell/oop/task.dart';

class PlanScreen extends StatefulWidget {
  const PlanScreen({super.key});

  @override
  State<PlanScreen> createState() => _PlanScreenState();
}

class _PlanScreenState extends State<PlanScreen> {
  Plan plan = const Plan();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Master Plan')),
      body: _buildList(),
      floatingActionButton: _buildAddTaskButton(),
    );
  }

  Widget _buildList() {
    return ListView.builder(
        itemCount: plan.tasks.length,
        itemBuilder: (context, index) =>
          _buildListTile(plan.tasks[index], index)
        );
  }

  Widget _buildListTile(Task task, int index) {
    return ListTile(
      leading: Checkbox(
          value: task.complete,
          onChanged: (slected) {
            setState(() {
              plan = Plan(
                  name: plan.name,
                  tasks: List<Task>.from(plan.tasks)
                    ..[index] = Task(
                      description: task.description,
                      complete: slected ?? false,
                    ));
            });
            
          }),
          title: TextFormField(
            initialValue: task.description,
            onChanged: (tex){
              setState(() {
                plan=Plan(
                  name: plan.name,
                  tasks: List<Task>.from(plan.tasks)
                  ..[index]=Task(
                    description: tex,
                    complete: task.complete,

                  )
                );
              });
            },

          ),
    );
  }

  Widget _buildAddTaskButton() {
    return FloatingActionButton(
      onPressed: () {
        print("object");
        setState(() {
          plan = Plan(
            name: plan.name,
            tasks: List<Task>.from(plan.tasks)..add(Task()),
          );
        });
      },
      child: const Icon(Icons.add),
    );
  }
}
