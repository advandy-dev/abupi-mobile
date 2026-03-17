import 'package:abupi/l10n/locale_provider.dart';
import 'package:abupi/models/gallery.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class GalleryScreen extends StatefulWidget {
  const GalleryScreen({super.key});

  @override
  State<GalleryScreen> createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  final List<Gallery> _galleries = [
    Gallery(
      title: 'Meeting ABUPI dengan Asdep Pengembangan Logistik Nasional Kementerian coordinator Bidang Perekonomian Republik Indonesia.',
      imageURL: [
        'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/03/1-9.jpg',
        'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/03/2-5.jpg',
        'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/03/3-5.jpg',
        'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/03/4-3.jpg',
        'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/03/5-2.jpg'
      ],
    ),
    Gallery(
      title: 'Penyerahan SK sebagai Ketua perwakilan ABUPI, Tanjung Redeb Kalimantan Timur kepada bapak Selamat Riyadi, PT Gurimbang Artha Nusa.',
      imageURL: [
        'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/03/1-8.jpg',
        'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/03/5-1.jpg',
        'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/03/4-2.jpg',
        'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/03/6.jpg',
        'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/03/3-4.jpg',
        'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/03/2-4.jpg',
      ],
    ),
    Gallery(
      title: 'Donor Darah Bersama ABUPI.',
      imageURL: [
        'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/03/DSC00455-scaled-1.jpg',
        'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/03/WhatsApp-Image-2024-11-14-at-13.21.19_8223d4bb.jpg',
        'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/03/WhatsApp-Image-2024-11-14-at-13.21.33_9505b901.jpg',
        'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/03/DSC00410-scaled-1.jpg',
        'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/03/DSC00433-scaled-1.jpg',
        'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/03/DSC00440-scaled-1.jpg',
        'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/03/DSC00445-scaled-1.jpg',
      ]
    ),
    Gallery(
      title: 'Rapat dengan Direktur Jenderal Perhubungan Laut.',
      imageURL: [
        'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/03/1-2.jpg',
        'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/03/WhatsApp-Image-2024-11-14-at-13.09.34_2bbfde19.jpg',
        'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/03/WhatsApp-Image-2024-11-14-at-13.09.33_1049a8c4.jpg',
      ],
    ),
    Gallery(
      title: 'ABUPI Menghadiri Acara HUT Ke- 5 PT Sei Mangkei Dry Port. Medan, 6 November 2024.',
      imageURL: [
        'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/03/4.jpg',
        'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/03/3-1.jpg',
        'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/03/1-1.jpg',
      ],
    ),
    Gallery(
      title: 'ABUPI Menghadiri Acara HUT Ke- 36 & Rakernas APBMI. Kamis, 31 Oktober 2024.',
      imageURL: [
        'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/03/3.jpg',
        'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/03/2.jpg',
        'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/03/1.jpg',
      ],
    ),
    Gallery(
      title: 'ABUPI ROADSHOW 2024, Makassar, 24 Oktober 2024.',
      imageURL: [
        'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/03/EPC02318-scaled-1.jpg',
        'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/03/EPC02299-scaled-1.jpg',
        'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/03/EPC02317-scaled-1.jpg',
        'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/03/EPC02216-scaled-1.jpg',
        'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/03/EPC02220-scaled-1.jpg',
        'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/03/EPC02254-scaled-1.jpg',
        'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/03/EPC02270-scaled-1.jpg',
        'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/03/EPC02293-scaled-1.jpg',
        'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/03/EPC02321-scaled-1.jpg',
        'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/03/EPC02371-scaled-1.jpg',
        'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/03/EPC02392-scaled-1.jpg',
        'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/03/EPC02398-scaled-1.jpg',
        'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/03/EPC02402-scaled-1.jpg',
        'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/03/EPC02408-scaled-1.jpg',
        'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/03/EPC02424-scaled-1.jpg',
        'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/03/EPC02455-scaled-1.jpg',
        'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/03/EPC02460-scaled-1.jpg',
        'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/03/EPC02493-scaled-1.jpg',
        'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/03/EPC02508-scaled-1.jpg',
      ],
    ),
    Gallery(
      title: 'ABUPI ROADSHOW 2024, Samarinda, 17 Oktober 2024.',
      imageURL: [
        'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/03/PTGC-97-1-scaled-1.jpg',
        'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/03/PTGC-108-scaled-1.jpg',
        'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/03/PTGC-87-scaled-1.jpg',
        'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/03/PTGC-64-scaled-1.jpg',
        'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/03/PTGC-203-scaled-1.jpg',
        'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/03/PTGC-204-scaled-1.jpg',
        'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/03/PTGC-186-scaled-1.jpg',
        'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/03/PTGC-193-scaled-1.jpg',
        'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/03/PTGC-196-scaled-1.jpg',
        'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/03/PTGC-198-scaled-1.jpg',
        'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/03/PTGC-201-scaled-1.jpg',
        'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/03/PTGC-212-scaled-1.jpg',
      ],
    ),
    Gallery(
      title: 'ABUPI ROADSHOW 2024, Surabaya, 10 Oktober 2024.',
      imageURL: [
        'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/03/IMG_3891-scaled-1.jpg',
        'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/03/IMG_3879-scaled-1.jpg',
        'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/03/IMG_4045-scaled-1.jpg',
        'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/03/Screenshot-2024-10-11-132300.jpg',
        'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/03/PTGC-3-scaled-1.jpg',
        'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/03/PTGC-1-1-scaled-1.jpg',
        'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/03/PTGC-3-1-scaled-1.jpg',
        'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/03/PTGC-24-scaled-1.jpg',
        'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/03/PTGC-26-scaled-1.jpg',
        'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/03/PTGC-34-scaled-1.jpg',
        'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/03/PTGC-6-scaled-1.jpg',
        'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/03/PTGC-12-scaled-1.jpg',
        'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/03/PTGC-15-scaled-1.jpg',
        'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/03/PTGC-21-scaled-1.jpg',
      ],
    ),
    Gallery(
      title: 'ABUPI Apresiasi, tanggal 6 Juni 2024.',
      imageURL: [
        'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/03/DSC06212-scaled-1.jpg',
        'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/03/DSC06202-scaled-1.jpg',
        'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/03/IMG_5371-scaled-1.jpg',
      ],
    ),
    Gallery(
      title: 'Rapat Kerja Nasional ABUPI-IX, tanggal 6 Juni 2024.',
      imageURL: [
        'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/03/IMG_5345-scaled-1.jpg',
        'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/03/IMG_5356-scaled-1.jpg',
        'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/03/IMG_5358-scaled-1.jpg',
        'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/03/IMG_5279-scaled-1.jpg',
        'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/03/IMG_5291-scaled-1.jpg',
        'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/03/IMG_5310-scaled-1.jpg',
      ],
    ),
    Gallery(
      title: 'Pengangkatan dan Pelantikan Ketua Koordinator Wilayah ABUPI, tanggal 6 Juni 2024.',
      imageURL: [
        'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/03/DSC06188-scaled-1.jpg',
        'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/03/DSC06157-scaled-1.jpg',
        'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/03/DSC06164-scaled-1.jpg',
        'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/03/DSC06168-scaled-1.jpg',
      ],
    ),
    Gallery(
      title: 'Acara HUT ABUPI Ke – 9, tanggal 6 Juni 2024.',
      imageURL: [
        'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/03/IMG_5130-scaled-1.jpg',
        'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/03/DSC06100-scaled-1.jpg',
        'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/03/DSC06112-scaled-1.jpg',
        'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/03/IMG_5059-scaled-1.jpg',
        'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/03/IMG_5109-scaled-1.jpg',
      ],
    ),
    Gallery(
      title: 'Seminar Nasional ABUPI 2024, tanggal 6 Juni 2024.',
      imageURL: [
        'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/03/IMG_4893-scaled-1.jpg',
        'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/03/IMG_4870-scaled-1.jpg',
        'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/03/PTGC-1-scaled-1.jpg',
        'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/03/IMG_5022-scaled-1.jpg',
        'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/03/IMG_4946-scaled-1.jpg',
        'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/03/IMG_4997-scaled-1.jpg',
      ],
    ),
    Gallery(
      title: 'Rapat Pleno Internal ABUPI Tanggal 20 Februari 2023.',
      imageURL: [
        'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/03/IMG-20230221-WA0007.jpg'
      ],
    ),
    Gallery(
      title: 'Sambutan dari Ketua Umum ABUPI Bapak Aulia Febrial Fatwa pada acara HUT ABUPI Ke 5, tanggal 21 Februari 2020.',
      imageURL: [
        'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/03/HUT-PIC-1.jpg'
      ],
    ),
    Gallery(
      title: 'Sambutan dari Dewan Pembina ABUPI Ibu Carmelita Hartoto pada acara HUT ABUPI Ke 5, tanggal 21 Februari 2020.',
      imageURL: [
        'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/03/HUT-PIC-2.jpg'
      ],
    ),
    Gallery(
      title: 'Sambutan dari Strategic Partner ABUPI, PT. China Harbour Indonesia, Presiden Director,PT. CHI, Mr. Liu Qihu pada acara HUT ABUPI Ke 5, tanggal 21 Februari 2020.',
      imageURL: [
        'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/03/HUT-PIC-3.jpg'
      ],
    ),
    Gallery(
      title: 'Sambutan dari Kepala BKPM Bapak Bahlil Lahadalia pada acara HUT ABUPI Ke 5, tanggal 21 Februari 2020.',
      imageURL: [
        'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/03/HUT-PIC-4.jpg'
      ],
    ),
    Gallery(
      title: 'Sambutan dari Menteri Perhubungan Bapak Budi Karya Sumadi pada acara HUT ABUPI Ke 5, tanggal 21 Februari 2020.',
      imageURL: [
        'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/03/HUT-PIC-5.jpg'
      ],
    ),
    Gallery(
      title: 'Acara HUT ABUPI Ke 5, tanggal 21 Februari 2020 di hotel JW. Mariot, Jakarta.',
      imageURL: [
        'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/03/HUT-PIC-6.jpg',
        'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/03/HUT-PIC-11.jpg',
        'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/03/HUT-PIC-12.jpg',
        'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/03/HUT-PIC-13.jpg',
        'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/03/HUT-PIC-15.jpg',
        'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/03/HUT-PIC-8-B.jpg',
      ],
    ),
    Gallery(
      title: 'Musyawarah Nasional (MUNAS) ke-1 ABUPI pada tanggal 21/02/2020 di Hotel JW. Mariot, Jakarta.',
      imageURL: [
        'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/03/MUNAS-PIC-2.jpg',
        'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/03/MUNAS-PIC-3.jpg',
        'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/03/MUNAS-PIC-1.jpg',
        'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/03/MUNAS-PIC-4.jpg',
        'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/03/MUNAS-PIC-5B.jpg',
        'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/03/MUNAS-PIC-6.jpg',
        'http://floralwhite-mallard-731111.hostingersite.com/wp-content/uploads/2026/03/MUNAS-PIC-7.jpg',
      ],
    ),
  ];

  void _showImageViewer(BuildContext context, Gallery gallery, int initialIndex) {
    Navigator.of(context).push(
      PageRouteBuilder(
        opaque: false,
        barrierColor: Colors.black87,
        pageBuilder: (context, animation, secondaryAnimation) {
          return _ImageViewerOverlay(
            gallery: gallery,
            initialIndex: initialIndex,
          );
        },
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF2e2f7f),
        title: Text(
          l10n?.gallery ?? 'Galeri',
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
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _galleries.length,
        itemBuilder: (context, index) {
          final gallery = _galleries[index];
          return _buildGallerySection(context, gallery);
        },
      ),
    );
  }

  Widget _buildGallerySection(BuildContext context, Gallery gallery) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Text(
            gallery.title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color.fromRGBO(50, 50, 50, 1),
            ),
          ),
        ),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            childAspectRatio: 1,
          ),
          itemCount: gallery.imageURL.length,
          itemBuilder: (context, imageIndex) {
            return GestureDetector(
              onTap: () => _showImageViewer(context, gallery, imageIndex),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: CachedNetworkImage(
                  imageUrl: gallery.imageURL[imageIndex],
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(
                    color: Colors.grey[300],
                    child: const Center(
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  ),
                  errorWidget: (context, url, error) => Container(
                    color: Colors.grey[300],
                    child: const Icon(Icons.error, color: Colors.red),
                  ),
                ),
              ),
            );
          },
        ),
        const SizedBox(height: 16),
        const Divider(),
      ],
    );
  }
}

