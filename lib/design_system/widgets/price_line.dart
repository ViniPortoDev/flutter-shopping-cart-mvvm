import 'package:flutter/material.dart';

class PriceLine extends StatelessWidget {
  final String label;
  final String value;
  final bool bold;

  const PriceLine({
    super.key,
    required this.label,
    required this.value,
    this.bold = false,
  });

  @override
  Widget build(BuildContext context) {
    final style = bold
        ? const TextStyle(fontWeight: FontWeight.w800, fontSize: 16)
        : const TextStyle(fontWeight: FontWeight.w500);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: style),
        Text(value, style: style),
      ],
    );
  }
}
