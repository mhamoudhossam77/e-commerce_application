import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ProfileOption extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final Color? highlightColor;

  const ProfileOption({
    Key? key,
    required this.icon,
    required this.title,
    required this.onTap,
    this.highlightColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.05, // Dynamic padding
        vertical: screenWidth * 0.02,
      ),
      child: ListTile(
        leading: Icon(
          icon,
          color: highlightColor ?? Colors.grey[700], // Highlight color
          size: screenWidth * 0.08,
        ),
        title: Text(
          title,
          style: TextStyle(
            fontSize: screenWidth * 0.045,
            fontWeight: FontWeight.w600,
            color: highlightColor ?? Colors.black,
          ),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          color: highlightColor ?? Colors.grey[700],
        ),
        onTap: onTap,
      ),
    );
  }
}