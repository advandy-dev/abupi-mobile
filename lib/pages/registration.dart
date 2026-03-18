import 'package:abupi/l10n/locale_provider.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  _RegistrationScreen createState() => _RegistrationScreen();
}

class _RegistrationScreen extends State<RegistrationScreen> {
  bool _isSubmitted = false;
  String _companyName = '';
  String _picName = '';
  String _companyAddress = '';
  String _picPosition = '';
  String _picPhoneNumber = '';
  String _picEmail = '';
  String _typeOfBusiness = '';
  String _companyStatus = '';
  String _membershipType = '';

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    void submitInput() {
      setState(() {
        _isSubmitted = true;
      });
      if (
        _companyName.isEmpty || _picName.isEmpty || _companyAddress.isEmpty ||
        _picPosition.isEmpty || _picPosition.isEmpty || _picPhoneNumber.isEmpty ||
        _picEmail.isEmpty || _typeOfBusiness.isEmpty || _companyStatus.isEmpty
      ) {
        debugPrint('empty');
        return;
      }

      final companyNameLabel = l10n?.formRegistrationCompanyNameTitle ?? 'Nama Perusahaan';
      final picNameLabel = l10n?.formRegistrationPicNameTitle ?? 'Nama PIC';
      final companyAddressLabel = l10n?.formRegistrationCompanyAddressTitle ?? 'Alamat Perusahaan';
      final picPositionLabel = l10n?.formRegistrationPicPositionTitle ?? 'Jabatan PIC';
      final picPhoneNumberLabel = l10n?.formRegistrationPicPhoneNumberTitle ?? 'Nomor Telepon PIC';
      final picEmailLabel = l10n?.formRegistrationPicEmailTitle ?? 'Email PIC';
      final typeOfBusinessLabel = l10n?.formRegistrationTypeOfBusinessTitle ?? 'Jenis Izin Usaha';
      final companyStatusLabel = l10n?.formRegistrationStatusCompanyTitle ?? 'Status Perusahaan';
      final membershipTypeLabel = l10n?.formRegistrationMembershipTypeTitle ?? 'Jenis Keanggotaan';
      final body = [
        l10n?.templatePrefixEmailRegistration ?? '',
        '$companyNameLabel: $_companyName',
        '$picNameLabel: $_picName',
        '$companyAddressLabel: $_companyAddress',
        '$picPositionLabel: $_picPosition',
        '$picPhoneNumberLabel: $_picPhoneNumber',
        '$picEmailLabel: $_picEmail',
        '$typeOfBusinessLabel: $_typeOfBusiness',
        '$companyStatusLabel: $_companyStatus',
        '$membershipTypeLabel: $_membershipType',
        l10n?.templatePostfixEmailRegistration ?? '',
      ].join('\n');
      final mailtoUri = Uri(
        scheme: 'mailto',
        path: 'royadvandy@gmail.com',
        query: 'subject=${Uri.encodeComponent('ABUPI Member Registration')}&body=${Uri.encodeComponent(body)}',
      );
      debugPrint('mailto $mailtoUri');
      launchUrl(mailtoUri);
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF2e2f7f),
        title: const Text(
          'Join ABUPI',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n?.formRegistrationCompanyNameTitle ?? 'Nama Perusahaan',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              cursorColor: const Color(0xFF2e2f7f),
              cursorErrorColor: const Color(0xFF2e2f7f),
              decoration: InputDecoration(
                hintText: l10n?.formRegistrationCompanyNamePlaceholder ?? 'PT Contoh Indonesia',
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
                  _companyName = value;
                });
              },
            ),
            if (_companyName.isEmpty && _isSubmitted) ...[
              Text(
                l10n?.requiredFill ?? 'Wajib diisi',
                style: const TextStyle(color: Colors.red),
              ),
            ],
            const SizedBox(height: 24),

            Text(
              l10n?.formRegistrationPicNameTitle ?? 'Nama PIC',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              cursorColor: const Color(0xFF2e2f7f),
              cursorErrorColor: const Color(0xFF2e2f7f),
              decoration: InputDecoration(
                hintText: l10n?.formRegistrationPicNamePlaceholder ?? 'Nama lengkap PIC',
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
                  _picName = value;
                });
              },
            ),
            if (_picName.isEmpty && _isSubmitted) ...[
              Text(
                l10n?.requiredFill ?? 'Wajib diisi',
                style: const TextStyle(color: Colors.red),
              ),
            ],
            const SizedBox(height: 24),

            Text(
              l10n?.formRegistrationCompanyAddressTitle ?? 'Alamat Perusahaan',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              keyboardType: TextInputType.multiline,
              maxLines: 4,
              cursorColor: const Color(0xFF2e2f7f),
              cursorErrorColor: const Color(0xFF2e2f7f),
              decoration: InputDecoration(
                hintText: l10n?.formRegistrationCompanyAddressPlaceholder ?? 'Alamat lengkap perusahaan',
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
                  _companyAddress = value;
                });
              },
            ),
            if (_companyAddress.isEmpty && _isSubmitted) ...[
              Text(
                l10n?.requiredFill ?? 'Wajib diisi',
                style: const TextStyle(color: Colors.red),
              ),
            ],
            const SizedBox(height: 24),

            Text(
              l10n?.formRegistrationPicPositionTitle ?? 'Jabatan PIC',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              cursorColor: const Color(0xFF2e2f7f),
              cursorErrorColor: const Color(0xFF2e2f7f),
              decoration: InputDecoration(
                hintText: l10n?.formRegistrationPicPositionPlaceholder ?? 'Direktur operasional',
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
                  _picPosition = value;
                });
              },
            ),
            if (_picPosition.isEmpty && _isSubmitted) ...[
              Text(
                l10n?.requiredFill ?? 'Wajib diisi',
                style: const TextStyle(color: Colors.red),
              ),
            ],
            const SizedBox(height: 20),

            Text(
              l10n?.formRegistrationPicPhoneNumberTitle ?? 'Nomor Telepon PIC',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              cursorColor: const Color(0xFF2e2f7f),
              cursorErrorColor: const Color(0xFF2e2f7f),
              decoration: InputDecoration(
                hintText: l10n?.formRegistrationPicPhoneNumberPlaceholder ?? '+6281234567890',
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
                  _picPhoneNumber = value;
                });
              },
            ),
            if (_picPhoneNumber.isEmpty && _isSubmitted) ...[
              Text(
                l10n?.requiredFill ?? 'Wajib diisi',
                style: const TextStyle(color: Colors.red),
              ),
            ],
            const SizedBox(height: 24),

            Text(
              l10n?.formRegistrationPicEmailTitle ?? 'Email PIC',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              cursorColor: const Color(0xFF2e2f7f),
              cursorErrorColor: const Color(0xFF2e2f7f),
              decoration: InputDecoration(
                hintText: l10n?.formRegistrationPicEmailPlaceholder ?? 'name@company.com',
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
                  _picEmail = value;
                });
              },
            ),
            if (_picEmail.isEmpty && _isSubmitted) ...[
              Text(
                l10n?.requiredFill ?? 'Wajib diisi',
                style: const TextStyle(color: Colors.red),
              ),
            ],
            const SizedBox(height: 24),

            Text(
              l10n?.formRegistrationTypeOfBusinessTitle ?? 'Jenis Izin Usaha',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 4,
              runSpacing: 8,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Radio<String>(
                      value: 'BUP',
                      groupValue: _typeOfBusiness,
                      fillColor: const WidgetStatePropertyAll<Color>(Color(0xFF2e2f7f)),
                      activeColor: const Color(0xFF2e2f7f),
                      onChanged: (value) {
                        if (value != null) {
                          setState(() {
                            _typeOfBusiness = value;
                          });
                        }
                      },
                    ),
                    const Text('BUP', style: TextStyle(color: Colors.black)),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Radio<String>(
                      value: 'TUKS',
                      groupValue: _typeOfBusiness,
                      fillColor: const WidgetStatePropertyAll<Color>(Color(0xFF2e2f7f)),
                      activeColor: const Color(0xFF2e2f7f),
                      onChanged: (value) {
                        if (value != null) {
                          setState(() {
                            _typeOfBusiness = value;
                          });
                        }
                      },
                    ),
                    const Text('TUKS', style: TextStyle(color: Colors.black)),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Radio<String>(
                      value: 'Tersus',
                      groupValue: _typeOfBusiness,
                      fillColor: const WidgetStatePropertyAll<Color>(Color(0xFF2e2f7f)),
                      activeColor: const Color(0xFF2e2f7f),
                      onChanged: (value) {
                        if (value != null) {
                          setState(() {
                            _typeOfBusiness = value;
                          });
                        }
                      },
                    ),
                    const Text('Tersus', style: TextStyle(color: Colors.black)),
                  ],
                ),
              ],
            ),
            if (_typeOfBusiness.isEmpty && _isSubmitted) ...[
              Text(
                l10n?.requiredFill ?? 'Wajib diisi',
                style: const TextStyle(color: Colors.red),
              ),
            ],
            const SizedBox(height: 24),

            Text(
              l10n?.formRegistrationStatusCompanyTitle ?? 'Status Perusahaan',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 4,
              runSpacing: 8,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Radio<String>(
                      value: 'BUMN',
                      groupValue: _companyStatus,
                      fillColor: const WidgetStatePropertyAll<Color>(Color(0xFF2e2f7f)),
                      activeColor: const Color(0xFF2e2f7f),
                      onChanged: (value) {
                        if (value != null) {
                          setState(() {
                            _companyStatus = value;
                          });
                        }
                      },
                    ),
                    const Text('BUMN', style: TextStyle(color: Colors.black)),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Radio<String>(
                      value: 'BUMD',
                      groupValue: _companyStatus,
                      fillColor: const WidgetStatePropertyAll<Color>(Color(0xFF2e2f7f)),
                      activeColor: const Color(0xFF2e2f7f),
                      onChanged: (value) {
                        if (value != null) {
                          setState(() {
                            _companyStatus = value;
                          });
                        }
                      },
                    ),
                    const Text('BUMD', style: TextStyle(color: Colors.black)),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Radio<String>(
                      value: 'Private International',
                      groupValue: _companyStatus,
                      fillColor: const WidgetStatePropertyAll<Color>(Color(0xFF2e2f7f)),
                      activeColor: const Color(0xFF2e2f7f),
                      onChanged: (value) {
                        if (value != null) {
                          setState(() {
                            _companyStatus = value;
                          });
                        }
                      },
                    ),
                    const Text(
                      'Private International',
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Radio<String>(
                      value: 'Private Domestic',
                      groupValue: _companyStatus,
                      fillColor: const WidgetStatePropertyAll<Color>(Color(0xFF2e2f7f)),
                      activeColor: const Color(0xFF2e2f7f),
                      onChanged: (value) {
                        if (value != null) {
                          setState(() {
                            _companyStatus = value;
                          });
                        }
                      },
                    ),
                    const Text(
                      'Private Domestic',
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              ],
            ),
            if (_companyStatus.isEmpty && _isSubmitted) ...[
              Text(
                l10n?.requiredFill ?? 'Wajib diisi',
                style: const TextStyle(color: Colors.red),
              ),
            ],
            const SizedBox(height: 24),

            Text(
              l10n?.formRegistrationMembershipTypeTitle ?? 'Jenis Keanggotaan',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 4,
              runSpacing: 8,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Radio<String>(
                      value: 'BUP',
                      groupValue: _membershipType,
                      fillColor: const WidgetStatePropertyAll<Color>(Color(0xFF2e2f7f)),
                      activeColor: const Color(0xFF2e2f7f),
                      onChanged: (value) {
                        if (value != null) {
                          setState(() {
                            _membershipType = value;
                          });
                        }
                      },
                    ),
                    const Text('BUP', style: TextStyle(color: Colors.black)),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Radio<String>(
                      value: 'Tersus/TUKS',
                      groupValue: _membershipType,
                      fillColor: const WidgetStatePropertyAll<Color>(Color(0xFF2e2f7f)),
                      activeColor: const Color(0xFF2e2f7f),
                      onChanged: (value) {
                        if (value != null) {
                          setState(() {
                            _membershipType = value;
                          });
                        }
                      },
                    ),
                    const Text(
                      'Tersus/TUKS',
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              ],
            ),
            if (_membershipType.isEmpty && _isSubmitted) ...[
              Text(
                l10n?.requiredFill ?? 'Wajib diisi',
                style: const TextStyle(color: Colors.red),
              ),
            ],
            const SizedBox(height: 32),
            ElevatedButton(
              style: const ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(Color(0xFF632f9c)),
                minimumSize: WidgetStatePropertyAll<Size>(
                    Size(double.infinity, 42)
                ),
              ),
              onPressed: () => submitInput(),
              child: const Text(
                'Join ABUPI',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

}