import 'package:flutter/material.dart';
import 'package:abupi/component/home/section/infographic/infographic_card.dart';
import 'package:abupi/models/infographic.dart';

class InfographicSection extends StatefulWidget {
  const InfographicSection({super.key});

  @override
  State<InfographicSection> createState() => _InfographicSectionState();
}

class _InfographicSectionState extends State<InfographicSection> {
  List<Infographic> _infographicList = [];
  bool _isLoading = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      // TODO: Replace with actual API call
      await Future.delayed(const Duration(milliseconds: 500));
      setState(() {
        _infographicList = [
          Infographic(
            icon: 'https://img.icons8.com/ios-filled/100/000000/anchor.png',
            count: 1194,
            text: 'Pelabuhan',
          ),
          Infographic(
            icon: 'https://img.icons8.com/ios-filled/100/000000/cargo-ship.png',
            count: 495,
            text: 'TERSUS',
          ),
          Infographic(
            icon: 'https://img.icons8.com/ios-filled/100/000000/warehouse.png',
            count: 716,
            text: 'TUKS',
          ),
        ];
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'Gagal memuat data';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Infografis',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                if (_isLoading)
                  const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
              ],
            ),
            const SizedBox(height: 20),
            _buildContent(),
          ],
        ),
      ),
    );
  }

  Widget _buildContent() {
    if (_isLoading && _infographicList.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (_errorMessage != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              Icon(
                Icons.error_outline,
                size: 48,
                color: Colors.red.shade300,
              ),
              const SizedBox(height: 12),
              Text(
                _errorMessage!,
                style: TextStyle(color: Colors.red.shade700),
              ),
              const SizedBox(height: 12),
              TextButton.icon(
                onPressed: _loadData,
                icon: const Icon(Icons.refresh),
                label: const Text('Coba Lagi'),
              ),
            ],
          ),
        ),
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: _infographicList
          .map((info) => Expanded(
                child: InfographicCard(
                  icon: info.icon,
                  count: info.count,
                  text: info.text,
                ),
              ))
          .toList(),
    );
  }
}
