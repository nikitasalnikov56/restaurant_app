import 'package:flutter/material.dart';
import 'package:test_app/ui/pages/assign_waiter_screen.dart';
import 'package:test_app/ui/pages/table_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: const Drawer(),
        appBar: AppBar(
          leading: const OpenDrawerButton(),
          title: const Text('Table Service'),
          centerTitle: true,
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AssignWaiterScreen(),
                  ),
                );
              },
              child: const Text('Назначить официанта'),
            ),
          ],
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Default Room'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            TableScreen(),
          ],
        )
        // Column(
        //   children: [
        //     const Expanded(
        //       child: TableScreen(),
        //     ),
        //     ElevatedButton(
        //       onPressed: () {
        //         Navigator.push(
        //           context,
        //           MaterialPageRoute(builder: (context) => const MenuScreen()),
        //         );
        //       },
        //       child: const Text('Перейти к меню'),
        //     ),
        //   ],
        // ),
        );
  }
}

class OpenDrawerButton extends StatelessWidget {
  const OpenDrawerButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        Scaffold.of(context).openDrawer();
      },
      icon: const Icon(Icons.menu),
    );
  }
}
