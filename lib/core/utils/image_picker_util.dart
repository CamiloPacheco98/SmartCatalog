import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:go_router/go_router.dart';

class ImagePickerUtil {
  final ImagePicker _picker = ImagePicker();

  /// Show a modal to select camera or gallery
  Future<String?> showImageSourceDialog(BuildContext context) async {
    return showModalBottomSheet<String>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Tomar foto'),
                onTap: () async {
                  final image = await _pickFromCamera();
                  if (context.mounted) context.pop(image);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Elegir de la galería'),
                onTap: () async {
                  final image = await _pickFromGallery();
                  if (context.mounted) context.pop(image);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  /// Select an image from the camera
  Future<String?> _pickFromCamera() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) return pickedFile.path;
    return '';
  }

  /// Select an image from the gallery
  Future<String?> _pickFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) return pickedFile.path;
    return '';
  }
}
