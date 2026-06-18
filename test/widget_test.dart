import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:listit/main.dart'; // استبدلي YOUR_PROJECT_NAME باسم مشروعك

void main() {
  testWidgets('إضافة مهمة جديدة تظهر في القائمة', (WidgetTester tester) async {
    // 1. تشغيل التطبيق
    await tester.pumpWidget(MaterialApp(home: HomePage()));

    // 2. التحقق من وجود نص "My Tasks"
    expect(find.text('My Tasks'), findsOneWidget);

    // 3. الضغط على زر الإضافة
    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle(); // ننتظر انتقال الصفحة

    // 4. التأكد أننا في صفحة إضافة المهام
    expect(find.text('Add Task'), findsOneWidget);
  });
}
