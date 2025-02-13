import 'package:flutter/material.dart';
import 'package:hotbap/pages/filter/widgets/input_box.dart';
import 'package:hotbap/pages/filter/widgets/tag_box.dart';

Widget buildSectionWithInput(
  String title,
  List<String> options,
  TextEditingController controller,
  Function(String) onSubmitted,
  List<String> selectedTags,
  Function(String) onSelected
) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      SizedBox(height: 10),
      InputBox(
        controller: controller,
        label: title == '카테고리' ? '카테고리를 입력해주세요' : '재료를 입력해주세요',
        onSubmitted: (value) {
          onSubmitted(value);
        },
      ),
      SizedBox(height: 10),
      Wrap(
        spacing: 10,
        runSpacing: 9, // 줄 간격 추가
        children: options.map((option) {
          return TagBox(
            text: option,
            isSelected: selectedTags.contains(option),
            isDefault: options.contains(option),
            onSelected: (tag){
              onSelected(tag);
            },
            onRemove: () {
              options.remove(option);
            },
          );
        }).toList(),
      ),
      SizedBox(height: 20),
    ],
  );
}

Widget buildSectionWithoutInput(String title, List<String> options,List<String> selectedTags,
  Function(String) onSelected) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      SizedBox(height: 10),
      Wrap(
        spacing: 10,
        runSpacing: 9, // 줄 간격 추가
        children: options.map((option) {
          return TagBox(
            text: option,
            isSelected: selectedTags.contains(option),
            isDefault: options.contains(option),
            onSelected: (tag){
              onSelected(tag);
            },
            onRemove: () {
              options.remove(option);
            },
          );
        }).toList(),
      ),
      SizedBox(height: 20),
    ],
  );
}