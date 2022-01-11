import 'package:flutter/material.dart';

class SelectionCard extends StatelessWidget {
  final String label;
  final onTap;
  SelectionCard({
    required this.label,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Card(
        child: ListTile(
          title: Text(label),
          trailing: const Icon(Icons.arrow_forward_ios),
        ),
      ),
      onTap: onTap,
    );
  }
}
