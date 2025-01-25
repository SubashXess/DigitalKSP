import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;
import 'package:image/image.dart' as img;
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:file_picker/file_picker.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class Utilities {
  static Future<File> downloadAndCompressImage(String imageUrl) async {
    try {
      final response = await http.get(Uri.parse(imageUrl));

      if (response.statusCode == 200) {
        img.Image? image =
            img.decodeImage(Uint8List.fromList(response.bodyBytes));
        if (image == null) {
          throw Exception("Failed to decode image");
        }

        final compressedImage = img.encodeJpg(image, quality: 80);

        final tempDir = await getTemporaryDirectory();
        final tempPath = tempDir.path;
        final filePath = '$tempPath/temp_compressed_image.jpg';
        final compressedFile = File(filePath)
          ..writeAsBytesSync(compressedImage);

        return compressedFile;
      } else {
        throw Exception('Failed to load image');
      }
    } catch (e) {
      throw 'Error downloading and compressing image: $e';
    }
  }

  static void shareIt(
    BuildContext context, {
    required String url,
    required String subject,
    String? text,
  }) {
    final content = (text?.isNotEmpty ?? false) ? '$text\n$url' : url;
    final box = context.findRenderObject() as RenderBox?;

    if (box != null) {
      Share.share(
        content,
        subject: subject,
        sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size,
      );
    } else {
      debugPrint('RenderBox is null, unable to determine share position.');
      Share.share(content, subject: subject);
    }
  }

  static Future<Map<String, dynamic>?> pickFile(
      {List<String>? allowedExtensions,
      FileType type = FileType.any,
      int? minFileSize = 1024,
      int? maxFileSize = 8 * 1024 * 1024}) async {
    try {
      FilePickerResult? result = await FilePicker.platform
          .pickFiles(type: type, allowedExtensions: allowedExtensions);

      if (result != null) {
        String? filePath = result.files.single.path;
        if (filePath == null) throw Exception("File path is null!");

        File file = File(filePath);
        String originalFileName = path.basename(file.path);
        String fileExtension =
            path.extension(file.path).replaceFirst('.', '').toLowerCase();
        String uniqueFileName =
            "${DateTime.now().millisecondsSinceEpoch}_$originalFileName";

        int fileSizeInBytes = await file.length();

        if ((minFileSize != null && fileSizeInBytes < minFileSize) ||
            (maxFileSize != null && fileSizeInBytes > maxFileSize)) {
          return null;
        }

        String fileSizeString = formatFileSize(fileSizeInBytes);

        return {
          'originalFileName': originalFileName,
          'uniqueFileName': uniqueFileName,
          'fileSize': fileSizeString,
          'filePath': filePath,
          'fileExtension': fileExtension,
        };
      } else {
        // print("File selection canceled.");
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  static String formatFileSize(int bytes) {
    const int kb = 1024;
    const int mb = kb * 1024;
    if (bytes >= mb) {
      return "${(bytes / mb).toStringAsFixed(2)} MB";
    } else if (bytes >= kb) {
      return "${(bytes / kb).toStringAsFixed(2)} KB";
    } else {
      return "$bytes Bytes";
    }
  }

  static Future<void> urlLauncher({required String url}) async {
    if (!url.contains(':')) {
      url = 'https://$url';
    }

    final Uri uri = Uri.parse(url);

    if (await canLaunchUrl(uri)) {
      switch (uri.scheme) {
        case 'https':
        case 'http':
          await launchUrl(uri, mode: LaunchMode.externalApplication);
          break;
        case 'mailto':
          await launchUrl(uri, mode: LaunchMode.externalApplication);
          break;
        case 'tel':
          // Ensure the `tel` scheme is used correctly
          final telUri = Uri(scheme: 'tel', path: uri.path);
          await launchUrl(telUri, mode: LaunchMode.externalApplication);
          break;
        case 'sms':
          await launchUrl(uri, mode: LaunchMode.externalApplication);
          break;
        default:
          throw 'Unsupported URL scheme: ${uri.scheme}';
      }
    } else {
      throw 'Could not launch $url';
    }
  }
}
