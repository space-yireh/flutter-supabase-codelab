import 'package:flutter/material.dart';
import 'package:flutter_supabse_codelab/main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Avatar extends StatefulWidget {
  const Avatar({super.key, required this.imageUrl, required this.onUpload});

  final String? imageUrl;
  final Function(String) onUpload;

  @override
  State<Avatar> createState() => _AvatarState();
}

class _AvatarState extends State<Avatar> {
  bool _isLoading = false;

  Future<void> _upload() async {
    //  supabase - imagePicker
    final picker = ImagePicker();
    final imageFile = await picker.pickImage(
        source: ImageSource.gallery, maxHeight: 300, maxWidth: 300);
    if (imageFile == null) {
      return;
    }
    setState(() {
      _isLoading = true;
    });

    try {
      //  supabase - uploadBinary
      final bytes = await imageFile.readAsBytes();
      final fileExt = imageFile.path.split('.').last;
      final fileName = '${DateTime.now().toIso8601String()}.$fileExt';
      final filePath = fileName;

      await supabase.storage.from('avatars').uploadBinary(filePath, bytes,
          fileOptions: FileOptions(contentType: imageFile.mimeType));

      final imageUrlResponse = await supabase.storage
          .from('avatars')
          .createSignedUrl(filePath, 60 * 60 * 24 * 265);

      widget.onUpload(imageUrlResponse);
    } on StorageException catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(error.message),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Unexpected error: $e'),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (widget.imageUrl == null || widget.imageUrl!.isEmpty)
          Container(
            width: 150,
            height: 150,
            color: Colors.grey,
            child: const Center(
              child: Text('No image'),
            ),
          )
        else
          Image.network(
            widget.imageUrl!,
            width: 150,
            height: 150,
            fit: BoxFit.cover,
          ),
        ElevatedButton(
            onPressed: _isLoading ? null : _upload, child: const Text('Upload'))
      ],
    );
  }
}
