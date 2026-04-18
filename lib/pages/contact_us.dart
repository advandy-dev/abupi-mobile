import 'dart:convert';
import 'dart:math';

import 'package:abupi/models/contact_us.dart';
import 'package:abupi/services/wordpress_api.dart';
import 'package:abupi/util/launch_url.dart';
import 'package:abupi/l10n/locale_provider.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({super.key});

  @override
  _ContactUsScreenState createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  String _firstName = '';
  String _lastName = '';
  String _message = '';
  String _email = '';
  bool _isLoading = false;
  bool _isSubmitted = false;

  Future<void> _launchPhone(String phoneNumber) async {
    final Uri phoneUri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri);
    }
  }

  Future<void> _launchMaps(String address) async {
    const mapsURL = 'https://www.google.com/maps/search/?api=1&query=';
    final Uri mapsUri = Uri.parse(
      '$mapsURL${Uri.encodeComponent(address)}'
    );
    if (await canLaunchUrl(mapsUri)) {
      await launchUrl(mapsUri, mode: LaunchMode.externalApplication);
    }
  }

  Widget _buildCard({
    required IconData icon,
    required String title,
    required String description,
    String? buttonText,
    VoidCallback? onPressed,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(icon, color: Colors.blue),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text(description, style: const TextStyle(color: Colors.black)),
                ],
              ),
            ),
            const SizedBox(width: 8),
            if (buttonText != null) ...[
              ElevatedButton(
                style: const ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll<Color>(Color(0xFF2e2f7f)),
                ),
                onPressed: onPressed,
                child: Text(buttonText, style: const TextStyle(color: Colors.white)),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Future<void> _submit() async {
    if (_isLoading) return;

    setState(() {
      _isLoading = true;
      _isSubmitted = true;
    });

    if (
      _firstName.isEmpty || _lastName.isEmpty || _message.isEmpty ||
      _email.isEmpty
    ) {
      debugPrint('empty');
      setState(() {
        _isLoading = false;
      });
      return;
    }

    try {
      final l10n = AppLocalizations.of(context);
      ContactUs contactUs = ContactUs(
        email: _email,
        firstName: _firstName,
        lastName: _lastName,
        lang: l10n?.locale.languageCode ?? 'id',
        message: _message,
      );
      final response = await WordPressApi.sendContactUs(contactUs);

      if (response.statusCode == 200) {
        showSuccessModal();
        setState(() {
          _isLoading = false;
          _isSubmitted = false;
        });
      } else {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Request fail', style: TextStyle(color: Colors.white),),
              backgroundColor: Colors.red,
            ),
          );
        }
        setState(() {
          _isLoading = false;
          _isSubmitted = false;
        });
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Request fail', style: TextStyle(color: Colors.white),),
            backgroundColor: Colors.red,
          ),
        );
      }
      debugPrint('$e');
      setState(() {
        _isLoading = false;
        _isSubmitted = false;
      });
    }
  }

  void showSuccessModal() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        final l10n = AppLocalizations.of(context);

        return Container(
          margin: const EdgeInsets.only(top: 16, left: 16, right: 16, bottom: 52),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.15),
                      blurRadius: 20,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Text(
                      l10n?.contactUsSuccess ?? 'Success',
                      style: const TextStyle(color: Colors.black, fontSize: 16),
                    ),
                    const SizedBox(height: 4),
                    Container(
                      width: double.infinity,
                      alignment: Alignment.bottomRight,
                      child: ElevatedButton(
                        style: const ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll<Color>(Color(0xFF2e2f7f)),
                        ),
                        onPressed: () => Navigator.pop(context),
                        child: const Text('OK', style: TextStyle(color: Colors.white)),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      backgroundColor: const Color(0xFFE3E3E3),
      appBar: AppBar(
        backgroundColor: const Color(0xFF2e2f7f),
        title: Text(
          l10n?.contactUs ?? 'Hubungi Kami',
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset('assets/images/office.png'),
            const SizedBox(height: 12),
            _buildCard(
              icon: Icons.location_on,
              title: l10n?.officeAddressValue ?? 'Alamat Kantor Kami',
              description: 'Jl. Wijaya I No. 381i, Kebayoran Baru, Jakarta Selatan 12170',
              buttonText: l10n?.openMap ?? 'Buka Map',
              onPressed: () => _launchMaps('ASOSIASI BADAN USAHA PELABUHAN INDONESIA (ABUPI)'),
            ),
            const SizedBox(height: 16),
            _buildCard(
              icon: Icons.phone,
              title: l10n?.phoneNumber ?? 'Nomor Telepon',
              description: '(021) 7206902',
              buttonText: l10n?.contact ?? 'Hubungi',
              onPressed: () => _launchPhone('0217206902'),
            ),
            const SizedBox(height: 16),
            _buildCard(
              icon: Icons.phone,
              title: 'Hotline',
              description: '0813 8823 4109',
              buttonText: l10n?.contact ?? 'Hubungi',
              onPressed: () => launchUrlString('https://wa.me/message/XRU4Y4HHCOK2K1'),
            ),
            const SizedBox(height: 16),
            _buildCard(
              icon: Icons.email,
              title: l10n?.emailAddress ?? 'Alamat Email',
              description: 'sekretariat@abupi.or.id',
            ),
            const SizedBox(height: 24),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n?.formContactTitle ?? 'Form Kontak',
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    l10n?.formContactFirstName ?? 'Nama Depan',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    style: const TextStyle(color: Colors.black),
                    keyboardType: TextInputType.multiline,
                    cursorColor: const Color(0xFF2e2f7f),
                    cursorErrorColor: const Color(0xFF2e2f7f),
                    decoration: InputDecoration(
                      hintText: l10n?.formContactFirstName ?? 'Nama Depan',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Color(0xFF2e2f7f)), // Focused color
                        borderRadius: BorderRadius.circular(12),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        _firstName = value;
                      });
                    },
                  ),
                  if (_firstName.isEmpty && _isSubmitted) ...[
                    Text(
                      l10n?.requiredFill ?? 'Wajib diisi',
                      style: const TextStyle(color: Colors.red),
                    ),
                  ],
                  const SizedBox(height: 12),
                  Text(
                    l10n?.formContactLastName ?? 'Nama Belakang',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    style: const TextStyle(color: Colors.black),
                    keyboardType: TextInputType.multiline,
                    cursorColor: const Color(0xFF2e2f7f),
                    cursorErrorColor: const Color(0xFF2e2f7f),
                    decoration: InputDecoration(
                      hintText: l10n?.formContactLastName ?? 'Nama Belakang',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Color(0xFF2e2f7f)), // Focused color
                        borderRadius: BorderRadius.circular(12),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        _lastName = value;
                      });
                    },
                  ),
                  if (_lastName.isEmpty && _isSubmitted) ...[
                    Text(
                      l10n?.requiredFill ?? 'Wajib diisi',
                      style: const TextStyle(color: Colors.red),
                    ),
                  ],
                  const SizedBox(height: 12),
                  Text(
                    l10n?.formContactEmail ?? 'Email',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    style: const TextStyle(color: Colors.black),
                    keyboardType: TextInputType.multiline,
                    cursorColor: const Color(0xFF2e2f7f),
                    cursorErrorColor: const Color(0xFF2e2f7f),
                    decoration: InputDecoration(
                      hintText: 'email@example.com',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Color(0xFF2e2f7f)), // Focused color
                        borderRadius: BorderRadius.circular(12),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        _email = value;
                      });
                    },
                  ),
                  if (_email.isEmpty && _isSubmitted) ...[
                    Text(
                      l10n?.requiredFill ?? 'Wajib diisi',
                      style: const TextStyle(color: Colors.red),
                    ),
                  ],
                  const SizedBox(height: 12),
                  Text(
                    l10n?.formContactMessage ?? 'Pesan',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    style: const TextStyle(color: Colors.black),
                    maxLines: 4,
                    keyboardType: TextInputType.multiline,
                    cursorColor: const Color(0xFF2e2f7f),
                    cursorErrorColor: const Color(0xFF2e2f7f),
                    decoration: InputDecoration(
                      hintText: l10n?.formContactMessage ?? 'Pesan',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Color(0xFF2e2f7f)), // Focused color
                        borderRadius: BorderRadius.circular(12),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        _message = value;
                      });
                    },
                  ),
                  if (_message.isEmpty && _isSubmitted) ...[
                    Text(
                      l10n?.requiredFill ?? 'Wajib diisi',
                      style: const TextStyle(color: Colors.red),
                    ),
                  ],
                  const SizedBox(height: 12),
                  Container(
                    width: double.infinity,
                    alignment: Alignment.bottomRight,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: _isLoading ?
                          const WidgetStatePropertyAll<Color>(Colors.grey) :
                          const WidgetStatePropertyAll<Color>(Color(0xFF2e2f7f)),
                      ),
                      onPressed: () {
                        if (_isLoading) return;
                        _submit();
                      },
                      child: Text(l10n?.send ?? 'Kirim', style: const TextStyle(color: Colors.white)),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      )
    );
  }
}
