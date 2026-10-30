import 'package:flutter/material.dart';

class ThemeApp extends StatefulWidget {
  const ThemeApp({super.key});

  @override
  State<ThemeApp> createState() => _ThemeAppState();
}

class _ThemeAppState extends State<ThemeApp> {
  ThemeMode _themeMode = ThemeMode.light;

  void toggleTheme(bool isDark) {
    setState(() {
      _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Telegram Drawer & Themes',

      themeMode: _themeMode,

      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        scaffoldBackgroundColor: Colors.grey.shade100,
        colorSchemeSeed: const Color(0xFF2AABEE), 
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF2AABEE),
          foregroundColor: Colors.white,
        ),
        drawerTheme: const DrawerThemeData(backgroundColor: Colors.white),
      ),

      darkTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF182533), 
        colorSchemeSeed: const Color(0xFF2AABEE),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF213040),
          foregroundColor: Colors.white,
        ),
        drawerTheme: const DrawerThemeData(backgroundColor: Color(0xFF1d2733)),
      ),

      home: HomePage(themeMode: _themeMode, onThemeChanged: toggleTheme),
    );
  }
}

class HomePage extends StatelessWidget {
  final ThemeMode themeMode;
  final ValueChanged<bool> onThemeChanged;

  const HomePage({
    super.key,
    required this.themeMode,
    required this.onThemeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Telegram Drawer')),
      drawer: AppDrawer(themeMode: themeMode, onThemeChanged: onThemeChanged),
      body: const Center(child: Text('Chats', style: TextStyle(fontSize: 22))),
    );
  }
}

class AppDrawer extends StatelessWidget {
  final ThemeMode themeMode;
  final ValueChanged<bool> onThemeChanged;

  const AppDrawer({
    super.key,
    required this.themeMode,
    required this.onThemeChanged,
  });

  @override
  Widget build(BuildContext context) {
    final telegramBlue = const Color(0xFF2AABEE);
    final isDark = themeMode == ThemeMode.dark;

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [

          Container(
            height: 170,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF213040) : telegramBlue,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: const [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person, size: 34, color: Color(0xFF2AABEE)),
                ),
                SizedBox(height: 12),
                Text(
                  'John Doe',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  '+996 700 123 456',
                  style: TextStyle(color: Colors.white70),
                ),
              ],
            ),
          ),

          drawerItem(
            context,
            icon: Icons.chat,
            title: 'Chats',
            onTap: () => Navigator.pop(context), 
          ),
          drawerItem(
            context,
            icon: Icons.call,
            title: 'Calls',
            onTap: () {
              Navigator.pop(context); 
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const CallPage()),
              );
            },
          ),
          drawerItem(
            context,
            icon: Icons.person_2,
            title: 'Contacts',
            onTap: () {
              Navigator.pop(context); 
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ContactPage()),
              );
            },
          ),

          const Divider(),

          SwitchListTile(
            secondary: Icon(
              isDark ? Icons.dark_mode : Icons.light_mode,
              color: Theme.of(context).iconTheme.color,
            ),
            title: const Text('Dark Mode'),
            value: isDark,
            onChanged: onThemeChanged,
          ),

          drawerItem(
            context,
            icon: Icons.settings,
            title: 'Settings',
            onTap: () => Navigator.pop(context),
          ),
          drawerItem(
            context,
            icon: Icons.help_outline,
            title: 'Help',
            onTap: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  Widget drawerItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: Theme.of(context).iconTheme.color),
      title: Text(title),
      onTap: onTap,
      horizontalTitleGap: 8,
    );
  }
}

class CallPage extends StatelessWidget {
  const CallPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Calls')),
      body: const Center(
        child: Text('Call History', style: TextStyle(fontSize: 20)),
      ),
    );
  }
}

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Contacts')),
      body: const Center(
        child: Text('Contact List', style: TextStyle(fontSize: 20)),
      ),
    );
  }
}
