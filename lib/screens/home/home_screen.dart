import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('答题软件')),
      body: GridView.count(
        crossAxisCount: 2,
        padding: const EdgeInsets.all(16.0),
        crossAxisSpacing: 16.0,
        mainAxisSpacing: 16.0,
        children: <Widget>[
          _buildMenuCard(context, '题库管理', Icons.library_books, '/bank'),
          _buildMenuCard(context, '答题模式', Icons.assignment, '/quiz'),
          _buildMenuCard(context, '学习辅助', Icons.school, '/study'),
          _buildMenuCard(context, '数据统计', Icons.bar_chart, '/stats'),
          _buildMenuCard(context, '设置', Icons.settings, '/settings'),
        ],
      ),
    );
  }

  Widget _buildMenuCard(
    BuildContext context,
    String title,
    IconData icon,
    String route,
  ) {
    return Card(
      child: InkWell(
        onTap: () => context.go(route),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(icon, size: 48.0, color: Theme.of(context).iconTheme.color),
            const SizedBox(height: 8.0),
            Text(title, style: Theme.of(context).textTheme.titleMedium),
          ],
        ),
      ),
    );
  }
}
