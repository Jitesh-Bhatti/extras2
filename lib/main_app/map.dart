import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:extras2/main_app/pop_up_navigator.dart';

// Declare the GlobalKey at the top level
final GlobalKey<_MapScreenState> mapScreenKey = GlobalKey<_MapScreenState>();

class MapScreen extends StatefulWidget {
  // Add the GlobalKey as a required parameter
  MapScreen({Key? key}) : super(key: mapScreenKey);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final LatLng _center = LatLng(20.5937, 78.9629);
  double _popUpWidth = 0.0; // Start with the pop-up hidden
  bool _showMenuOptions = true; // Show menu options initially

  @override
  void initState() {
    super.initState();
  }

  // Function to open the pop-up
  void openPopUp() {
    setState(() {
      _popUpWidth = 300.0; // Default width for the pop-up
      _showMenuOptions = true; // Show menu options initially
    });
  }

  // Function to close the pop-up
  void closePopUp() {
    setState(() {
      _popUpWidth = 0.0; // Close the pop-up
    });
  }

  // Function to open the chat view
  void openChat() {
    setState(() {
      _showMenuOptions = false; // Hide menu options and show chat
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final mapPadding = screenWidth * 0.02;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.all(mapPadding),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: FlutterMap(
                options: MapOptions(
                  center: _center,
                  zoom: 5.0,
                  minZoom: 2.0,
                  maxZoom: 18.0,
                ),
                children: [
                  TileLayer(
                    urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                    subdomains: ['a', 'b', 'c'],
                  ),
                ],
              ),
            ),
          ),
          // FloatingActionButton to open pop-up
          Positioned(
            top: 40,
            right: 40,
            child: FloatingActionButton(
              onPressed: openPopUp, // Use the function to open pop-up
              backgroundColor: Colors.grey[850],
              child: Icon(Icons.menu, color: Colors.blueAccent),
              elevation: 5,
            ),
          ),
          // Resizable Pop-up Navigator on the right side
          if (_popUpWidth > 0) // Show only if the pop-up is open
            Positioned(
              top: 0,
              right: 0,
              bottom: 0,
              child: GestureDetector(
                onPanUpdate: (details) {
                  setState(() {
                    _popUpWidth -= details.delta.dx;
                    _popUpWidth = _popUpWidth.clamp(200.0, screenWidth * 0.9);
                  });
                },
                child: Container(
                  width: _popUpWidth,
                  color: Colors.black.withOpacity(0.9),
                  child: PopUpNavigator(
                    onClose: closePopUp,    // Use the function to close pop-up
                    onOpenChat: openChat,   // Use the function to open chat
                    showMenuOptions: _showMenuOptions,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}


// import 'package:flutter/material.dart';
// import 'package:flutter_map/flutter_map.dart';
// import 'package:latlong2/latlong.dart';
// import 'package:extras2/main_app/pop_up_navigator.dart';
//
// class MapScreen extends StatefulWidget {
//   final bool initialPopUpState; // Add this parameter
//
//   MapScreen({this.initialPopUpState = false}); // Add a default value for the parameter
//
//   @override
//   _MapScreenState createState() => _MapScreenState();
// }
//
// class _MapScreenState extends State<MapScreen> {
//   final LatLng _center = LatLng(20.5937, 78.9629);
//   double _popUpWidth = 0.0; // Start with the pop-up hidden
//   bool _showMenuOptions = true; // Show menu options initially
//
//
//   @override
//   void initState() {
//     super.initState();
//
//     // Set the initial state of the pop-up based on the parameter
//     if (widget.initialPopUpState) {
//       _popUpWidth = 300.0; // Default width for the pop-up
//       _showMenuOptions = true; // Show menu options initially
//     }
//   }
//   void _openPopUp() {
//     setState(() {
//       _popUpWidth = 300.0; // Default width for the pop-up
//       _showMenuOptions = true; // Show menu options initially
//     });
//   }
//
//   void _closePopUp() {
//     setState(() {
//       _popUpWidth = 0.0; // Close the pop-up
//     });
//   }
//
//   void _openChat() {
//     setState(() {
//       _showMenuOptions = false; // Hide menu options and show SplashPage (chat)
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;
//     final mapPadding = screenWidth * 0.02;
//
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: Stack(
//         children: [
//           Padding(
//             padding: EdgeInsets.all(mapPadding),
//             child: ClipRRect(
//               borderRadius: BorderRadius.circular(12),
//               child: FlutterMap(
//                 options: MapOptions(
//                   center: _center,
//                   zoom: 5.0,
//                   minZoom: 2.0,
//                   maxZoom: 18.0,
//                 ),
//                 children: [
//                   TileLayer(
//                     urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
//                     subdomains: ['a', 'b', 'c'],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           // FloatingActionButton to open pop-up
//           Positioned(
//             top: 40,
//             right: 40,
//             child: FloatingActionButton(
//               onPressed: _openPopUp,
//               backgroundColor: Colors.grey[850],
//               child: Icon(Icons.menu, color: Colors.blueAccent),
//               elevation: 5,
//             ),
//           ),
//           // Resizable Pop-up Navigator on the right side
//           if (_popUpWidth > 0) // Show only if the pop-up is open
//             Positioned(
//               top: 0,
//               right: 0,
//               bottom: 0,
//               child: GestureDetector(
//                 onPanUpdate: (details) {
//                   setState(() {
//                     _popUpWidth -= details.delta.dx;
//                     _popUpWidth = _popUpWidth.clamp(200.0, screenWidth * 0.9);
//                   });
//                 },
//                 child: Container(
//                   width: _popUpWidth,
//                   color: Colors.black.withOpacity(0.9),
//                   child: PopUpNavigator(
//                     onClose: _closePopUp,
//                     onOpenChat: _openChat,
//                     showMenuOptions: _showMenuOptions,
//                   ),
//                 ),
//               ),
//             ),
//         ],
//       ),
//     );
//   }
// }
//
