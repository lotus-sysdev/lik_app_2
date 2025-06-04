import 'package:flutter/material.dart';

class PettyCashSummaryPage extends StatelessWidget {
  const PettyCashSummaryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "Riwayat Petty Cash",
        style: Theme.of(context).textTheme.titleLarge,
      ),
    );
  }
}
