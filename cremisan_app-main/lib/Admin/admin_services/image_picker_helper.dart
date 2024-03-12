import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../provider/locale_provider.dart';
import 'package:provider/provider.dart';
import "package:flutter_gen/gen_l10n/app_localizations.dart";

import '../../utils/app_colors.dart';

class ImagePickerFormField extends StatefulWidget {
  final String labelText;
  final String? initialImage;
  final void Function(String?)? onSaved;

  ImagePickerFormField(
      {Key? key,
      required this.labelText,
      required this.onSaved,
      required this.initialImage})
      : super(key: key);

  @override
  _ImagePickerFormFieldState createState() => _ImagePickerFormFieldState();
}

class _ImagePickerFormFieldState extends State<ImagePickerFormField> {
  String? _imagePath;

  void _pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _imagePath = pickedImage.path;
      });
      widget.onSaved?.call(_imagePath);
    }
  }

  Locale? initialValue;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LocaleProvider>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (_imagePath != null) ...[
          Image.file(
            File(_imagePath!),
            height: 200,
            width: double.infinity,
            fit: BoxFit.contain,
          ),
          const SizedBox(height: 8.0),
        ] else ...[
          widget.initialImage!.isEmpty
              ? Image.asset('assets/empty.png')
              : Image.network(
                  widget.initialImage!,
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.contain,
                ),
        ],
        Row(
          children: [
            Expanded(
              child: ElevatedButton.icon(
                onPressed: _pickImage,
                icon: const Icon(Icons.image),
                label: Text(widget.labelText),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                      if (states.contains(MaterialState.disabled)) {
                        return AppColors
                            .disabledColor; // Color for disabled state
                      }
                      return AppColors.uniformColor;
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8.0),
            if (_imagePath != null) ...[
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.uniformColor,
                ),
                onPressed: () {
                  setState(() {
                    _imagePath = null;
                  });
                  widget.onSaved?.call(null);
                },
                icon: const Icon(Icons.clear),
                label:  Text(
                  AppLocalizations.of(context)?.clear ??
                      "value becomes null",
                ),
              ),
            ],
          ],
        ),
      ],
    );
  }
}
