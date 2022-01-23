import 'dart:core';

import 'package:flat_and_fast/common/controls/cards/tinder/card_status.dart';
import 'package:flat_and_fast/gen/assets.gen.dart';
import 'package:flutter/material.dart';

import 'card_status.dart';

class TinderViewModel {
  TinderViewModel({
    required this.updateCardState,
    required this.updateItemSource,
  });

  final Function(UpdateCardStateAction) updateCardState;
  final Function(List<String>?) updateItemSource;

  Size screenSize = Size.zero;
  Offset position = Offset.zero;
  bool isDragging = false;
  double angle = 0.0;
  CardStatus? status;
  List<String>? imageUrls;

  startPosition(DragStartDetails details) {
    var status = _getStatus(position: position, force: false);
    updateCardState(UpdateCardStateAction(
      position: position,
      isDragging: true,
      angle: 0,
      status: status,
      imageUrls: null,
    ));
  }

  updatePosition(DragUpdateDetails details) {
    position += details.delta;

    final x = position.dx;
    final angle = 25 * x / screenSize.width;
    var status = _getStatus(position: position, force: false);

    updateCardState(UpdateCardStateAction(
      position: position,
      isDragging: true,
      angle: angle,
      status: status,
      imageUrls: null,
    ));
  }

  endPosition(List<String> imageUrls) {
    var status = _getStatus(position: position, force: true);

    switch (status) {
      case CardStatus.like:
        like(position, imageUrls);
        break;
      case CardStatus.dislike:
        dislike(position, imageUrls);
        break;
      case CardStatus.superLike:
        superLike(position, imageUrls);
        break;
      default:
        _resetPosition();
    }
  }

  like(
      Offset position,
      List<String> imageUrls,
      ) {
    position += Offset(screenSize.width * 2, 0);
    _nextCard(imageUrls);

    updateCardState(UpdateCardStateAction(
      position: position,
      isDragging: false,
      angle: 20,
      status: CardStatus.like,
      imageUrls: null,
    ));
  }

  dislike(
      Offset position,
      List<String> imageUrls,
      ) {
    position -= Offset(screenSize.width * 2, 0);
    _nextCard(imageUrls);

    updateCardState(UpdateCardStateAction(
      position: position,
      isDragging: false,
      angle: -20,
      status: CardStatus.dislike,
      imageUrls: null,
    ));
  }

  superLike(
      Offset position,
      List<String> imageUrls,
      ) {
    position -= Offset(0, screenSize.height);
    _nextCard(imageUrls);

    updateCardState(UpdateCardStateAction(
      position: position,
      isDragging: false,
      angle: 0,
      status: CardStatus.superLike,
      imageUrls: null,
    ));
  }

  resetUsers() {
    final List<String> mockedImages = <String>[
      Assets.images.portraitImage1.path,
      Assets.images.portraitImage2.path,
      Assets.images.portraitImage3.path,
      Assets.images.portraitImage4.path,
    ];

    updateItemSource(mockedImages);
  }

  CardStatus? _getStatus({required Offset position, bool force = false}) {
    final x = position.dx;
    final y = position.dy;
    final forceSuperLike = x.abs() < 20;

    if (force) {
      const delta = 100;
      if (x >= delta) {
        return CardStatus.like;
      } else if (x <= -delta) {
        return CardStatus.dislike;
      } else if (y <= -delta / 2 && forceSuperLike) {
        return CardStatus.superLike;
      }
    } else {
      const delta = 20;
      if (y <= -delta * 2 && forceSuperLike) {
        return CardStatus.superLike;
      } else if (x >= delta) {
        return CardStatus.like;
      } else if (x <= -delta) {
        return CardStatus.dislike;
      }
    }
  }

  _resetPosition() {
    updateCardState(UpdateCardStateAction(
      position: Offset.zero,
      isDragging: false,
      angle: 0,
      status: null,
      imageUrls: null,
    ));
  }

  Future _nextCard(List<String> imageUrls) async {
    if (imageUrls.isEmpty) return;

    const animationDuration = 200;
    await Future.delayed(const Duration(milliseconds: animationDuration));
    imageUrls.removeLast();

    updateCardState(UpdateCardStateAction(
      position: Offset.zero,
      isDragging: false,
      angle: 0,
      status: null,
      imageUrls: imageUrls,
    ));
  }
}

class UpdateCardStateAction {
  final Offset position;
  final bool isDragging;
  final double angle;
  final CardStatus? status;
  final List<String>? imageUrls;

  UpdateCardStateAction({
    required this.position,
    required this.isDragging,
    required this.angle,
    required this.status,
    required this.imageUrls,
  });
}