class _ImageViewerOverlay extends StatefulWidget {
  final Gallery gallery;
  final int initialIndex;

  const _ImageViewerOverlay({
    required this.gallery,
    required this.initialIndex,
  });

  @override
  State<_ImageViewerOverlay> createState() => _ImageViewerOverlayState();
}

class _ImageViewerOverlayState extends State<_ImageViewerOverlay> {
  late PageController _pageController;
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _pageController = PageController(initialPage: widget.initialIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _goToPrevious() {
    if (_currentIndex > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _goToNext() {
    if (_currentIndex < widget.gallery.imageURL.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.9),
      body: SafeArea(
        child: Stack(
          children: [
            // Image PageView
            GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: PageView.builder(
                controller: _pageController,
                itemCount: widget.gallery.imageURL.length,
                onPageChanged: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {}, // Prevent closing when tapping the image
                    child: InteractiveViewer(
                      minScale: 0.5,
                      maxScale: 3.0,
                      child: Center(
                        child: CachedNetworkImage(
                          imageUrl: widget.gallery.imageURL[index],
                          fit: BoxFit.contain,
                          placeholder: (context, url) => const Center(
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          ),
                          errorWidget: (context, url, error) => const Icon(
                            Icons.error,
                            color: Colors.red,
                            size: 48,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            // Title at top
            Positioned(
              top: 60,
              left: 16,
              right: 16,
              child: Text(
                widget.gallery.title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
                softWrap: true,
              ),
            ),

            // Close button
            Positioned(
              top: 8,
              right: 8,
              child: IconButton(
                icon: const Icon(
                  Icons.close,
                  color: Colors.white,
                  size: 30,
                ),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),

            // Left navigation arrow
            if (_currentIndex > 0)
              Positioned(
                left: 8,
                top: 0,
                bottom: 0,
                child: Center(
                  child: IconButton(
                    icon: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.black54,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: const Icon(
                        Icons.chevron_left,
                        color: Colors.white,
                        size: 32,
                      ),
                    ),
                    onPressed: _goToPrevious,
                  ),
                ),
              ),

            // Right navigation arrow
            if (_currentIndex < widget.gallery.imageURL.length - 1)
              Positioned(
                right: 8,
                top: 0,
                bottom: 0,
                child: Center(
                  child: IconButton(
                    icon: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.black54,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: const Icon(
                        Icons.chevron_right,
                        color: Colors.white,
                        size: 32,
                      ),
                    ),
                    onPressed: _goToNext,
                  ),
                ),
              ),

            // Page indicator
            Positioned(
              bottom: 24,
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    '${_currentIndex + 1} / ${widget.gallery.imageURL.length}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
