import 'package:flutter/material.dart';

class AddTaskPage extends StatefulWidget {
  @override
  _AddTaskPageState createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final TextEditingController controller = TextEditingController();

  String selectedCategory = 'Personal';
  final List<String> categories = ['Work', 'Study', 'Personal'];

  String selectedPriority = 'Medium';
  final List<String> priorities = ['High', 'Medium', 'Low'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Task", style: TextStyle(color: Colors.white)),
        backgroundColor: Color(0xFF81D4FA),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: controller,
              decoration: InputDecoration(
                labelText: "Write your task here",
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF81D4FA), width: 2),
                ),
                labelStyle: TextStyle(color: Color(0xFF81D4FA)),
              ),
            ),
            SizedBox(height: 20),

            DropdownButtonFormField<String>(
              initialValue: selectedCategory,
              decoration: InputDecoration(labelText: "Category"),
              items: categories.map((cat) {
                return DropdownMenuItem(value: cat, child: Text(cat));
              }).toList(),
              onChanged: (val) => setState(() => selectedCategory = val!),
            ),

            SizedBox(height: 10),

            DropdownButtonFormField<String>(
              initialValue: selectedPriority,
              decoration: InputDecoration(labelText: "Priority"),
              items: priorities.map((p) {
                return DropdownMenuItem(value: p, child: Text(p));
              }).toList(),
              onChanged: (val) => setState(() => selectedPriority = val!),
            ),

            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                if (controller.text.isNotEmpty) {
                  // send all info
                  Navigator.pop(context, {
                    'title': controller.text,
                    'category': selectedCategory,
                    'priority': selectedPriority,
                  });
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF81D4FA),
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              ),
              child: Text("Save"),
            ),
          ],
        ),
      ),
    );
  }
}
