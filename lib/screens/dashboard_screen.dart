// import 'package:flutter/material.dart';
// import '../widgets/line_chart_widget.dart';
// import '../services/api_service.dart';
//
// class DashboardScreen extends StatefulWidget {
//   @override
//   _DashboardScreenState createState() => _DashboardScreenState();
// }
//
// class _DashboardScreenState extends State<DashboardScreen> {
//   List<dynamic> data = [];
//
//   @override
//   void initState() {
//     super.initState();
//     fetchData();
//   }
//
//   Future<void> fetchData() async {
//     final response = await ApiService.getData();
//     setState(() {
//       data = response;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('My Dashboard'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Column(
//           children: [
//             Expanded(
//               child: Card(
//                 child: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: LineChartWidget(),
//                 ),
//               ),
//             ),
//             SizedBox(height: 10),
//             Expanded(
//               child: ListView.builder(
//                 itemCount: data.length,
//                 itemBuilder: (context, index) {
//                   return Card(
//                     child: ListTile(
//                       title: Text(data[index]['title']),
//                       subtitle: Text(data[index]['description']),
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
