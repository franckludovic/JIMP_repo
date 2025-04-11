import 'package:flutter/material.dart';

class IconMapper {
  static IconData getIconFromString(String iconName) {
    switch (iconName.toLowerCase()) {
      case 'code':
        return Icons.code;
      case 'business':
        return Icons.business_center;
      case 'design':
        return Icons.brush;
      case 'data':
        return Icons.bar_chart;
      case 'ai':
        return Icons.smart_toy;
      case 'finance':
        return Icons.attach_money;
      case 'marketing':
        return Icons.campaign;
      case 'engineering':
        return Icons.engineering;
      case 'education':
        return Icons.school;
      case 'health':
        return Icons.local_hospital;
      case 'legal':
        return Icons.gavel;
      case 'retail':
        return Icons.store;
      case 'media':
        return Icons.movie_creation;
      case 'security':
        return Icons.security;
      case 'support':
        return Icons.headset_mic;
    // New cases added:
      case 'human_resources':
        return Icons.people;
      case 'local_shipping':
        return Icons.local_shipping;
      case 'palette':
        return Icons.palette;
      default:
        return Icons.work_outline;
    }
  }

  static Color getIconColorFromString(String iconName) {
    switch (iconName.toLowerCase()) {
      case 'code':
        return Colors.blue;
      case 'business':
        return Colors.indigo;
      case 'design':
        return Colors.pinkAccent;
      case 'data':
        return Colors.teal;
      case 'ai':
        return Colors.deepPurple;
      case 'finance':
        return Colors.green;
      case 'marketing':
        return Colors.orange;
      case 'engineering':
        return Colors.brown;
      case 'education':
        return Colors.redAccent;
      case 'health':
        return Colors.purple;
      case 'legal':
        return Colors.grey;
      case 'retail':
        return Colors.amber;
      case 'media':
        return Colors.lightBlue;
      case 'security':
        return Colors.black;
      case 'support':
        return Colors.cyan;
      case 'human_resources':
        return Colors.deepOrange;
      case 'local_shipping':
        return Colors.lightGreen;
      case 'palette':
        return Colors.purpleAccent;
      default:
        return Colors.black; // Fallback color
    }
  }
}


