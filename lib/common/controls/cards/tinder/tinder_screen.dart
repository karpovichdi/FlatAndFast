import 'package:flat_and_fast/common/controls/buttons/feature_button.dart';
import 'package:flat_and_fast/common/controls/cards/tinder/card_status.dart';
import 'package:flat_and_fast/common/controls/cards/tinder/front_card.dart';
import 'package:flat_and_fast/common/controls/cards/tinder/back_card.dart';
import 'package:flat_and_fast/common/controls/cards/tinder/tinder_button.dart';
import 'package:flat_and_fast/common/controls/cards/tinder/tinder_view_model.dart';
import 'package:flat_and_fast/common/utils/styles/app_colors.dart';
import 'package:flat_and_fast/common/utils/styles/styles.dart';
import 'package:flutter/material.dart';

const restartTitle = 'Restart';
const pageTitle = 'Tinder';

class TinderScreen extends StatefulWidget {
  const TinderScreen({Key? key}) : super(key: key);

  @override
  _TinderScreenState createState() => _TinderScreenState();
}

class _TinderScreenState extends State<TinderScreen> {
  TinderViewModel? _viewModel;

  @override
  void initState() {
    super.initState();

    _initializeViewModel();
    TinderViewModel viewModel = _viewModel!;

    WidgetsBinding.instance?.addPostFrameCallback((_) {
      viewModel.screenSize = MediaQuery.of(context).size;
    });

    viewModel.resetUsers();
  }

  @override
  Widget build(BuildContext context) {
    if (_viewModel == null) {
      _initializeViewModel();
    }
    TinderViewModel viewModel;
    viewModel = _viewModel!;

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColors.white,
            AppColors.grey.shade600,
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text(
            pageTitle,
            style: TextStyle(
              color: Theme.of(context).iconTheme.color,
            ),
          ),
        ),
        body: SafeArea(
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(16),
            child: Builder(builder: (context) {
              List<String> imageUrls;
              if (viewModel.imageUrls != null) {
                imageUrls = viewModel.imageUrls!;
              } else {
                return Container();
              }
              return imageUrls.isEmpty
                  ? Center(
                      child: FeatureButton(
                        action: () => viewModel.resetUsers(),
                        title: restartTitle,
                      ),
                    )
                  : Stack(
                      children: imageUrls
                          .map(
                            (imageUrl) => Column(
                              children: [
                                Expanded(
                                  child: SizedBox.expand(
                                    child: imageUrls.last == imageUrl
                                        ? FrontCard(
                                            imageUrl: imageUrl,
                                            position: viewModel.position,
                                            angle: viewModel.angle,
                                            status: viewModel.status,
                                            isDragging: viewModel.isDragging,
                                            startPosition: (DragStartDetails details) => viewModel.startPosition(details),
                                            updatePosition: (DragUpdateDetails details) => viewModel.updatePosition(details),
                                            endPosition: () => viewModel.endPosition(imageUrls),
                                          )
                                        : BackCard(imageUrl: imageUrl),
                                  ),
                                ),
                                const SizedBox(height: 16.0),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    TinderButton(
                                      icon: Icons.clear,
                                      positiveColor: AppColors.red,
                                      negativeColor: AppColors.white,
                                      actualStatus: viewModel.status,
                                      buttonStatus: CardStatus.dislike,
                                      action: () => viewModel.dislike(viewModel.position, imageUrls),
                                    ),
                                    TinderButton(
                                      icon: Icons.star,
                                      positiveColor: AppColors.blue,
                                      negativeColor: AppColors.white,
                                      actualStatus: viewModel.status,
                                      buttonStatus: CardStatus.superLike,
                                      action: () => viewModel.superLike(viewModel.position, imageUrls),
                                    ),
                                    TinderButton(
                                      icon: Icons.favorite,
                                      positiveColor: AppColors.teal,
                                      negativeColor: AppColors.white,
                                      actualStatus: viewModel.status,
                                      buttonStatus: CardStatus.like,
                                      action: () => viewModel.like(viewModel.position, imageUrls),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )
                          .toList(),
                    );
            }),
          ),
        ),
      ),
    );
  }

  _updateItemSource({required List<String>? imageUrls}) {
    if (_viewModel == null) {
      _initializeViewModel();
    }
    TinderViewModel viewModel;
    viewModel = _viewModel!;

    setState(() => viewModel.imageUrls = imageUrls);
  }

  _updatePosition({required UpdateCardStateAction action}) {
    if (_viewModel == null) {
      _initializeViewModel();
    }
    TinderViewModel viewModel;
    viewModel = _viewModel!;

    List<String>? imageUrls = action.imageUrls;
    imageUrls ??= viewModel.imageUrls;

    setState(() {
      viewModel.position = action.position;
      viewModel.isDragging = action.isDragging;
      viewModel.angle = action.angle;
      viewModel.status = action.status;
      viewModel.imageUrls = imageUrls;
    });
  }

  _initializeViewModel() {
    _viewModel = TinderViewModel(
      updateCardState: (UpdateCardStateAction action) => _updatePosition(action: action),
      updateItemSource: (List<String>? imageUrls) => _updateItemSource(imageUrls: imageUrls),
    );
  }
}
