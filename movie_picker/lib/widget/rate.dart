import 'package:flutter/material.dart';

class Rate extends StatelessWidget {
  final double value;
  const Rate({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    return Chip(
      backgroundColor: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 4),
      avatar: const Icon(
        Icons.favorite_outlined,
        color: Colors.red,
      ),
      label: Column(
        children: [
          const Text(
            'Nota',
            textAlign: TextAlign.end,
            style: TextStyle(
              fontSize: 10,
              color: Colors.black,
            ),
          ),
          Text(
            value.toStringAsFixed(1),
            style: const TextStyle(fontSize: 15),
          ),
        ],
      ),
    );
  }
}
