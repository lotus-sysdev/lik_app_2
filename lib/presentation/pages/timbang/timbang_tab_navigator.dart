import 'package:flutter/material.dart';
import 'package:lik_app_2/presentation/pages/timbang/timbang_form_page.dart';
import 'package:lik_app_2/presentation/pages/timbang/timbang_summary_page.dart';

class TimbangTabNavigator extends StatefulWidget {
  const TimbangTabNavigator({super.key});

  @override
  _TimbangTabNavigatorState createState() => _TimbangTabNavigatorState();
}

class _TimbangTabNavigatorState extends State<TimbangTabNavigator> {
  int _currentIndex = 0;
  final List<Widget> _pages = [
    const TimbangFormPage(),
    const TimbangSummaryPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tiket Timbang"),
        centerTitle: true,
        elevation: 0,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue.shade700, Colors.blue.shade400],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 10,
              offset: const Offset(0, -3),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          child: BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            backgroundColor: Colors.white,
            selectedItemColor: Colors.blue.shade700,
            unselectedItemColor: Colors.grey.shade600,
            selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
            items: [
              BottomNavigationBarItem(
                icon: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color:
                        _currentIndex == 0
                            ? Colors.blue.shade100
                            : Colors.transparent,
                  ),
                  child: const Icon(Icons.edit_document, size: 26),
                ),
                label: 'Input Timbang',
              ),
              BottomNavigationBarItem(
                icon: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color:
                        _currentIndex == 1
                            ? Colors.blue.shade100
                            : Colors.transparent,
                  ),
                  child: const Icon(Icons.history, size: 26),
                ),
                label: 'Riwayat',
              ),
            ],
          ),
        ),
      ),
      // Add a floating action button for quick access to the main action
      floatingActionButton:
          _currentIndex == 0
              ? FloatingActionButton(
                onPressed: () {
                  // Handle form submission or main action
                },
                backgroundColor: Colors.blue.shade700,
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Icon(Icons.save, color: Colors.white),
              )
              : null,
    );
  }
}
