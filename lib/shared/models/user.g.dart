// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_User _$UserFromJson(Map<String, dynamic> json) => _User(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      email: json['email'] as String,
      role: json['role'] as String,
      isEmailVerified: json['is_email_verified'] as bool,
      avatarUrl: json['avatar_url'] as String?,
      frameUnlocked: json['frame_unlocked'] as bool? ?? false,
      frameUnlockedAt: json['frame_unlocked_at'] == null
          ? null
          : DateTime.parse(json['frame_unlocked_at'] as String),
      frameEquipped: json['frame_equipped'] as bool? ?? false,
    );

Map<String, dynamic> _$UserToJson(_User instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'role': instance.role,
      'is_email_verified': instance.isEmailVerified,
      'avatar_url': instance.avatarUrl,
      'frame_unlocked': instance.frameUnlocked,
      'frame_unlocked_at': instance.frameUnlockedAt?.toIso8601String(),
      'frame_equipped': instance.frameEquipped,
    };
