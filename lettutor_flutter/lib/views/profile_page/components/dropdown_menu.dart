import 'package:flutter/material.dart';
import 'package:lettutor_flutter/utils/base_style.dart';

class DropdownEdit extends StatelessWidget {
  const DropdownEdit({
    Key? key,
    required this.title,
    required this.selectedItem,
    required this.items,
    required this.onChange,
    required this.fieldName,
  }) : super(key: key);

  final String title, selectedItem;
  final Map<String, String> items;
  final Function(
      {DateTime? birthday,
      String phone,
      String country,
      String level}) onChange;
  final String fieldName;

  @override
  Widget build(BuildContext context) {
    final listItems = items.entries
        .map(
          (item) => DropdownMenuItem(
            value: item.key,
            child: Text(item.value),
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
                  if (fieldName == "Country") {
                    onChange(country: value);
                  } else if (fieldName == "Level") {
                    onChange(level: value);
                  }
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
