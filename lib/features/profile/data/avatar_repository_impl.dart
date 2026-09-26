import 'dart:io';

import '../../../shared/models/user.dart';
import '../domain/avatar_repository.dart';
import 'avatar_api.dart';

class AvatarRepositoryImpl implements AvatarRepository {
  AvatarRepositoryImpl(this._api);
  final AvatarApi _api;

  @override
  Future<User> uploadAvatar(File file) async {
    final json = await _api.uploadAvatar(file);
    return User.fromJson(json);
  }

  @override
  Future<User> deleteAvatar() async {
    final json = await _api.deleteAvatar();
    return User.fromJson(json);
  }

  @override
  Future<User> updateFrame(bool equipped) async {
    final json = await _api.updateFrame(equipped);
    return User.fromJson(json);
  }
}