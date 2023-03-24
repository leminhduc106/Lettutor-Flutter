import 'package:flutter/material.dart';
import 'package:lettutor_flutter/utils/base_style.dart';

class DropdownEdit extends StatelessWidget {
  const DropdownEdit({
    Key? key,
    required this.title,
    required this.selectedItem,
    required this.items,
    required this.onChange,
  }) : super(key: key);

  final String title, selectedItem;
  final List<String> items;
  final Function(String) onChange;

  @override
  Widget build(BuildContext context) {
    final listItems = items
        .map(
          (item) => DropdownMenuItem(
            value: item,
            child: Text(item),
          ),
        )
        .toList();

    return Container(
      margin: const EdgeInsets.only(bottom: 10, top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 7, left: 5),
            child: Text(
              title,
              style: BaseTextStyle.heading1(fontSize: 17),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            width: double.infinity,
            height: 48,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black26, width: 0.3),
              borderRadius: BorderRadius.circular(10),
            ),
            child: DropdownButtonFormField<String>(
              elevation: 8,
              style: TextStyle(fontSize: 17, color: Colors.grey[700]),
              decoration: const InputDecoration(border: InputBorder.none),
              value: selectedItem,
              isExpanded: true,
              items: listItems,
              onChanged: (String? value) {
                if (value is String) {
                  onChange(value);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
