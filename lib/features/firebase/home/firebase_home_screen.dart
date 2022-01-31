import 'package:firebase_storage/firebase_storage.dart';
import 'package:flat_and_fast/common/controls/animated/buttons/floating_menu_button.dart';
import 'package:flat_and_fast/common/controls/buttons/feature_button.dart';
import 'package:flat_and_fast/common/utils/styles/app_colors.dart';
import 'package:flat_and_fast/common/utils/styles/styles.dart';
import 'package:flat_and_fast/features/firebase/home/firebase_feature.dart';
import 'package:flat_and_fast/features/firebase/home/redux/firebase_home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:path/path.dart';

import '../../../common/redux/app/app_state.dart';

const homeTitle = 'Home';

class FirebaseHomeScreen extends StatelessWidget {
  const FirebaseHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, FirebaseHomeViewModel>(converter: (store) {
      return FirebaseHomeViewModel.fromStore(store);
    }, builder: (_, viewModel) {
      return Scaffold(
        appBar: AppBar(
            title: const Text(
          homeTitle,
          style: TextStyles.appBarTitle,
        )),
        backgroundColor: AppColors.white,
        floatingActionButton: FloatingMenuButton(
          firstButtonIcon: const Icon(Icons.cloud_upload, color: AppColors.white),
          firstButtonColor: AppColors.green,
          firstButtonAction: () => viewModel.changeSelectedFeature(FirebaseFeature.fileUpload),
          secondButtonIcon: const Icon(Icons.person, color: AppColors.white),
          secondButtonColor: AppColors.blue,
          secondButtonAction: () => viewModel.changeSelectedFeature(FirebaseFeature.pushNotifications),


        ),
        body: Container(
          padding: const EdgeInsets.all(32.0),
          child: Center(
            child: Builder(builder: (context) {
              if (viewModel.selectedFeature == FirebaseFeature.fileUpload) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FeatureButton(
                      action: () => viewModel.selectFile(),
                      title: 'Select file',
                      icon: const Icon(Icons.filter_outlined),
                    ),
                    Text(basename(viewModel.selectedFile?.path ?? 'File not selected')),
                    const SizedBox(height: 32.0),
                    FeatureButton(
                      action: () => viewModel.uploadFile(),
                      title: 'Upload file',
                      icon: const Icon(Icons.cloud_upload),
                    ),
                    viewModel.uploadTask != null ? buildUploadStatus(viewModel.uploadTask!) : Container()
                  ],
                );
              }

              return Container();
            }),
          ),
        ),
      );
    });
  }

  buildUploadStatus(UploadTask task) => StreamBuilder<TaskSnapshot>(
      stream: task.snapshotEvents,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var data = snapshot.data!;
          final progress = data.bytesTransferred / data.totalBytes;
          final percentage = (progress * 100).toStringAsFixed(2);
          return Text(
            'Progress: $percentage %',
            style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          );
        }

        return Container();
      });
}
