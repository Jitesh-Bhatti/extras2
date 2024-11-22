import 'package:flutter/material.dart';
import 'package:extras2/pages/splash_page.dart';

class PopUpNavigator extends StatelessWidget {
  final VoidCallback onClose;
  final VoidCallback onOpenChat;
  final bool showMenuOptions;

  PopUpNavigator({
    required this.onClose,
    required this.onOpenChat,
    required this.showMenuOptions,
  });

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(12);

    return Container(
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.9),
        borderRadius: borderRadius,
        border: Border.all(color: Colors.grey[850]!, width: 2), // Border to match map frame
      ),
      child: Column(
        children: [
          // Close button (remains visible in both views)
          Align(
            alignment: Alignment.topRight,
            child: IconButton(
              icon: Icon(Icons.close, color: Colors.redAccent),
              onPressed: onClose,
            ),
          ),
          if (showMenuOptions)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                children: [
                  // Home button
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                    decoration: BoxDecoration(
                      color: Colors.grey[850], // Background color for Home button
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: ListTile(
                      leading: Icon(Icons.home, color: Colors.blueAccent),
                      title: Text(
                        "Home",
                        style: TextStyle(color: Colors.white),
                      ),
                      onTap: onClose,
                    ),
                  ),
                  // Chat button
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                    decoration: BoxDecoration(
                      color: Colors.grey[850], // Background color for Chat button
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: ListTile(
                      leading: Icon(Icons.chat, color: Colors.blueAccent),
                      title: Text(
                        "Chat",
                        style: TextStyle(color: Colors.white),
                      ),
                      onTap: onOpenChat,
                    ),
                  ),
                ],
              ),
            ),
          if (!showMenuOptions)
            Expanded(
              child: Navigator(
                onGenerateRoute: (RouteSettings settings) {
                  WidgetBuilder builder;
                  switch (settings.name) {
                    case '/':
                      builder = (BuildContext context) => SplashPage();
                      break;
                    default:
                      builder = (BuildContext context) => SplashPage();
                  }
                  return MaterialPageRoute(builder: builder, settings: settings);
                },
              ),
            ),
        ],
      ),
    );
  }
}
