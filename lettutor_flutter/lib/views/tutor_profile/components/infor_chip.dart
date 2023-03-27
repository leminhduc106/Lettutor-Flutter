import 'package:flutter/material.dart';
import 'package:lettutor_flutter/utils/base_style.dart';

class InforChips extends StatelessWidget {
  const InforChips(
      {Key? key, required String title, required List<String> chips})
      : _title = title,
        _chips = chips,
        super(key: key);

  final String _title;
  final List<String> _chips;

  List<Widget> _generateChips() {
    return _chips
        .map((chip) => Container(
              margin: const EdgeInsets.only(top: 5, right: 8),
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                  color: Colors.blue[50],
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  border: Border.all(color: Colors.blue[100] as Color)),
              child: Text(chip,
                  style: BaseTextStyle.body3(
                      fontSize: 13, color: Colors.blue[400])),
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10, bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(_title,
              style: BaseTextStyle.heading2(fontSize: 17, color: Colors.blue)),
          SizedBox(
            height: 40,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _generateChips().length,
              itemBuilder: (context, index) {
                return _generateChips()[index];
              },
              shrinkWrap: true,
            ),
          ),
        ],
      ),
    );
  }
}
