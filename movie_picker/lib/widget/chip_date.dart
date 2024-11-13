import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:movie_picker/preferences.dart';

class ChipDate extends StatelessWidget {
  final DateTime date;
  final Color color;
  final String dateFormat;

  const ChipDate({
    super.key,
    required this.date,
    this.color = Colors.black,
    this.dateFormat = pDateFormat,
  });

  @override
  Widget build(BuildContext context) {
    return Chip(
      backgroundColor: color,
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      avatar: const CircleAvatar(
        backgroundColor: Colors.transparent,
        child: Icon(
          Icons.calendar_month_rounded,
          size: 15,
          color: Colors.white,
        ),
      ),
      label: Column(
        children: [
          const Text(
            'Data de Lançamento',
            textAlign: TextAlign.end,
            style: TextStyle(
              fontSize: 10,
              color: Colors.white,
            ),
          ),
          Text(
            DateFormat(dateFormat).format(date),
            textAlign: TextAlign.end,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
