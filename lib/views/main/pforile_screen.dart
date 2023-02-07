import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:like_sns/models/main_model.dart';
import 'package:like_sns/models/profile_model.dart';
import 'package:like_sns/views/user_image.dart';

class ProfileScreen extends ConsumerWidget{
  const ProfileScreen({
    Key? key,
    required this.mainModel
  }) : super(key: key);
  final MainModel mainModel;

  @override
  Widget build(BuildContext context, WidgetRef ref){
    final ProfileModel profileModel = ref.watch(profileProvider);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        profileModel.croppedFile == null
        ? Container(
          alignment: Alignment.center,
          child: UserImage(length: 100, userImageURL: mainModel.firestoreUser.userImageURL,)
        )
        : ClipRRect(
          borderRadius: BorderRadius.circular(160.0),
          child: Image.file(profileModel.croppedFile!),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.green,
          ),
          child: Text(
            "画像アップロード",
          ),
          onPressed: () async => await profileModel.uploadUserImage(currentUserDoc: mainModel.currentUserDoc),
        )
      ],
    );
  }
}