import 'package:flutter/material.dart';

class LabeledCheckbox extends StatelessWidget {
  const LabeledCheckbox({
    super.key,
    required this.label,
    required this.value,
    required this.time,
    required this.onChanged,
  });

  final String label;
  final String time;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onChanged(!value);
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Row(
            children: [
              Expanded(
                  child: Row(
                children: [
                  Checkbox(
                    value: value,
                    onChanged: (bool? newValue) {
                      onChanged(newValue!);
                    },
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(label),
                      Text(time),
                    ],
                  ),
                ],
              )),
              IconButton(
                icon: const Icon(Icons.arrow_right),
                onPressed: () {},
                iconSize: 33,
              )
            ],
          ),
        ),
      ),
    );
  }
}
