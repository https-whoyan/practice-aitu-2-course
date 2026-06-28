import 'package:flutter/material.dart';

import '../domain/risk_level.dart';

/// Цветной индикатор уровня риска студента (шаг 25).
class RiskIndicator extends StatelessWidget {
  const RiskIndicator({super.key, required this.level});

  final RiskLevel level;

  Color _color(BuildContext context) {
    switch (level) {
      case RiskLevel.low:
        return Colors.green;
      case RiskLevel.medium:
        return Colors.orange;
      case RiskLevel.high:
        return Theme.of(context).colorScheme.error;
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = _color(context);
    return Chip(
      backgroundColor: color.withValues(alpha: 0.15),
      side: BorderSide(color: color),
      label: Text(
        'Риск: ${level.label}',
        style: TextStyle(color: color, fontWeight: FontWeight.w600),
      ),
    );
  }
}
