class FileData {
  final String fileName;
  final List<int> content;
  FileData(this.fileName, this.content);

  factory FileData.fromJson(Map<String, dynamic> json) {
    return FileData(
      json['fileName'] as String,
      (json['content'] as List).cast<int>(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'format': fileName,
      'content': content,
    };
  }
}
