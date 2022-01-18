import 'package:flat_and_fast/common/controls/buttons/feature_button.dart';
import 'package:flat_and_fast/common/controls/image/loading_memory_image.dart';
import 'package:flat_and_fast/common/controls/loading/loading_page.dart';
import 'package:flat_and_fast/common/controls/video/asset_player.dart';
import 'package:flat_and_fast/common/controls/video/file_player.dart';
import 'package:flat_and_fast/common/redux/app/app_state.dart';
import 'package:flat_and_fast/common/utils/log.dart';
import 'package:flat_and_fast/common/utils/styles/styles.dart';
import 'package:flat_and_fast/features/camera/redux/camera_view_model.dart';
import 'package:flutter/material.dart';

import 'package:flutter_redux/flutter_redux.dart';
import 'package:image_picker/image_picker.dart';

import '../../di.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({Key? key}) : super(key: key);

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  @override
  Widget build(BuildContext context) {
    const imageSize = 160.0;
    return StoreConnector<AppState, CameraViewModel>(
        onInitialBuild: _initializeViewModel,
        converter: (store) {
          return CameraViewModel.fromStore(store);
        },
        builder: (_, viewModel) {
          return Scaffold(
            appBar: AppBar(
              title: const Text(
                'Photo / Video',
                style: TextStyles.appBarTitle,
              ),
            ),
            body: ListView(
              children: [
                Column(
                  children: [
                    Builder(builder: (context) {
                      if (viewModel.imagePath.isNotEmpty) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 48.0),
                          child: Center(
                            child: ClipOval(
                              child: LoadingMemoryImage(
                                path: viewModel.imagePath,
                                imageSize: imageSize,
                                isBusy: viewModel.isLoading,
                                loadingWidget: const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: LoadingPage(),
                                ),
                              ),
                            ),
                          ),
                        );
                      } else if (viewModel.assetVideoPath.isNotEmpty) {
                        return AssetPlayer(path: viewModel.assetVideoPath);
                      } else if (viewModel.fileVideoPath.isNotEmpty) {
                        return FilePlayer(path: viewModel.fileVideoPath);
                      } else {
                        return const FlutterLogo(size: imageSize);
                      }
                    }),
                  ],
                ),
                FeatureButton(
                  action: () => viewModel.playVideo(),
                  title: 'Play horizontal video',
                ),
                FeatureButton(
                  action: () => viewModel.playPortraitVideo(),
                  title: 'Play portrait video',
                ),
                FeatureButton(
                  action: () => viewModel.pickImage(ImageSource.gallery),
                  title: 'Pick gallery',
                ),
                FeatureButton(
                  action: () => viewModel.pickImage(ImageSource.camera),
                  title: 'Take a photo',
                ),
                FeatureButton(
                  action: () => viewModel.pickVideo(ImageSource.camera),
                  title: 'Take a video',
                ),
              ],
            ),
          );
        });
  }

  void _initializeViewModel(CameraViewModel viewModel) {
    viewModel.loadStorageImage(getIt.get<Log>());
  }
}
