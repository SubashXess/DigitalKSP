import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:file_picker/file_picker.dart';
import 'package:share_plus/share_plus.dart';

class Utilities {
  static shareIt({required String url, required String? text}) {
    final content = text != null || text!.isNotEmpty ? '$text\n$url' : url;

    Share.share(content);
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
          print("File size is not within the allowed range.");
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
      print("Error during file upload: $e");
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
}
