import 'dart:convert';
import 'dart:io';
import 'package:abupi/arguments/pdf_args.dart';
import 'package:abupi/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

import 'package:abupi/l10n/locale_provider.dart';
import 'package:abupi/models/newsletter.dart';
import 'package:abupi/services/wordpress_api.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsletterScreen extends StatefulWidget {
  const NewsletterScreen({super.key});

  @override
  _NewsletterScreen createState() => _NewsletterScreen();
}

class _NewsletterScreen extends State<NewsletterScreen> {
  bool _isLoading = false;
  bool _isDownloading = false;
  List<Newsletter> _newsletter = [];
  Newsletter? _selectedNewsletter;
  final ScrollController _scrollController = ScrollController();
  bool _canScrollLeft = false;
  bool _canScrollRight = true;

  @override
  void initState() {
    super.initState();
    _loadData();
    _scrollController.addListener(_updateScrollButtons);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_updateScrollButtons);
    _scrollController.dispose();
    super.dispose();
  }

  void _updateScrollButtons() {
    if (!_scrollController.hasClients) return;

    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;

    final canLeft = currentScroll > 0;
    final canRight = currentScroll < maxScroll - 1; // small threshold to handle floating point

    if (mounted && (_canScrollLeft != canLeft || _canScrollRight != canRight)) {
      setState(() {
        _canScrollLeft = canLeft;
        _canScrollRight = canRight;
      });
    }
  }

  Future<void> _loadData() async {
    try {
      setState(() {
        _isLoading = true;
      });
      final response = await WordPressApi.getNewsletter();

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);
        if (jsonList.isNotEmpty) {
          try {
            var newsletter = jsonList.map((item) {
              final acf = item['acf'];
              return Newsletter(
                title: acf['title'],
                date: acf['date'],
                image: acf['image'],
                fileURL: acf['newsletter_file'],
              );
            }).toList();

            List<Newsletter> _temp = [
              Newsletter(
                title: 'Testing Buleting 1',
                date: '2026-03-18 00:00:00',
                fileURL: 'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/02/PM-5-TAHUN-2022-Konsesi-Melaului-Pelelangan.pdf',
                image: 'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/03/IMG_4870-scaled-1.jpg',
              ),
              Newsletter(
                title: 'Testing Buleting 2',
                date: '2026-03-18 00:00:00',
                fileURL: 'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/02/PM_52_Tahun_2021_JDIH_TERSUS_TUKS.pdf',
                image: 'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/03/IMG_4893-scaled-1.jpg',
              ),
              Newsletter(
                title: 'Testing Buleting 3',
                date: '2026-03-18 00:00:00',
                fileURL: 'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/02/PM-48-TAHUN-2021-Konsesi-dan-Kerjasama-Bentuk-lainnya.pdf',
                image: 'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/03/HUT-PIC-5.jpg',
              ),
              Newsletter(
                title: 'Testing Buleting 4',
                date: '2026-03-18 00:00:00',
                fileURL: 'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/02/PP_64_Tahun_2015-Tentang-Perubahan-PP-61-Tahun-2009-Ttg-Kepelabuhanan.pdf',
                image: 'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/03/HUT-PIC-4.jpg',
              ),
            ];

            setState(() {
              _newsletter = newsletter + _temp;
              _selectedNewsletter = newsletter[0];
              _isLoading = false;
            });
          } catch (e) {
            debugPrint('error newsletter list $e');
            setState(() {
              _isLoading = false;
            });
          }
        } else {
          setState(() {
            _isLoading = false;
          });
        }
      }
    } catch (e) {
      debugPrint('$e');
    }
  }

  void _scrollLeft() {
    _scrollController.animateTo(
      _scrollController.offset - 300,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _scrollRight() {
    _scrollController.animateTo(
      _scrollController.offset + 300,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
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

  Future<String> getUniqueFilePath(String basePath) async {
    File file = File(basePath);
    if (!await file.exists()) {
      return basePath;
    }

    // If file exists, [name].pdf becomes [name]](1).pdf
    int counter = 1;
    String directory = file.parent.path;
    String name = file.uri.pathSegments.last.split('.').first;
    String extension = file.uri.pathSegments.last.split('.').last;

    while (await file.exists()) {
      file = File('$directory/$name($counter).$extension');
      counter++;
    }

    return file.path;
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
    });

    try {
      final dio = Dio();

      // Get the download directory
      Directory? directory;
      if (Platform.isAndroid) {
        directory = await getExternalStorageDirectory();
        // Try to save in Downloads folder
        const downloadsPath = '/storage/emulated/0/Download';
        if (await Directory(downloadsPath).exists()) {
          directory = Directory(downloadsPath);
        }
      } else {
        directory = await getApplicationDocumentsDirectory();
      }

      if (directory == null) {
        throw Exception('Could not access storage directory');
      }

      String url = _selectedNewsletter?.fileURL ?? '';

      // Generate filename from URL or use provided fileName
      final fileName = url.split('/').last.split('?').first;
      final sanitizedFileName = fileName.endsWith('.pdf') ? fileName : '$fileName.pdf';
      final filePath = await getUniqueFilePath('${directory.path}/$sanitizedFileName');

      await dio.download(
        url,
        filePath,
        onReceiveProgress: (received, total) {},
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
        });
      }
    }
  }

  Future<void> launchWhatsapp() async {
    final uri = Uri.parse('https://wa.me/?text=NewsLetter%0A${_selectedNewsletter?.fileURL}');
    debugPrint('https://wa.me/?text=NewsLetter%0A${_selectedNewsletter?.fileURL}');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      debugPrint('else');
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF2e2f7f),
        title: Text(
          l10n?.newsletter ?? 'Buletin',
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: Column(
              children: [
                if (_isLoading) ...[
                  SizedBox(
                    height: constraints.maxHeight,
                    child: const Center(
                      child: CircularProgressIndicator(color: Color(0xFF2e2f7f)),
                    ),
                  ),
                ]
                else if (!_isLoading && _newsletter.isEmpty) ...[
                  SizedBox(
                    height: constraints.maxHeight,
                    child: Center(
                      child: Text(
                        l10n?.emptyData ?? 'Tidak ada data',
                        style: const TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                ]
            else
              Container(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        if (_selectedNewsletter != null) {
                          Navigator.pushNamed(
                            context,
                            AbupiApp.pdfRoute,
                            arguments: PDFScreenArguments(
                              url: _selectedNewsletter!.fileURL,
                            ),
                          );
                        }
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20.0),
                        child: Image.network(
                          _selectedNewsletter?.image ?? '',
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: 360,
                          errorBuilder: (context, error, stackTrace) =>
                              Container(
                                color: Colors.grey.shade500,
                                child: const Center(
                                  child: Icon(
                                    Icons.event_rounded,
                                    size: 32,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Container(
                              color: Colors.grey.shade500,
                              child: const Center(
                                child: CircularProgressIndicator(strokeWidth: 2),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      l10n?.newsletterInformation ?? '',
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Column(
                      children: [
                        ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: _isDownloading ?
                              const WidgetStatePropertyAll<Color>(Colors.grey) :
                              const WidgetStatePropertyAll<Color>(Colors.blue),
                          ),
                          onPressed: () => _downloadPdf(),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.download,
                                color: Colors.white,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                l10n?.downloadNewsletter ?? '',
                                style: const TextStyle(color: Colors.white, fontSize: 10),
                              ),
                            ],
                          ),
                        ),
                        ElevatedButton(
                          style: const ButtonStyle(
                            backgroundColor: WidgetStatePropertyAll<Color>(Color(0xFF25D366)),
                          ),
                          onPressed: () => launchWhatsapp(),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                CupertinoIcons.chat_bubble_fill,
                                color: Colors.white,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                l10n?.shareToWhatsapp ?? '',
                                style: const TextStyle(color: Colors.white, fontSize: 10),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                height: 250,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    // Card list
                    ListView.separated(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      controller: _scrollController,
                      scrollDirection: Axis.horizontal,
                      separatorBuilder: (context, index) => const SizedBox(width: 4),
                      itemCount: _newsletter.length,
                      itemBuilder: (context, index) {
                        final newsletter = _newsletter[index];
                        return _buildNewsletterCard(context, newsletter);
                      },
                    ),
                    // Left navigation button
                    if (_canScrollLeft)
                      Positioned(
                        left: -8,
                        bottom: 100,
                        child: IconButton(
                          onPressed: _scrollLeft,
                          icon: const Icon(
                            Icons.chevron_left_rounded,
                            color: Colors.black,
                          ),
                          style: IconButton.styleFrom(
                            backgroundColor: Colors.grey.shade100,
                          ),
                          iconSize: 24,
                          constraints: const BoxConstraints(
                            minWidth: 36,
                            minHeight: 36,
                          ),
                          padding: EdgeInsets.zero,
                        ),
                      ),
                    // Right navigation button
                    if (_canScrollRight)
                      Positioned(
                        right: 0,
                        bottom: 100,
                        child: IconButton(
                          onPressed: _scrollRight,
                          icon: const Icon(
                            Icons.chevron_right_rounded,
                            color: Colors.black,
                          ),
                          style: IconButton.styleFrom(
                            backgroundColor: Colors.grey.shade100,
                          ),
                          iconSize: 24,
                          constraints: const BoxConstraints(
                            minWidth: 36,
                            minHeight: 36,
                          ),
                          padding: EdgeInsets.zero,
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildNewsletterCard(BuildContext context, Newsletter newsletter) {
    DateTime dateTime = DateTime.parse(newsletter.date);
    double screenWidth = MediaQuery.of(context).size.width;
    double maxWidth = (screenWidth / 4) - 10;

    return Container(
      padding: const EdgeInsets.all(8),
      width: 120,
      decoration: BoxDecoration(
        color: _selectedNewsletter?.title == newsletter.title ?
          Colors.blue.shade100 :
          const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: _selectedNewsletter?.title == newsletter.title ? Colors.blue : Colors.grey.shade300,
          width: _selectedNewsletter?.title == newsletter.title ? 2 : 1,
        ),
      ),
      child: InkWell(
        onTap: () {
          setState(() {
            _selectedNewsletter = newsletter;
          });
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                newsletter.image,
                fit: BoxFit.cover,
                width: double.infinity,
                height: 120,
                errorBuilder: (context, error, stackTrace) =>
                    Container(
                      color: Colors.grey.shade500,
                      child: const Center(
                        child: Icon(
                          Icons.event_rounded,
                          size: 32,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Container(
                    color: Colors.grey.shade500,
                    child: const Center(
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 8),
            Text(
              newsletter.title,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              DateFormat('d MMMM yyyy').format(dateTime),
              style: const TextStyle(color: Colors.grey, fontSize: 12),
            ),
          ],
        ),
      )
    );
  }
}