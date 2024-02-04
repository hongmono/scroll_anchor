import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// ### [scrollTo]
/// * Scroll to the anchor at the given index or GlobalKey.
///
/// ### [scrollToNext]
/// * Scroll to the next anchor.
///
/// ### [scrollToPrevious]
/// * Scroll to the previous anchor.
///
/// ### [scrollToTop]
/// * Scroll to the top of the scroll view.
mixin ScrollAnchor<T extends StatefulWidget> on State<T> {
  late final ScrollController scrollController = PrimaryScrollController.of(context);

  Duration scrollDuration = const Duration(seconds: 1);

  int anchorIndex = 0;

  List<GlobalKey> anchorKeys = [];

  Future<int> scrollTo(dynamic anchor) async {
    if (anchor is int) {
      if (anchor < 0 || anchor >= anchorKeys.length) return -1;

      anchorIndex = anchor;
      final key = anchorKeys[anchor];
      if (key.currentContext == null) return -1;

      await Scrollable.ensureVisible(key.currentContext!, curve: Curves.easeInOutBack, duration: scrollDuration);

      return anchor;
    } else if (anchor is GlobalKey) {
      final index = anchorKeys.indexOf(anchor);
      if (index == -1) return -1;

      return scrollTo(index);
    }

    return -1;
  }

  Future<int> scrollToNext() async {
    anchorIndex = (anchorIndex + 1) % anchorKeys.length;

    return scrollTo(anchorIndex);
  }

  Future<int> scrollToPrevious() async {
    anchorIndex = anchorIndex - 1;
    if (anchorIndex < 0) anchorIndex = anchorKeys.length - 1;

    return scrollTo(anchorIndex);
  }

  Future scrollToTop() async {
    if (scrollController.hasClients == false) {
      printError('ScrollController has no clients');

      return;
    }

    await scrollController.animateTo(
      0,
      duration: scrollDuration,
      curve: Curves.easeInOutBack,
    );
  }

  void printError(String text) {
    if (kDebugMode) {
      print('\x1B[31m$text\x1B[0m');
    }
  }
}
