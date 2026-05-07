import 'package:abupi/l10n/locale_provider.dart';
import 'package:abupi/models/journal_post.dart';
import 'package:abupi/services/wordpress_api.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:http/http.dart' as http;

class FormJournalScreen extends StatefulWidget {
  const FormJournalScreen({super.key});

  @override
  _FormJournalScreenState createState() => _FormJournalScreenState();
}

class _FormJournalScreenState extends State<FormJournalScreen> {
  bool _isSubmitted = false;
  bool _isLoading = false;
  String _fullName = '';
  String _email = '';
  String _phoneNumber = '';
  String _companyName = '';
  String _companyAddress = '';
  String _abstract = '';
  bool _tncChecked = false;
  final List<PlatformFile> _pickedAttachments = [];

  Future<void> _pickAttachments() async {
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.any,
      withData: kIsWeb,
    );
    if (result == null || result.files.isEmpty) return;
    setState(() {
      _pickedAttachments.addAll(result.files);
    });
  }

  void _removeAttachment(int index) {
    setState(() {
      _pickedAttachments.removeAt(index);
    });
  }

  Future<List<http.MultipartFile>> _attachmentMultipartFiles() async {
    const fieldName = 'file';
    final parts = <http.MultipartFile>[];
    for (final f in _pickedAttachments) {
      if (f.path != null && f.path!.isNotEmpty) {
        parts.add(await http.MultipartFile.fromPath(fieldName, f.path!, filename: f.name));
      } else if (f.bytes != null) {
        parts.add(http.MultipartFile.fromBytes(fieldName, f.bytes!, filename: f.name));
      }
    }
    return parts;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    void showSuccessModal() {
      showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        builder: (context) {
          final l10n = AppLocalizations.of(context);

          return Container(
            margin: const EdgeInsets.only(
                top: 16, left: 16, right: 16, bottom: 52),
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
                        l10n?.registrationSuccess ?? 'Success',
                        style: const TextStyle(
                            color: Colors.black, fontSize: 16),
                      ),
                      const SizedBox(height: 4),
                      Container(
                        width: double.infinity,
                        alignment: Alignment.bottomRight,
                        child: ElevatedButton(
                          style: const ButtonStyle(
                            backgroundColor: WidgetStatePropertyAll<Color>(
                                Color(0xFF2e2f7f)),
                          ),
                          onPressed: () => Navigator.pop(context),
                          child: const Text('OK',
                              style: TextStyle(color: Colors.white)),
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

    Future<void> submit() async {
      if (_isLoading) return;

      setState(() {
        _isLoading = true;
        _isSubmitted = true;
      });

      if (
      _companyName.isEmpty || _fullName.isEmpty || _phoneNumber.isEmpty ||
          _email.isEmpty || _companyAddress.isEmpty || _tncChecked == false ||
          _pickedAttachments.isEmpty
      ) {
        setState(() {
          _isLoading = false;
        });
        return;
      }

      try {
        final attachments = await _attachmentMultipartFiles();
        JournalPost journalPost = JournalPost(
          name: _fullName,
          email: _email,
          phone: _phoneNumber,
          companyName: _companyName,
          companyAddress: _companyAddress,
          abstract: _abstract,
        );
        final response = await WordPressApi.sendJournal(
          journalPost,
          attachments: attachments,
        );

        if (response.statusCode == 200) {
          showSuccessModal();
          setState(() {
            _isLoading = false;
            _isSubmitted = false;
            _pickedAttachments.clear();
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
                hintText: l10n?.formJournalNamePlaceholder ?? 'Masukkan nama lengkap',
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
                  _fullName = value;
                });
              },
            ),
            if (_fullName.isEmpty && _isSubmitted) ...[
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
            const SizedBox(height: 24),

            Text(
              l10n?.phoneNumber ?? 'Nomor Telepon',
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
                hintText: l10n?.formJournalPhoneNumberPlaceholder ?? '+6281234567890',
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
                  _phoneNumber = value;
                });
              },
            ),
            if (_phoneNumber.isEmpty && _isSubmitted) ...[
              Text(
                l10n?.requiredFill ?? 'Wajib diisi',
                style: const TextStyle(color: Colors.red),
              ),
            ],
            const SizedBox(height: 24),

            Text(
              l10n?.formJournalCompanyNameTitle ?? 'Nama Perusahaan',
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
                hintText: l10n?.formJournalCompanyNamePlaceholder ?? 'Masukkan nama perusahaan',
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
              l10n?.formJournalCompanyAddressTitle ?? 'Alamat Perusahaan',
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
                hintText: l10n?.formJournalCompanyAddressPlaceholder ?? 'Masukkan alamat perusahaan',
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
              l10n?.formJournalAbstractTitle ?? 'Abstrak',
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
                hintText: l10n?.formJournalCompanyAddressPlaceholder ?? 'Tuliskan ringkasan jurnal Anda',
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
                  _abstract = value;
                });
              },
            ),
            if (_abstract.isEmpty && _isSubmitted) ...[
              Text(
                l10n?.requiredFill ?? 'Wajib diisi',
                style: const TextStyle(color: Colors.red),
              ),
            ],
            const SizedBox(height: 24),

            Text(
              l10n?.formJournalFileTitle ?? 'File Jurnal',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 8),
            OutlinedButton.icon(
              onPressed: _isLoading ? null : _pickAttachments,
              icon: const Icon(Icons.attach_file, color: Color(0xFF2e2f7f)),
              label: Text(
                (l10n?.locale.languageCode ?? 'id') == 'id' ? 'Tambah lampiran' : 'Add attachment',
                style: const TextStyle(color: Color(0xFF2e2f7f)),
              ),
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Color(0xFF2e2f7f)),
                minimumSize: const Size(double.infinity, 44),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            if (_pickedAttachments.isNotEmpty) ...[
              const SizedBox(height: 12),
              ...List.generate(_pickedAttachments.length, (i) {
                final file = _pickedAttachments[i];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Material(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(12),
                    child: ListTile(
                      dense: true,
                      title: Text(
                        file.name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(color: Colors.black, fontSize: 14),
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.close, color: Colors.red),
                        onPressed: _isLoading ? null : () => _removeAttachment(i),
                      ),
                    ),
                  ),
                );
              }),
            ],
            if (_pickedAttachments.isEmpty && _isSubmitted) ...[
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CheckboxListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(
                      l10n?.formJournalTNCChecklist ?? '',
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
                backgroundColor: _tncChecked && !_isLoading ?
                const WidgetStatePropertyAll(Color(0xFF632f9c)) :
                const WidgetStatePropertyAll(Colors.grey),
                minimumSize: const WidgetStatePropertyAll<Size>(
                    Size(double.infinity, 42)
                ),
              ),
              onPressed: () => _tncChecked && !_isLoading ? submit() : {},
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