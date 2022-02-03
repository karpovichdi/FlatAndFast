import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flat_and_fast/common/controls/animated/buttons/floating_menu_button.dart';
import 'package:flat_and_fast/common/controls/app_bars/firebase_home_app_bar.dart';
import 'package:flat_and_fast/common/controls/dialogs/image_card_dialog.dart';
import 'package:flat_and_fast/common/controls/image/loading_network_image.dart';
import 'package:flat_and_fast/common/controls/loading/loading_page.dart';
import 'package:flat_and_fast/common/navigation/navigation_helper.dart';
import 'package:flat_and_fast/common/services/local_notification_service.dart';
import 'package:flat_and_fast/common/utils/styles/app_colors.dart';
import 'package:flat_and_fast/features/firebase/home/firebase_feature.dart';
import 'package:flat_and_fast/features/firebase/home/redux/firebase_home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import '../../../common/controls/dialogs/information_dialog.dart';
import '../../../common/redux/app/app_state.dart';
import '../../../common/utils/styles/dimensions.dart';

const homeTitle = 'Home';

class FirebaseHomeScreen extends StatefulWidget {
  const FirebaseHomeScreen({Key? key}) : super(key: key);

  @override
  State<FirebaseHomeScreen> createState() => _FirebaseHomeScreenState();
}

