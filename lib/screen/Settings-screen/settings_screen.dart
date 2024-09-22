// import 'package:flutter/material.dart';

// class  SettingsScreen extends StatelessWidget {
//   const SettingsScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return  Scaffold(
//       appBar: AppBar(
//         title: Text('Settings'),
//       ),
//       body: SingleChildScrollView(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             _buildSectionTitle('About'),
//             _buildSectionContent(settingsData['about']!),
//             SizedBox(height: 20),
//             _buildSectionTitle('Terms & Conditions'),
//             _buildSectionContent(settingsData['terms']!),
//           ],
//         ),
//       ),
//     );
//   }
// }