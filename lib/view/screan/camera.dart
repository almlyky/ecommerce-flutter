// import 'package:flutter/material.dart';
// import 'package:flutter_vlc_player/flutter_vlc_player.dart';
//
// class VideoStreamPage extends StatefulWidget {
//   @override
//   _VideoStreamPageState createState() => _VideoStreamPageState();
// }
//
// class _VideoStreamPageState extends State<VideoStreamPage> {
//   VlcPlayerController? _vlcViewController;
//
//   @override
//   void initState() {
//     super.initState();
//     _vlcViewController = VlcPlayerController.network(
//     // final String url='rtsp://<admin>:<Aa123456>/7G079D7PAZA46B4/<1>';
//
//     'rtsp://admin:Aa1234565@192.168.1.100/7G079D7PAZA46B4',
//       autoPlay: true,
//     );
//   }
//
//   @override
//   void dispose() {
//     _vlcViewController?.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('NVR Camera Stream'),
//       ),
//       body: Center(
//         child: VlcPlayer(
//           controller: _vlcViewController!,
//           aspectRatio: 16 / 9,
//           placeholder: Center(child: CircularProgressIndicator()),
//         ),
//       ),
//     );
//   }
// }
