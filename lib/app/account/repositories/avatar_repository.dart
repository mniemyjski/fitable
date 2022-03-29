import 'dart:typed_data';

import 'package:appwrite/appwrite.dart' as aw;
import 'package:injectable/injectable.dart';
import 'package:universal_io/io.dart';

import '../../../constants/constants.dart';
import '../../../utilities/services/app_write.dart';

abstract class BaseAvatarRepository {
  Future update({required String id, required File file});
  Future<Uint8List> get(String id);
  Stream stream(String id);
  Future delete(String id);
}

@Singleton()
class AvatarRepository extends BaseAvatarRepository {
  final AppWrite _appWrite;
  AvatarRepository(this._appWrite) : super();

  @override
  Future update({required String id, required File file}) async {
    await _appWrite.storage.createFile(
      bucketId: '62417799c3451fd1fad4',
      fileId: id,
      file: aw.InputFile(path: file.path, filename: '$id.png'),
      read: ['role:member'],
    );
  }

  @override
  Future<Uint8List> get(String id) async {
    final result = await _appWrite.storage.getFileView(
      bucketId: '62417799c3451fd1fad4',
      fileId: id,
    );

    return result;
  }

  @override
  Stream stream(String id) {
    return _appWrite.realtime
        .subscribe(['buckets.${Storages.avatars()}.files.$id'])
        .stream
        .cast()
        .map((event) {
          return null;
        });
  }

  @override
  Future delete(String id) async {
    await _appWrite.storage.deleteFile(
      bucketId: '62417799c3451fd1fad4',
      fileId: id,
    );
  }
}
