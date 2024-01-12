import 'package:flutter/material.dart';
import '../../generated/l10n.dart';
import '../../resources/resources.dart';
import '../core.dart';
import 'loading_dialog.dart';

abstract class BaseState<T extends StatefulWidget, B extends BaseBloc>
    extends BaseStateNoBloc<T> {
  B get bloc;

  S get localization => S.of(context);

  @override
  void initState() {
    registerSubscriber(
      bloc.waitingStream.listen((loading) {
        if (mounted) {
          if (loading) {
            LoadingDialog.show(context);
          } else {
            LoadingDialog.close(context);
          }
        }
      }),
    );
    registerSubscriber(bloc.stateStream.listen((state) {
      if (mounted) {
        stateListener(state);
      }
    }));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    debugInvertOversizedImages = false;
    Widget _body;

    _body = manualControlLoading
        ? buildContent(context)
        : StreamBuilder<bool>(
      stream: bloc.loadingStream,
      builder: (context, snapShot) {
        if (snapShot.data == true || snapShot.data == null) {
          final _loading = buildLoading(context);
          return isCustomLayout
              ? Scaffold(
            resizeToAvoidBottomInset: resizeToAvoidBottomInset,
            backgroundColor: Colors.transparent,
            body: Center(
              child: _loading,
            ),
          )
              : _loading;
        }
        return buildContent(context);
      },
    );

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

  @override
  void dispose() {
    if (!manualControlDisposeBloc) {
      bloc.dispose();
    }
    super.dispose();
  }

  // override this function to listen event change
  void stateListener(dynamic state) {}

  AppColors get appColors => Theme.of(context).extension<AppColors>()!;

  TextTheme get textTheme => Theme.of(context).textTheme;

}
