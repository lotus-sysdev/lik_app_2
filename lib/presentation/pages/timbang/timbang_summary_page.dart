import 'package:flutter/material.dart';

class TimbangSummaryPage extends StatelessWidget {
  const TimbangSummaryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "Riwayat Penimbangan",
        style: Theme.of(context).textTheme.titleLarge,
      ),
    );
  }
}
