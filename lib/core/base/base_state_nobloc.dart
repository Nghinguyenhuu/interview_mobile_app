import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../generated/l10n.dart';
import '../../resources/resources.dart';
import '../core.dart';
import 'loading_widget.dart';

abstract class BaseStateNoBloc<T extends StatefulWidget> extends State<T> {
  S get localization => S.of(context);

  List<StreamSubscription> _subscribers = [];

  ConnectivityService get connectivityService =>
      GetIt.I.get<ConnectivityService>();

  bool get dismissKeyboardWhenClickOutside => false;

  bool get manualControlDisposeBloc => false;

  // change this flag to true when using your layout
  bool get isCustomLayout => false;

  // set true to not use default loading on base state
  bool get manualControlLoading => false;

  bool get resizeToAvoidBottomInset => false;

  // override this function to receive data passing from previous screen
  void onReceivePayload(Object? payload) {}

  // override this function to init data for screen
  void initData() {}

  // override this function to catch event click on parent
  void onTapParent() {}

  bool _isFirstInitialize = true;

  bool isTablet() {
    return View.of(context).physicalSize.shortestSide >= 600;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isFirstInitialize) {
      _isFirstInitialize = false;
      if (mounted) {
        final args = ModalRoute.of(context)?.settings.arguments;
        onReceivePayload(args);
      }
      initData();
    }
  }

  @override
  Widget build(BuildContext context) {
    debugInvertOversizedImages = false;
    Widget _body;

    _body = buildContent(context);

    final appBar = buildAppBar(context);
    return isCustomLayout
        ? _body
        : GestureDetector(
            onTap: () {
              onTapParent();
              if (dismissKeyboardWhenClickOutside) {
                dismissKeyboard();
              }
            },
            child: Scaffold(
              resizeToAvoidBottomInset: resizeToAvoidBottomInset,
              appBar: appBar == null
                  ? null
                  : PreferredSize(
                      preferredSize: Size.fromHeight(appBarHeight),
                      child: appBar,
                    ),
              floatingActionButton: buildFloatingActionButton(context),
              body: SafeArea(
                child: _body,
              ),
            ),
          );
  }

  Widget buildContent(BuildContext context) => Container();

  Widget? buildAppBar(BuildContext context) => null;

  Widget? buildFloatingActionButton(BuildContext context) => null;

  Widget buildLoading(BuildContext context) => const LoadingWidget();

  double get appBarHeight => kToolbarHeight;

  @override
  void dispose() {
    for (var subscriber in _subscribers) {
      subscriber.cancel();
    }
    super.dispose();
  }

  void dismissKeyboard() {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  void registerSubscriber(StreamSubscription? subscriber) {
    if (subscriber == null) return;
    _subscribers.add(subscriber);
  }

  AppColors get appColors => Theme.of(context).extension<AppColors>()!;

  TextTheme get textTheme => Theme.of(context).textTheme;
}
