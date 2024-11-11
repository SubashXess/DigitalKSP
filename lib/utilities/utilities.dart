import 'package:share_plus/share_plus.dart';

class Utilities {
  static shareIt({required String url, required String? text}) {
    final content = text != null || text!.isNotEmpty ? '$text\n$url' : url;

    Share.share(content);
  }
}
