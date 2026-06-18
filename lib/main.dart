import 'package:flutter/material.dart';
import 'addTask.dart';

void main() =>
    runApp(MaterialApp(debugShowCheckedModeBanner: false, home: HomePage()));

class Task {
  String title;
  bool isDone;
  String category;
  String priority;
  Task(this.title, this.isDone, this.category, this.priority);
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Task> tasks = [];

  Color getCategoryColor(String cat) {
    if (cat == "Work") return Colors.blueAccent;
    if (cat == "Study") return Colors.greenAccent;
    return Colors.orangeAccent;
  }

  Color getPriorityColor(String p) {
    if (p == 'High') return Colors.redAccent;
    if (p == 'Medium') return Colors.orangeAccent;
    return Colors.green;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Color(0xFFF8F9FA),
        appBar: AppBar(
          title: Text(
            "My Tasks",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          backgroundColor: Color(0xFF81D4FA),
          bottom: TabBar(
            tabs: [
              Tab(text: "All"),
              Tab(text: "In Process"),
              Tab(text: "Done"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            buildTaskList(tasks),
            buildTaskList(tasks.where((t) => !t.isDone).toList()),
            buildTaskList(tasks.where((t) => t.isDone).toList()),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Color(0xFF81D4FA),
          child: Icon(Icons.edit_outlined),
          onPressed: () async {
            final result = await Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => AddTaskPage()),
            );

            if (result != null && result is Map) {
              setState(() {
                tasks.add(
                  Task(
                    result['title'],
                    false,
                    result['category'],
                    result['priority'],
                  ),
                );
              });
            }
          },
        ),
      ),
    );
  }

  Widget buildTaskList(List<Task> filteredTasks) {
    return ListView.builder(
      padding: EdgeInsets.all(10),
      itemCount: filteredTasks.length,
      itemBuilder: (context, index) {
        final task = filteredTasks[index];
        return Card(
          margin: EdgeInsets.symmetric(vertical: 5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: ListTile(
            leading: Checkbox(
              value: task.isDone,
              activeColor: Color(0xFF81D4FA),
              onChanged: (val) => setState(() => task.isDone = val!),
            ),
            title: Text(
              task.title,
              style: TextStyle(
                decoration: task.isDone ? TextDecoration.lineThrough : null,
              ),
            ),
            subtitle: Row(
              children: [
                Chip(
                  label: Text(
                    task.category,
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                  backgroundColor: getCategoryColor(
                    task.category,
                  ).withValues(alpha: 0.2),
                ),
                SizedBox(width: 5),
                Text(
                  task.priority,
                  style: TextStyle(
                    color: getPriorityColor(task.priority),
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            trailing: IconButton(
              icon: Icon(
                Icons.delete,
                color: Colors.redAccent.withValues(alpha: 0.7),
              ),
              onPressed: () => setState(() => tasks.remove(task)),
            ),
          ),
        );
      },
    );
  }
}
