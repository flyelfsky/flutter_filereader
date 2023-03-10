import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';

import 'resource_preview.dart';

class ResourcePreviewView extends StatefulWidget {
  final String? filePath; //local path
  final Function(bool)? openSuccess;
  final Widget? loadingWidget;
  final Widget? unSupportFileWidget;
  final Set<Factory<OneSequenceGestureRecognizer>>? gestureRecognizers;

  ResourcePreviewView({Key? key, required this.filePath, this.gestureRecognizers, this.openSuccess, this.loadingWidget, this.unSupportFileWidget}) : super(key: key);

  @override
  _ResourcePreviewViewState createState() => _ResourcePreviewViewState();
}

class _ResourcePreviewViewState extends State<ResourcePreviewView> {
  ResourcePreviewState _status = ResourcePreviewState.LOADING_ENGINE;
  String? filePath;

  @override
  void initState() {
    super.initState();
    filePath = widget.filePath;
    File(filePath!).exists().then((exists) {
      if (exists) {
        _checkOnLoad();
      } else {
        _setStatus(ResourcePreviewState.FILE_NOT_FOUND);
      }
    });
  }

  _checkOnLoad() {
    ResourcePreview.instance.engineLoadStatus((success) {
      if (success) {
        _setStatus(ResourcePreviewState.ENGINE_LOAD_SUCCESS);
      } else {
        _setStatus(ResourcePreviewState.ENGINE_LOAD_FAIL);
      }
    });
  }

  _setStatus(ResourcePreviewState status) {
    _status = status;
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid || Platform.isIOS) {
      if (_status == ResourcePreviewState.LOADING_ENGINE) {
        return _loadingWidget();
      } else if (_status == ResourcePreviewState.UNSUPPORT_FILE) {
        return _unSupportFile();
      } else if (_status == ResourcePreviewState.ENGINE_LOAD_SUCCESS) {
        if (Platform.isAndroid) {
          return _createAndroidView();
        } else {
          return _createIosView();
        }
      } else if (_status == ResourcePreviewState.ENGINE_LOAD_FAIL) {
        return _enginLoadFail();
      } else if (_status == ResourcePreviewState.FILE_NOT_FOUND) {
        return _fileNotFoundFile();
      } else {
        return _loadingWidget();
      }
    } else {
      return Center(child: Text("不支持的平台"));
    }
  }

  Widget _unSupportFile() {
    return widget.unSupportFileWidget ??
        Center(
          child: Text("不支持打开${_fileType(filePath!)}类型的文件"),
        );
  }

  Widget _fileNotFoundFile() {
    return Center(
      child: Text("文件不存在"),
    );
  }

  Widget _enginLoadFail() {
    //最有可能是abi的问题
    //还有可能第一次下载成功,但是加载不成功
    return Center(
      child: Text("引擎加载失败,请退出重试"),
    );
  }

  Widget _loadingWidget() {
    return widget.loadingWidget ??
        Center(
          child: CupertinoActivityIndicator(),
        );
  }

  Widget _createAndroidView() {
    return AndroidView(viewType: "ResourcePreview", onPlatformViewCreated: _onPlatformViewCreated, creationParamsCodec: StandardMessageCodec(), gestureRecognizers: widget.gestureRecognizers);
  }

  _onPlatformViewCreated(int id) {
    ResourcePreview.instance.openFile(id, filePath!, (success) {
      if (!success) {
        _setStatus(ResourcePreviewState.UNSUPPORT_FILE);
      }
      widget.openSuccess?.call(success);
    });
  }

  Widget _createIosView() {
    return UiKitView(
      viewType: "ResourcePreview",
      onPlatformViewCreated: _onPlatformViewCreated,
      creationParamsCodec: StandardMessageCodec(),
    );
  }

  String _fileType(String filePath) {
    if (filePath.isEmpty) {
      return "";
    }
    int i = filePath.lastIndexOf('.');
    if (i <= -1) {
      return "";
    }
    return filePath.substring(i + 1);
  }
}