class _FirebaseHomeScreenState extends State<FirebaseHomeScreen> {
  bool menuCloseRequested = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, FirebaseHomeViewModel>(
        onWillChange: _stateWillChange,
        onInitialBuild: _initializeViewModel,
        converter: (store) {
          return FirebaseHomeViewModel.fromStore(store);
        },
        builder: (_, viewModel) {
          return Scaffold(
            backgroundColor: AppColors.white,
            floatingActionButton: MenuState(
              menuCloseRequested: menuCloseRequested,
              onValueChanged: (bool value) => _setMenuCloseRequest(false),
              child: FloatingMenuButton(
                firstButtonIcon: const Icon(Icons.cloud_upload, color: AppColors.white),
                secondButtonIcon: const Icon(Icons.person, color: AppColors.white),
                firstButtonColor: AppColors.green,
                secondButtonColor: AppColors.blue,
                firstButtonAction: () => viewModel.changeSelectedFeature(FirebaseFeature.fileUpload),
                secondButtonAction: () => viewModel.changeSelectedFeature(FirebaseFeature.pushNotifications),
              ),
            ),
            body: Builder(builder: (context) {
              if (viewModel.selectedFeature == FirebaseFeature.fileUpload) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: NotificationListener<ScrollNotification>(
                        onNotification: (scrollNotification) => _onScrolled(scrollNotification),
                        child: RefreshIndicator(
                          onRefresh: () => viewModel.listAllThumbnails(),
                          child: CustomScrollView(
                            physics: const BouncingScrollPhysics(),
                            slivers: [
                              SliverAppBar(
                                title: FirebaseHomeAppBar(
                                  title: homeTitle,
                                  disableUpload: viewModel.selectedFile == null || viewModel.uploadTask != null,
                                  addAction: () => viewModel.selectFile(),
                                  uploadAction: () => viewModel.uploadFile(),
                                  changeApi: () => viewModel.changeApi(),
                                  realApi: viewModel.realApi,
                                ),
                                centerTitle: true,
                                pinned: true,
                                elevation: Dimensions.appBarElevation,
                                titleSpacing: 0.0,
                              ),
                              SliverToBoxAdapter(
                                child: Column(
                                  children: [
                                    viewModel.selectedFile != null
                                        ? Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                            child: SizedBox(
                                              child: ClipOval(
                                                child: Image.file(
                                                  viewModel.selectedFile!.file!,
                                                  height: 100.0,
                                                  width: 100.0,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          )
                                        : Container(),
                                    viewModel.uploadTask != null
                                        ? StreamBuilder<TaskSnapshot>(
                                            stream: viewModel.uploadTask!.snapshotEvents,
                                            builder: (context, snapshot) {
                                              if (snapshot.hasData) {
                                                var data = snapshot.data!;
                                                final progress = data.bytesTransferred / data.totalBytes;
                                                var percentageValue = progress * 100;
                                                final percentage = percentageValue.toStringAsFixed(2);
                                                return Text(
                                                  'Progress: $percentage %',
                                                  style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                                                );
                                              }
                                              return Container();
                                            })
                                        : Container(),
                                  ],
                                ),
                              ),
                              SliverList(
                                delegate: SliverChildBuilderDelegate(
                                  (BuildContext context, int index) {
                                    return GestureDetector(
                                      onTap: () => _cellClicked(viewModel, index),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                                        child: SizedBox(
                                          height: 90.0,
                                          child: Card(
                                            elevation: 4.0,
                                            child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets.only(right: 8.0),
                                                    child: SizedBox(
                                                      width: 70.0,
                                                      child: ClipOval(
                                                        child: LoadingNetworkImage(
                                                          imageSize: 70.0,
                                                          imageUrl: viewModel.thumbnails?[index].url ?? '',
                                                          isBusy: false,
                                                          loadingWidget: const SizedBox(
                                                            height: 40.0,
                                                            width: 20.0,
                                                            child: LoadingPage(),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(width: 8.0),
                                                  Expanded(
                                                    flex: 6,
                                                    child: Text('${viewModel.thumbnails?[index].name}'),
                                                  ),
                                                  Expanded(
                                                    flex: 1,
                                                    child: Padding(
                                                      padding: const EdgeInsets.only(right: 8.0),
                                                      child: Builder(builder: (context) {
                                                        if (viewModel.downloadingFiles.contains(viewModel.thumbnails?[index])) {
                                                          return const FittedBox(child: LoadingPage());
                                                        } else if (viewModel.downloadedFiles.contains(viewModel.thumbnails?[index])) {
                                                          return Icon(
                                                            Icons.image,
                                                            color: Colors.blueAccent.shade100,
                                                          );
                                                        }
                                                        return Icon(
                                                          Icons.download_sharp,
                                                          color: Colors.blueAccent.shade100,
                                                        );
                                                      }),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                  childCount: viewModel.thumbnails?.length ?? 0,
                                ),
                              ),
                              const SliverPadding(padding: EdgeInsets.only(bottom: 80.0))
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              } else if (viewModel.selectedFeature == FirebaseFeature.pushNotifications) {
                return Container(
                  color: AppColors.orangeAccent,
                );
              }

              return Container(
                color: AppColors.blue,
              );
            }),
          );
        });
  }

  void _showDialogImage(FirebaseHomeViewModel newViewModel) {
    showDialog<void>(
        barrierColor: AppColors.transparent,
        context: context,
        builder: (context) {
          return ImageCardDialog(
            imageFile: newViewModel.openedImage?.file,
            dismissAction: () => _dismissDialogIntent(newViewModel),
          );
        });
  }

  _showDialog(FirebaseHomeViewModel viewModel, {required String title, required String message}) {
    showDialog<void>(
        barrierColor: AppColors.transparent,
        context: context,
        builder: (context) {
          return InformationDialog(
            dismissAction: () => NavigationHelper.goBack(context: context),
            message: message,
            title: title,
          );
        });
  }

  _dismissDialogIntent(FirebaseHomeViewModel viewModel) {
    viewModel.closeImage();
  }

  _initializeViewModel(FirebaseHomeViewModel viewModel) {
    viewModel.listAllThumbnails();

    LocalNotificationService.initialize(context);

    /// Put message in notification bar and open app after
    /// click on this message, if app terminated.
    /// If value != null then user clicked on message
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if(message != null){
        String routeFromMessage = message.data['route'];
        Navigator.of(context).pushNamed(routeFromMessage);
      }
    });

    /// foreground work
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      LocalNotificationService.display(message);
    });

    /// app open, but in background
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      String routeFromMessage = message.data['route'];
      print('Result: ');
      print(routeFromMessage);
      Navigator.of(context).pushNamed(routeFromMessage);
    });
  }

  bool _onScrolled(ScrollNotification scrollNotification) {
    if (scrollNotification is ScrollStartNotification) {
      _setMenuCloseRequest(true);
    }
    return true;
  }

  _cellClicked(FirebaseHomeViewModel viewModel, int index) {
    var thumbnail = viewModel.thumbnails?[index];
    if (viewModel.downloadedFiles.contains(thumbnail)) {
      viewModel.openImage(thumbnail);
    } else {
      viewModel.downloadFile(thumbnail);
    }
  }

  _setMenuCloseRequest(bool value) {
    Future.delayed(
      Duration.zero,
      () => setState(() {
        menuCloseRequested = value;
      }),
    );
  }

  _stateWillChange(
    FirebaseHomeViewModel? previousViewModel,
    FirebaseHomeViewModel newViewModel,
  ) {
    if (previousViewModel == null) return;

    var intentToShowImage = previousViewModel.openedImage == null && newViewModel.openedImage != null;
    var intentToHideImage = previousViewModel.openedImage != null && newViewModel.openedImage == null;

    if (intentToShowImage) {
      _showDialogImage(newViewModel);
    } else if (intentToHideImage) {
      NavigationHelper.goBack(context: context);
    }
  }
}
