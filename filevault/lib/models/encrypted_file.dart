import 'package:filevault/models/file.dart';

class EncryptedModel {
  var session = List<int>.empty(growable: true);
  var contents = List<FileData>.empty(growable: true);

  EncryptedModel(this.session, this.contents);

  void addContent(FileData f) {
    contents.add(f);
  }

  factory EncryptedModel.fromJson(Map<String, dynamic> json) {
    return EncryptedModel(
      (json['session'] as List).cast<int>(),
      (json['contents'] as List)
          .map((contentJson) => FileData.fromJson(contentJson))
          .toList(),
    );
  }

  // Method untuk mengubah instance menjadi JSON
  Map<String, dynamic> toJson() {
    return {
      'session': session,
      'content': contents.map((fileData) => fileData.toJson()).toList(),
    };
  }
}
