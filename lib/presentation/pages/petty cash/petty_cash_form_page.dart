import 'package:flutter/material.dart';

class PettyCashFormPage extends StatelessWidget {
  const PettyCashFormPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "Form Petty Cash",
        style: Theme.of(context).textTheme.titleLarge,
      ),
    );
  }
}
