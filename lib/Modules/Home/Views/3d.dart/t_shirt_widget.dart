import 'package:flutter/material.dart';
import 'package:flutter_3d_controller/flutter_3d_controller.dart';

class TShirt3DWidget extends StatefulWidget {
  const TShirt3DWidget({super.key});

  @override
  State<TShirt3DWidget> createState() => _TShirt3DWidgetState();
}

class _TShirt3DWidgetState extends State<TShirt3DWidget> {
  final Flutter3DController _controller = Flutter3DController();
  bool _hasError = false;

  @override
  Widget build(BuildContext context) {
    if (_hasError) {
      return Placeholder();
    }

    return SizedBox(
      width: 150,
      height: 150,
      child: Flutter3DViewer(
        src: 'assets/3D/t-shirt3D.glb',

        controller: _controller,
        progressBarColor: Colors.transparent,
        onError: (error) {
          print("3D Viewer Error: $error");
          setState(() => _hasError = true);
        },
        onLoad: (_) {
          // print(" loaded successfully");
          _controller.setCameraOrbit(-140, 70, 220);
        },
      ),
    );
  }
}
