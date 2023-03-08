import 'package:flutter/material.dart';
import 'package:lovelovelove/Data%20Layer/Models/atrocity_model.dart';

class AtrocityStatistics extends StatefulWidget {
  final Atrocity atrocity;

  const AtrocityStatistics({Key? key, required this.atrocity})
      : super(key: key);

  @override
  State<AtrocityStatistics> createState() => _AtrocityStatisticsState();
}

class _AtrocityStatisticsState extends State<AtrocityStatistics> {
  @override
  Widget build(BuildContext context) {
    return const Text('Atrocity Altrue Stats');
  }
}
