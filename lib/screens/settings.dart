import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Account'),
            onTap: () {
              // Handle account settings
            },
          ),
          ListTile(
            leading: Icon(Icons.notifications),
            title: Text('Notifications'),
            onTap: () {
              // Handle notification settings
            },
          ),
          ListTile(
            leading: Icon(Icons.security),
            title: Text('Privacy'),
            onTap: () {
              // Handle privacy settings
            },
          ),
          ListTile(
            leading: Icon(Icons.color_lens),
            title: Text('Appearance'),
            onTap: () {
              // Handle appearance settings
            },
          ),
          ListTile(
            leading: Icon(Icons.language),
            title: Text('Language'),
            onTap: () {
              // Handle language settings
            },
          ),
        ],
      ),
    );
  }
}
