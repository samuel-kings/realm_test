import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:realm_test/snackbar_helper.dart';
import 'package:realm_test/todo.dart';
import 'package:realm_test/todo_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  String getPriority(int priority) {
    switch (priority) {
      case 1:
        return "Low";
      case 2:
        return "Medium";
      case 3:
        return "High";
      default:
        return "Low";
    }
  }

  @override
  Widget build(BuildContext context) {
    TodoProvider todoProvider = context.read<TodoProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("My Todos"),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            final formKey = GlobalKey<FormState>();
            final controller = TextEditingController();
            int priority = 1;

            showDialog(
                context: context,
                builder: (ctx) {
                  return StatefulBuilder(
                    builder: (BuildContext context, setState) {
                      return AlertDialog(
                        title: const Text("Create a Todo"),
                        contentPadding: const EdgeInsets.all(16),
                        content: Form(
                          key: formKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // priority
                              Row(
                                children: [
                                  const Text("Priority", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16)),
                                  const SizedBox(width: 10),
                                  DropdownButton<int>(
                                      value: priority,
                                      items: const [
                                        DropdownMenuItem(value: 1, child: Text("Low")),
                                        DropdownMenuItem(value: 2, child: Text("Medium")),
                                        DropdownMenuItem(value: 3, child: Text("High"))
                                      ],
                                      onChanged: (val) {
                                        setState(() {
                                          priority = val ?? 1;
                                        });
                                      }),
                                ],
                              ),
                              const SizedBox(height: 20),
                              // title
                              const Text("Todo title", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16)),
                              TextFormField(
                                controller: controller,
                                validator: (val) {
                                  if (val!.isEmpty) {
                                    return "Field cannot be empty";
                                  } else {
                                    return null;
                                  }
                                },
                                decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))),
                              )
                            ],
                          ),
                        ),
                        actions: [
                          // cancel
                          TextButton(onPressed: () => Navigator.of(ctx).pop(), child: const Text("Cancel")),
                          TextButton(
                              onPressed: () async {
                                if (formKey.currentState!.validate()) {
                                  final todo = Todo(DateTime.now().millisecondsSinceEpoch.toString(),
                                      controller.text.trim(), false, priority);

                                  final isCreated = await todoProvider.createTodo(todo);

                                  if (context.mounted) {
                                    snackBarHelper(context,
                                        message: isCreated ? "Created successfully" : todoProvider.error,
                                        type: isCreated ? AnimatedSnackBarType.success : AnimatedSnackBarType.error);

                                    if (isCreated) Navigator.of(ctx).pop();
                                  }
                                }
                              },
                              child: const Text("Done"))
                        ],
                      );
                    },
                  );
                });
          },
          child: const Icon(Icons.add)),
      body: Selector<TodoProvider, (bool, List<Todo>)>(
        selector: (_, provider) => (provider.isInitialLoading, provider.todos),
        builder: (context, record, child) {
          bool isInitialLoading = record.$1;
          List<Todo> todos = record.$2;

          if (isInitialLoading) {
            return const Center(child: CircularProgressIndicator());
          } else {
            if (todos.isEmpty) {
              return const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Center(child: Text("No todo found. Click on the + icon to get started")),
              );
            } else {
              return SingleChildScrollView(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    children: todos.map((todo) {
                      return Container(
                        margin: const EdgeInsets.only(bottom: 8),
                        child: ListTile(
                          leading: Checkbox(
                              value: todo.isDone,
                              onChanged: (val) async {
                                // final isEdited =
                                await todoProvider.markUnmarkdone(todo, val ?? false);

                                // if (context.mounted) {
                                //   snackBarHelper(context,
                                //       message: isEdited ? "Edited successfully" : todoProvider.error,
                                //       type: isEdited ? AnimatedSnackBarType.success : AnimatedSnackBarType.error);
                                // }
                              }),
                          title: Text(todo.title),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                          subtitle: Text(getPriority(todo.priority)),
                          tileColor: todo.isDone ? Colors.grey.withOpacity(0.5) : null,
                          trailing: IconButton.outlined(
                              onPressed: () async {
                                showDialog(
                                    context: context,
                                    builder: (ctx) {
                                      return AlertDialog(
                                        title: const Text("Delete Todo"),
                                        contentPadding: const EdgeInsets.all(16),
                                        content: const Text("Are you sure to delete item from list?"),
                                        actions: [
                                          // cancel
                                          TextButton(
                                              onPressed: () => Navigator.of(ctx).pop(), child: const Text("Cancel")),
                                          TextButton(
                                              onPressed: () async {
                                                await todoProvider.deleteTodo(todo);

                                                if (context.mounted) {
                                                  snackBarHelper(context, message: "Deleted successfully");

                                                  Navigator.of(ctx).pop();
                                                }
                                              },
                                              child: const Text("Delete"))
                                        ],
                                      );
                                    });
                              },
                              icon: const Icon(Icons.delete)),
                        ),
                      );
                    }).toList(),
                  ));
            }
          }
        },
      ),
    );
  }
}
