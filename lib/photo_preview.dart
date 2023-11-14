import 'dart:io';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';

class PhotoPreview extends StatelessWidget {
  final String imagePath;

  const PhotoPreview({required this.imagePath, super.key});

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
            Navigator.pop(context);// ここに×ボタンが押されたときの処理を書く
          },
          child: Image.asset(
            'assets/Icon.png', // 画像のパス
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15), // 右に10ピクセルずらす
            child: GestureDetector(
              onTap: () {
              },
              child: SvgPicture.asset(
                'assets/mi_log-in.svg', // SVGファイルのパス // 高さ
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
  bottom: false, // SafeAreaのbottomをtrueに設定
  child: Column(
    children: [
      GestureDetector(
        onTap: () {

        },
        child: Image.file(
          File(imagePath),
        ),
      ),
      Expanded( // Row内のContainerにExpandedを追加
        child: Container(
          height: 150,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/green.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                child: Container(
                  child: Image.asset(
                    'assets/Rectangle 134.png',
                  ),
                ),
                onTap: (){
                  Navigator.pop(context);
                },
              ),
              Stack(
                children: [
                  GestureDetector(
                    child: Container(
                      child: Image.asset(
                        'assets/Rectangle 133.png',
                      ),
                    ),
                  ),
                  Positioned.fill(
                    child: GestureDetector(
                      child: Container(
                        child: Image.asset(
                          'assets/use.png',
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                      onTap: () {
                        // タッチアクションを追加する場合はここに処理を追加
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ],
  ),
),


    );
  }
}
