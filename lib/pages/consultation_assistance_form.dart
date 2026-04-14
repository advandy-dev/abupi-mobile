import 'package:abupi/l10n/locale_provider.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ConsultationAndAssistanceFormScreen extends StatefulWidget {
  const ConsultationAndAssistanceFormScreen({super.key});

  @override
  _ConsultationAndAssistanceFormScreen createState() => _ConsultationAndAssistanceFormScreen();
}

class _ConsultationAndAssistanceFormScreen extends State<ConsultationAndAssistanceFormScreen> {
  bool _isSubmitted = false;
  String _name = '';
  String _position = '';
  String _companyName = '';
  String _companyAddress = '';
  String _email = '';
  String _contactNumber = '';
  String _idNumberABUPI = '';
  String _subject = '';
  String _description = '';
  bool _tncChecked = false;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    void submitInput() {
      setState(() {
        _isSubmitted = true;
      });
      if (
        _companyName.isEmpty || _name.isEmpty || _position.isEmpty ||
        _email.isEmpty || _contactNumber.isEmpty || _idNumberABUPI.isEmpty ||
        _subject.isEmpty || _description.isEmpty || _tncChecked == false
      ) {
        debugPrint('empty');
        return;
      }

      final nameLabel = l10n?.name ?? 'Nama';
      final positionLabel = l10n?.position ?? 'Jabatan';
      final companyNameLabel = l10n?.formRegistrationCompanyNameTitle ?? 'Nama Perusahaan';
      final companyAddressLabel = l10n?.formRegistrationCompanyAddressTitle ?? 'Alamat Perusahaan';
      final emailLabel = l10n?.email ?? 'Email';
      final contactNumberLabel = l10n?.contactNumber ?? 'Email';
      final idMemberABUPILabel = l10n?.idMemberABUPI ?? 'Nomor Keanggotaan ABUPI';
      final subjectLabel = l10n?.subject ?? 'Subject';
      final problemDescriptionLabel = l10n?.problemDescription ?? 'Deskripsi Permasalahan';

      final body = [
        l10n?.templatePrefixEmailConsultationAndAssistance ?? '',
        '$nameLabel: $_name',
        '$positionLabel: $_position',
        '$companyNameLabel: $_companyName',
        '$companyAddressLabel: $_companyAddress',
        '$emailLabel: $_email',
        '$contactNumberLabel: $_contactNumber',
        '$idMemberABUPILabel: $_idNumberABUPI',
        '$subjectLabel: $_contactNumber',
        '$problemDescriptionLabel: $_description',
        l10n?.templatePostfixEmailRegistration ?? '',
      ].join('\n');
      final mailtoUri = Uri(
        scheme: 'mailto',
        path: 'sekretariat@abupi.or.id',
        query: 'subject=${Uri.encodeComponent('ABUPI Consultation & Assistance')}&body=${Uri.encodeComponent(body)}',
      );
      debugPrint('mailto $mailtoUri');
      launchUrl(mailtoUri);
      Navigator.pop(context);
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
              l10n?.name ?? 'Nama',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              style: const TextStyle(color: Colors.black),
              cursorColor: const Color(0xFF2e2f7f),
              cursorErrorColor: const Color(0xFF2e2f7f),
              decoration: InputDecoration(
                hintText: l10n?.name ?? 'Nama',
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
                  _name = value;
                });
              },
            ),
            if (_name.isEmpty && _isSubmitted) ...[
              Text(
                l10n?.requiredFill ?? 'Wajib diisi',
                style: const TextStyle(color: Colors.red),
              ),
            ],
            const SizedBox(height: 24),

            Text(
              l10n?.position ?? 'Jabatan',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              style: const TextStyle(color: Colors.black),
              cursorColor: const Color(0xFF2e2f7f),
              cursorErrorColor: const Color(0xFF2e2f7f),
              decoration: InputDecoration(
                hintText: l10n?.position ?? 'Jabatan',
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
                  _position = value;
                });
              },
            ),
            if (_position.isEmpty && _isSubmitted) ...[
              Text(
                l10n?.requiredFill ?? 'Wajib diisi',
                style: const TextStyle(color: Colors.red),
              ),
            ],
            const SizedBox(height: 24),

            Text(
              l10n?.formRegistrationCompanyNameTitle ?? 'Nama Perusahaan',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              style: const TextStyle(color: Colors.black),
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
              l10n?.formRegistrationCompanyAddressTitle ?? 'Alamat Perusahaan',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              style: const TextStyle(color: Colors.black),
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
              l10n?.email ?? 'Email',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              style: const TextStyle(color: Colors.black),
              cursorColor: const Color(0xFF2e2f7f),
              cursorErrorColor: const Color(0xFF2e2f7f),
              decoration: InputDecoration(
                hintText: l10n?.email ?? 'Email',
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
            const SizedBox(height: 24),

            Text(
              l10n?.contactNumber ?? 'Nomor Kontak',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              style: const TextStyle(color: Colors.black),
              cursorColor: const Color(0xFF2e2f7f),
              cursorErrorColor: const Color(0xFF2e2f7f),
              decoration: InputDecoration(
                hintText: l10n?.contactNumber ?? 'Nomor Kontak',
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
                  _contactNumber = value;
                });
              },
            ),
            if (_contactNumber.isEmpty && _isSubmitted) ...[
              Text(
                l10n?.requiredFill ?? 'Wajib diisi',
                style: const TextStyle(color: Colors.red),
              ),
            ],
            const SizedBox(height: 24),

            Text(
              l10n?.idMemberABUPI ?? 'Nomor Keanggotaan ABUPI',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              style: const TextStyle(color: Colors.black),
              cursorColor: const Color(0xFF2e2f7f),
              cursorErrorColor: const Color(0xFF2e2f7f),
              decoration: InputDecoration(
                hintText: l10n?.idMemberABUPI ?? 'Nomor Keanggotaan ABUPI',
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
                  _idNumberABUPI = value;
                });
              },
            ),
            if (_idNumberABUPI.isEmpty && _isSubmitted) ...[
              Text(
                l10n?.requiredFill ?? 'Wajib diisi',
                style: const TextStyle(color: Colors.red),
              ),
            ],
            const SizedBox(height: 24),

            Text(
              l10n?.subject ?? 'Subject',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              style: const TextStyle(color: Colors.black),
              cursorColor: const Color(0xFF2e2f7f),
              cursorErrorColor: const Color(0xFF2e2f7f),
              decoration: InputDecoration(
                hintText: l10n?.subject ?? 'Subject',
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
                  _subject = value;
                });
              },
            ),
            if (_subject.isEmpty && _isSubmitted) ...[
              Text(
                l10n?.requiredFill ?? 'Wajib diisi',
                style: const TextStyle(color: Colors.red),
              ),
            ],
            const SizedBox(height: 24),

            Text(
              l10n?.problemDescription ?? 'Deskripsi Permasalahan',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              style: const TextStyle(color: Colors.black),
              keyboardType: TextInputType.multiline,
              maxLines: 4,
              cursorColor: const Color(0xFF2e2f7f),
              cursorErrorColor: const Color(0xFF2e2f7f),
              decoration: InputDecoration(
                hintText: l10n?.problemDescription ?? 'Deskripsi Permasalahan',
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
                  _description = value;
                });
              },
            ),
            if (_description.isEmpty && _isSubmitted) ...[
              Text(
                l10n?.requiredFill ?? 'Wajib diisi',
                style: const TextStyle(color: Colors.red),
              ),
            ],
            const SizedBox(height: 24),

            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: Colors.grey.shade300,
                  width: 1,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    l10n?.consultationAssistanceTNCDescription ?? '',
                    style: const TextStyle(color: Colors.black),
                  ),
                  const SizedBox(height: 4),
                  CheckboxListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(
                      l10n?.agree ?? 'Saya setuju',
                      style: const TextStyle(color: Colors.black),
                    ),
                    checkColor: Colors.white,
                    activeColor: const Color(0xFF2e2f7f),
                    value: _tncChecked,
                    onChanged: (newValue) {
                      setState(() {
                        _tncChecked = newValue ?? false;
                      });
                    },
                    controlAffinity: ListTileControlAffinity.leading,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: _tncChecked ?
                  const WidgetStatePropertyAll(Color(0xFF632f9c)) :
                  const WidgetStatePropertyAll(Colors.grey),
                minimumSize: const WidgetStatePropertyAll<Size>(
                    Size(double.infinity, 42)
                ),
              ),
              onPressed: () => submitInput(),
              child: const Text(
                'Submit',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

}