// import 'package:clima_ui/new_design/actions/adapt.dart';
// import 'package:flutter/material.dart';
//
// class AdditionalInfo extends StatelessWidget {
//   const AdditionalInfo({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final TextStyle _titleStyle = TextStyle(
//       fontWeight: FontWeight.bold,
//       fontSize: (Adapt.px(28) as num).toDouble(),
//     );
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 35),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: <Widget>[
//           Text(
//             'Additional Info',
//             style: TextStyle(
//               fontSize: (Adapt.px(35) as num).toDouble(),
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           SizedBox(height: (Adapt.px(40) as num).toDouble()),
//           Row(
//             children: <Widget>[
//               SizedBox(
//                 width: (Adapt.px(150) as num).toDouble(),
//                 child: Text('Wind', style: _titleStyle),
//               ),
//               SizedBox(
//                 width: (Adapt.px(120) as num).toDouble(),
//                 child: const Text('2.43 km/h'),
//               ),
//               SizedBox(
//                 width: (Adapt.px(60) as num).toDouble(),
//               ),
//               SizedBox(
//                 width: (Adapt.px(150) as num).toDouble(),
//                 child: Text('Humidity', style: _titleStyle),
//               ),
//               SizedBox(
//                 width: (Adapt.px(120) as num).toDouble(),
//                 child: const Text(
//                   '73 %',
//                 ),
//               )
//             ],
//           ),
//           SizedBox(
//             height: (Adapt.px(30) as num).toDouble(),
//           ),
//           Row(
//             children: <Widget>[
//               SizedBox(
//                 width: (Adapt.px(150) as num).toDouble(),
//                 child: Text('Visibility', style: _titleStyle),
//               ),
//               SizedBox(
//                 width: (Adapt.px(120) as num).toDouble(),
//                 child: const Text('9.916 km'),
//               ),
//               SizedBox(
//                 width: (Adapt.px(60) as num).toDouble(),
//               ),
//               SizedBox(
//                 width: (Adapt.px(150) as num).toDouble(),
//                 child: Text(
//                   'UV',
//                   style: _titleStyle,
//                 ),
//               ),
//               SizedBox(
//                 width: (Adapt.px(120) as num).toDouble(),
//                 child: const Text('3'),
//               )
//             ],
//           ),
//           SizedBox(height: (Adapt.px(30) as num).toDouble()),
//           SizedBox(height: (Adapt.px(300) as num).toDouble()),
//         ],
//       ),
//     );
//   }
// }
