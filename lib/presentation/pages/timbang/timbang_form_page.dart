import 'package:flutter/material.dart';

class TimbangFormPage extends StatelessWidget {
  const TimbangFormPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "Formulir Penimbangan",
        style: Theme.of(context).textTheme.titleLarge,
      ),
    );
  }
}
