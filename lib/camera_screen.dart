import 'package:camera/camera.dart';
import 'package:flutter_svg/svg.dart';
import 'package:myflutter/photo_preview.dart';
import 'package:flutter/material.dart';
// 初期値を設定

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  CameraController? _cameraController;
  bool _isCameraReady = false;
  String svgPath = 'assets/fluent_flash-28-regular.svg';

  @override
  void initState() {
    super.initState();
    // //   super.initState();

    // availableCameras().then((cameras) {
    //   final frontCamera = cameras.firstWhere(
    //     (camera) => camera.lensDirection == CameraLensDirection.front,
    //   );

    //   if (_cameraController == null) {
    //     _cameraController = CameraController(
    //       frontCamera, // インカメを使用します
    //       ResolutionPreset.medium,
    //     );

    //     _cameraController!.initialize().then((_) {
    //       setState(() {
    //         _isCameraReady = true;
    //       });
    //     });
    //   }
    // });

    availableCameras().then((cameras) {
      if (cameras.isNotEmpty && _cameraController == null) {
        _cameraController = CameraController(
          cameras.last,
          ResolutionPreset.medium,
        );

        _cameraController!.initialize().then((_) {
          setState(() {
            _isCameraReady = true;
          });
        });
      }
    });
  }

  void _onTakePicture(BuildContext context) {
    _cameraController!.takePicture().then((image) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => PhotoPreview(
            imagePath: image.path,
          ),
        ),
      );
    });
  }

  void _switchCamera() {
    availableCameras().then((cameras) {
      // 現在のカメラがバックカメラならフロントカメラに、フロントカメラならバックカメラに切り替えます
      final newCamera = _cameraController!.description.lensDirection ==
              CameraLensDirection.back
          ? cameras.firstWhere(
              (camera) => camera.lensDirection == CameraLensDirection.front)
          : cameras.firstWhere(
              (camera) => camera.lensDirection == CameraLensDirection.back);

      _cameraController = CameraController(
        newCamera,
        ResolutionPreset.medium,
      );

      _cameraController!.initialize().then((_) {
        setState(() {
          _isCameraReady = true;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/green.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        leading: GestureDetector(
          onTap: () {
            // ここに×ボタンが押されたときの処理を書く
          },
          child: Image.asset(
            'assets/Icon.png', // 画像のパス
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  if (svgPath == 'assets/fluent_flash-28-regular.svg') {
                    svgPath = 'assets/Vector.svg';
                    debugPrint('push');
                  } else {
                    svgPath = 'assets/fluent_flash-28-regular.svg';
                  }
                });
              },
              child: SvgPicture.asset(
                svgPath, // SVGファイルのパス // 高さ
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  _cameraController != null && _isCameraReady
                      ? CameraPreview(_cameraController!)
                      : Container(
                          color: Colors.grey,
                        ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: GestureDetector(
                      onTap: _switchCamera,
                      child: Image.asset('assets/Change.png'),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 150,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/green.png'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: _cameraController != null
                        ? () => _onTakePicture(context)
                        : null,
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      child: Image.asset(
                        'assets/Ellipse 107.png',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
