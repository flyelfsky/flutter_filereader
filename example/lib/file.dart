import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_file_preview/flutter_resource_preview.dart';

class ResourcePreviewPage extends StatefulWidget {
  final String? filePath;

  ResourcePreviewPage({Key? key, required this.filePath}) : super(key: key);

  @override
  _ResourcePreviewPageState createState() => _ResourcePreviewPageState();
}

class _ResourcePreviewPageState extends State<ResourcePreviewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: Text("文档"),
    ),
    body: PageView.builder(
      itemCount: 2,
      itemBuilder: (BuildContext context, int index) => ResourcePreviewView(
        filePath: widget.filePath,
        gestureRecognizers: Set()//..add(Factory<PlatformViewHorizontalGestureRecognizer>(() => PlatformViewHorizontalGestureRecognizer()))
          ..add(Factory<ScaleGestureRecognizer>(() => ScaleGestureRecognizer()))
          ..add(Factory<TapGestureRecognizer>(() => TapGestureRecognizer()..onTapDown = (detail){
            print("onTapDown");
            }..onTapUp = (detail){
            print("onTapUp");
          }))
      )
    )
    // body: ResourcePreviewView(
    //   filePath: widget.filePath,
    // ),
    );
  }
}
