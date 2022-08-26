import 'package:flutter/material.dart';

// Convert Hex To Color
Color hexToColor(String hex) {
  return Color(int.parse("0xff$hex"));
}

// Capitalize
String capitalize(String? string) {
  if (string == null) return "";
  if (string.isEmpty) {
    return string;
  }
  return string[0].toUpperCase() + string.substring(1);
}

// Trim Content
String trimString(String? content) {
  if (content == null) return "";
  int index = content.indexOf('[+');
  if (index == -1) return content;
  return content.substring(0, index);
}
