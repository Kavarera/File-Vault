import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class FileContainer extends StatelessWidget {
  final String? filename;
  const FileContainer({super.key, this.filename});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 1, vertical: 1),
      child: Column(
        children: [
          Icon(
            Icons.file_present_rounded,
            size: 100,
          ),
          Text(
            filename ?? "Unknown File",
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ],
      ),
    );
  }
}
