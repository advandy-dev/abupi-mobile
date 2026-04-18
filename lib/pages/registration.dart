import 'package:abupi/l10n/locale_provider.dart';
import 'package:abupi/models/registration.dart';
import 'package:abupi/services/wordpress_api.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  _RegistrationScreen createState() => _RegistrationScreen();
}

class _RegistrationScreen extends State<RegistrationScreen> {
  bool _isSubmitted = false;
  bool _isLoading = false;
  String _companyName = '';
  String _picName = '';
  String _companyAddress = '';
  String _businessAddress = '';
  bool _isSameAddress = false;
  String _picPosition = '';
  String _picPhoneNumber = '';
  String _picEmail = '';
  String _typeOfBusiness = '';
  String _companyStatus = '';
  String _membershipType = '';

  TextEditingController _businessAddressController = TextEditingController();

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
                        l10n?.registrationSuccess ?? 'Success',
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

    Future<void> _submit() async {
      if (_isLoading) return;

      setState(() {
        _isLoading = true;
        _isSubmitted = true;
      });

      if (
        _companyName.isEmpty || _picName.isEmpty || _companyAddress.isEmpty ||
        _picPosition.isEmpty || _picPosition.isEmpty || _picPhoneNumber.isEmpty ||
        _picEmail.isEmpty || _typeOfBusiness.isEmpty || _companyStatus.isEmpty ||
        _businessAddress.isEmpty
      ) {
        debugPrint('empty');
        setState(() {
          _isLoading = false;
        });
        return;
      }

      try {
        Registration registration = Registration(
          companyName: _companyName,
          companyAddress: _companyAddress,
          businessLocationAddress: _businessAddress,
          businessPermitType: _typeOfBusiness,
          companyStatus: _companyStatus,
          picName: _picName,
          picPosition: _picPosition,
          picPhone: _picPhoneNumber,
          picEmail: _picEmail,
          membershipType: _membershipType,
        );
        final response = await WordPressApi.sendMemberRegistration(registration);

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
                if (_isSameAddress) {
                  _businessAddressController.text = value;
                }
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
              l10n?.formRegistrationBusinessAddressTitle ?? 'Alamat Lokasi Usaha',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              readOnly: _isSameAddress,
              style: const TextStyle(color: Colors.black),
              keyboardType: TextInputType.multiline,
              controller: _businessAddressController,
              maxLines: 4,
              cursorColor: const Color(0xFF2e2f7f),
              cursorErrorColor: const Color(0xFF2e2f7f),
              decoration: InputDecoration(
                hintText: l10n?.formRegistrationBusinessAddressPlaceholder ?? 'Alamat lengkap lokasi usaha ',
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
                if (!_isSameAddress) {
                setState(() {
                  _businessAddress = value;
                });
                }
              },
            ),
            if (_businessAddress.isEmpty && _isSubmitted) ...[
              Text(
                l10n?.requiredFill ?? 'Wajib diisi',
                style: const TextStyle(color: Colors.red),
              ),
            ],
            CheckboxListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(
                l10n?.registrationSameAddressLabel ?? 'Sama dengan alamat perusahaan',
                style: const TextStyle(color: Colors.black),
              ),
              checkColor: Colors.white,
              activeColor: const Color(0xFF2e2f7f),
              value: _isSameAddress,
              onChanged: (newValue) {
                String address = newValue == true ? _companyAddress : _businessAddress;
                _businessAddressController.text = _isSameAddress ? _companyAddress : address;
                setState(() {
                  _isSameAddress = newValue ?? false;
                  _businessAddress = address;
                });
              },
              controlAffinity: ListTileControlAffinity.leading,
            ),
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
              style: const TextStyle(color: Colors.black),
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
              l10n?.formRegistrationPicPositionTitle ?? 'Jabatan PIC',
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
              style: const TextStyle(color: Colors.black),
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
              style: const TextStyle(color: Colors.black),
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
              style: ButtonStyle(
                backgroundColor: _isLoading ?
                  const WidgetStatePropertyAll(Colors.grey) :
                  const WidgetStatePropertyAll(Color(0xFF632f9c)),
                minimumSize: const WidgetStatePropertyAll<Size>(
                    Size(double.infinity, 42)
                ),
              ),
              onPressed: () => _isLoading ? {} :_submit(),
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