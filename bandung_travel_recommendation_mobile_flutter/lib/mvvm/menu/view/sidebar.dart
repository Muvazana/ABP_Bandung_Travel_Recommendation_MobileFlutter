// import 'package:flutter/material.dart';
// import 'package:sidebarx/sidebarx.dart';

// class Sidebar extends StatelessWidget {
//   static const routeName = '/Dashboard';
//   Sidebar({Key? key}) : super(key: key);

//   final _controller = SidebarXController(selectedIndex: 0,extended: true);

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         appBar: AppBar(title: Text("Test")),
//         drawer: SidebarX(
//           controller: _controller,
//           theme: SidebarXTheme(
//             decoration: BoxDecoration(
//               color: canvasColor,
//             ),
//             textStyle: const TextStyle(color: Colors.white),
//             selectedTextStyle: const TextStyle(color: Colors.white),
//             itemTextPadding: const EdgeInsets.only(left: 30),
//             selectedItemTextPadding: const EdgeInsets.only(left: 30),
//             itemDecoration: BoxDecoration(
//               border: Border.all(color: canvasColor),
//             ),
//             selectedItemDecoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(10),
//               // border: Border.all(
//               //   color: actionColor.withOpacity(0.37),
//               // ),
//               gradient: const LinearGradient(
//                 colors: [accentCanvasColor, canvasColor],
//               ),
//             ),
//             iconTheme: const IconThemeData(
//               color: Colors.white,
//               size: 20,
//             ),
//           ),
//           extendedTheme: const SidebarXTheme(
//             width: 200,
//             decoration: BoxDecoration(
//               color: canvasColor,
//             ),
//             margin: EdgeInsets.only(right: 10),
//           ),
//           footerDivider: divider,
//           headerBuilder: (context, extended) {
//             return SizedBox(
//               height: 100,
//               child: Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Container(),
//               ),
//             );
//           },
//           showToggleButton: false,
//           items: [
//             SidebarXItem(
//               icon: Icons.home,
//               label: 'Home',
//               onTap: () {
//                 debugPrint('Hello');
//               },
//             ),
//             const SidebarXItem(
//               icon: Icons.search,
//               label: 'Search',
//             ),
//             const SidebarXItem(
//               icon: Icons.people,
//               label: 'People',
//             ),
//             const SidebarXItem(
//               icon: Icons.favorite,
//               label: 'Favorite',
//             ),
//           ],
//         ),
//         body: _ScreensExample(
//           controller: _controller,
//         ),
//       ),
//     );
//   }
// }

// class _ScreensExample extends StatelessWidget {
//   const _ScreensExample({
//     Key? key,
//     required this.controller,
//   }) : super(key: key);

//   final SidebarXController controller;

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     return AnimatedBuilder(
//       animation: controller,
//       builder: (context, child) {
//         switch (controller.selectedIndex) {
//           case 0:
//             return ListView.builder(
//               padding: const EdgeInsets.only(top: 10),
//               itemBuilder: (context, index) => Container(
//                 height: 100,
//                 width: double.infinity,
//                 margin: const EdgeInsets.only(bottom: 10, right: 10),
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(20),
//                   color: Theme.of(context).canvasColor,
//                   boxShadow: const [BoxShadow()],
//                 ),
//               ),
//             );
//           case 1:
//             return Center(
//               child: Text(
//                 'Search',
//                 style: TextStyle(color: Colors.black),
//               ),
//             );
//           case 2:
//             return Center(
//               child: Text(
//                 'People',
//                 style: TextStyle(color: Colors.black),
//               ),
//             );
//           case 3:
//             return Center(
//               child: Text(
//                 'Favorites',
//                 style: TextStyle(color: Colors.black),
//               ),
//             );
//           default:
//             return Center(
//               child: Text(
//                 'Not found page',
//                 style: TextStyle(color: Colors.black),
//               ),
//             );
//         }
//       },
//     );
//   }
// }

// const primaryColor = Color(0xFF685BFF);
// const canvasColor = Color(0xFF2E2E48);
// const scaffoldBackgroundColor = Color(0xFF464667);
// const accentCanvasColor = Color(0xFF3E3E61);
// const white = Colors.white;
// final actionColor = const Color(0xFF5F5FA7).withOpacity(0.6);

// final divider = Divider(color: white.withOpacity(0.3), height: 1);
