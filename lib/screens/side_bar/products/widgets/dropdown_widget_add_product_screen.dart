import 'package:flutter/material.dart';

class DropDownWidgetAddProductScreen extends StatelessWidget {
  final String? dropDownValue;
  final String? hintText;
  final List<String> dropDownList;
  final Function(String?)? onChanged;

  const DropDownWidgetAddProductScreen({
    super.key,
    required this.dropDownValue,
    required this.dropDownList,
    this.onChanged,
    this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: Colors.black),
        color: Colors.white,
      ),
      child: DropdownButton<String>(
        isExpanded: true,
        value: dropDownList.contains(dropDownValue) ? dropDownValue : null,
        hint: Text(hintText ?? ""),
        underline: const SizedBox(),
        items:
            dropDownList
                .map(
                  (cat) =>
                      DropdownMenuItem<String>(value: cat, child: Text(cat)),
                )
                .toList(),
        onChanged: onChanged,
      ),
    );
  }
}
