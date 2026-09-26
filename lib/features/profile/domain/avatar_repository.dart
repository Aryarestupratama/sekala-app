import 'dart:io';

import '../../../shared/models/user.dart';

abstract class AvatarRepository {
  Future<User> uploadAvatar(File file);
  Future<User> deleteAvatar();
  Future<User> updateFrame(bool equipped);
}