import 'dart:io';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class PDFScreen extends StatefulWidget {
  final String url;
  final String? fileName;

  const PDFScreen({
    super.key,
    required this.url,
    this.fileName,
  });

  @override
  _PDFScreen createState() => _PDFScreen();
}

class _PDFScreen extends State<PDFScreen> {
  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();
  bool _isDownloading = false;
  double _downloadProgress = 0;

  @override
  void initState() {
    super.initState();
  }

  Future<bool> _requestStoragePermission() async {
    if (Platform.isAndroid) {
      final status = await Permission.storage.request();
      if (status.isGranted) {
        return true;
      }
      // For Android 11+ (API 30+), use manage external storage or app-specific directory
      final manageStatus = await Permission.manageExternalStorage.request();
      return manageStatus.isGranted;
    }
    return true; // iOS doesn't need explicit permission for app documents
  }

  Future<void> _downloadPdf() async {
    if (_isDownloading) return;

    // Request permission
    final hasPermission = await _requestStoragePermission();
    if (!hasPermission && Platform.isAndroid) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Storage permission denied'),
            backgroundColor: Colors.red,
          ),
        );
      }
      return;
    }

    setState(() {
      _isDownloading = true;
      _downloadProgress = 0;
    });

    try {
      final dio = Dio();

      // Get the download directory
      Directory? directory;
      if (Platform.isAndroid) {
        directory = await getExternalStorageDirectory();
        // Try to save in Downloads folder
        final downloadsPath = '/storage/emulated/0/Download';
        if (await Directory(downloadsPath).exists()) {
          directory = Directory(downloadsPath);
        }
      } else {
        directory = await getApplicationDocumentsDirectory();
      }

      if (directory == null) {
        throw Exception('Could not access storage directory');
      }

      // Generate filename from URL or use provided fileName
      final fileName = widget.fileName ?? 
          widget.url.split('/').last.split('?').first;
      final sanitizedFileName = fileName.endsWith('.pdf') ? fileName : '$fileName.pdf';
      final filePath = '${directory.path}/$sanitizedFileName';

      await dio.download(
        widget.url,
        filePath,
        onReceiveProgress: (received, total) {
          if (total != -1) {
            setState(() {
              _downloadProgress = received / total;
            });
          }
        },
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('PDF saved to: $filePath'),
            backgroundColor: Colors.green,
            duration: const Duration(seconds: 3),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Download failed: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isDownloading = false;
          _downloadProgress = 0;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PDF Viewer'),
        actions: <Widget>[
          if (_isDownloading)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Center(
                child: SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    value: _downloadProgress > 0 ? _downloadProgress : null,
                    strokeWidth: 2,
                    color: Colors.black,
                  ),
                ),
              ),
            )
          else
            IconButton(
              icon: const Icon(
                Icons.download,
                color: Colors.black,
                semanticLabel: 'Download',
              ),
              onPressed: _downloadPdf,
            ),
          IconButton(
            icon: const Icon(
              Icons.bookmark,
              color: Colors.black,
              semanticLabel: 'Bookmark',
            ),
            onPressed: () {
              _pdfViewerKey.currentState?.openBookmarkView();
            },
          ),
        ],
      ),
      body: SfPdfViewer.network(
        widget.url,
        key: _pdfViewerKey,
      ),
    );
  }
}