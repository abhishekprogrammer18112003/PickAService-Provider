
import 'package:flutter/scheduler.dart';
import 'package:pick_a_service/core/utils/screen_utils.dart';
import 'package:pick_a_service/ui/molecules/toast_widget.dart';

import 'app_imports.dart';
import 'constants/app_colors.dart';

class OverlayManager {
  Widget? _widget;

  LoaderOverlayEntry? overlayEntry;
  Widget? get w => _widget;

  factory OverlayManager() => _instance;
  static final OverlayManager _instance = OverlayManager._internal();

  OverlayManager._internal();

  static OverlayManager get instance => _instance;

  static bool get onScreen => _instance.w != null;

  static TransitionBuilder init({
    TransitionBuilder? builder,
  }) {
    return (BuildContext context, Widget? child) {
      if (builder != null) {
        return builder(context, LoaderOverlay(child: child));
      } else {
        return LoaderOverlay(child: child);
      }
    };
  }

  //Duration in milliseconds
  static showLoader({required double opacity, required Color color}) {
    Widget w = Material(
        elevation: 0.0,
        color: color.withOpacity(opacity),
        child: Center(
          child: Container(
            alignment: Alignment.center,
            color: Colors.black26,
            child: const CircularProgressIndicator(
              color: AppColors.primary,
            ),
            // const ImageView(
            //   strIconData: AppIcons.badge,
            //   shape: ImageShapes.File,
            //   width: 60),
          ),
        ));

    SchedulerBinding.instance
        .addPostFrameCallback((_) => _instance._show(widget: w));

    _instance._show(widget: w);
  }

  // static showPreviewImage({
  //   required double opacity,
  //   required Color color,
  //   required String imageUrl,
  //   bool isLocal = false,
  // }) {
  //   Widget w = Material(
  //       elevation: 0.0,
  //       color: color.withOpacity(opacity),
  //       child: Center(
  //         child: Container(
  //           alignment: Alignment.center,
  //           color: Colors.black26,
  //           child: DocPreviewWidget(
  //             url: imageUrl,
  //             isLocal: isLocal,
  //             onCloseTap: () {
  //               hideOverlay();
  //             },
  //           ),
  //         ),
  //       ));

  //   SchedulerBinding.instance
  //       .addPostFrameCallback((_) => _instance._show(widget: w));

  //   _instance._show(widget: w);
  // }

  // static showYoutubePlayer(String videoURL) {
  //   Widget w = YoutubePlayerOverlayWidget(videoURL: videoURL);

  //   SchedulerBinding.instance
  //       .addPostFrameCallback((_) => _instance._show(widget: w));

  //   _instance._show(widget: w);
  // }

  static int _toastEnumToDuration(ToastDuration toastDuration) {
    switch (toastDuration) {
      case ToastDuration.short:
        return VALUE_TOAST_DURATION_SHORT;
      case ToastDuration.medium:
        return VALUE_TOAST_DURATION_MEDIUM;
      case ToastDuration.long:
        return VALUE_TOAST_DURATION_LONG;
    }
  }

  static Future<void> showToast(
      {required ToastType type,
      required msg , Alignment align = Alignment.bottomCenter ,Function()? fun ,
      ToastDuration duration = ToastDuration.medium}) async {
    Widget w = Container(
        alignment: align,
        padding: EdgeInsets.only(bottom: 110.h),
        child: ToastWidget(
          type: type,
          title: msg,
           fn: fun
        ));
    SchedulerBinding.instance
        .addPostFrameCallback((_) => _instance._show(widget: w));
    _instance._show(widget: w);
    await Future.delayed(Duration(seconds: _toastEnumToDuration(duration)));
    hideOverlay();
  }

  static Future<void> hideOverlay() {
    return _instance._dismiss();
  }

  _show({Widget? widget}) async {
    _widget = widget;
    _markNeedsBuild();
  }

  Future<void> _dismiss() async {
    _widget = null;
    _markNeedsBuild();
  }

  void _markNeedsBuild() {
    overlayEntry?.markNeedsBuild();
  }

  static TransitionBuilder transitionBuilder({
    TransitionBuilder? builder,
  }) {
    return (BuildContext context, Widget? child) {
      if (builder != null) {
        return builder(
          context,
          MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
            child: LoaderOverlay(child: child),
          ),
        );
      } else {
        // return LoaderOverlay(child: child);
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
          child: LoaderOverlay(child: child),
        );
      }
    };
  }
}

class LoaderOverlayEntry extends OverlayEntry {
  @override
  final WidgetBuilder builder;

  LoaderOverlayEntry({
    required this.builder,
  }) : super(builder: builder);

  @override
  void markNeedsBuild() {
    if (SchedulerBinding.instance.schedulerPhase ==
        SchedulerPhase.persistentCallbacks) {
      SchedulerBinding.instance.addPostFrameCallback((_) {});
      super.markNeedsBuild();
    } else {
      super.markNeedsBuild();
    }
  }
}

class LoaderOverlay extends StatefulWidget {
  final Widget? child;

  const LoaderOverlay({
    Key? key,
    required this.child,
  })  : assert(child != null),
        super(key: key);

  @override
  _LoaderOverlayState createState() => _LoaderOverlayState();
}

class _LoaderOverlayState extends State<LoaderOverlay> {
  late LoaderOverlayEntry _overlayEntry;

  @override
  void initState() {
    super.initState();
    _overlayEntry = LoaderOverlayEntry(
      builder: (BuildContext context) =>
          OverlayManager.instance.w ?? Container(),
    );
    OverlayManager.instance.overlayEntry = _overlayEntry;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Overlay(
        initialEntries: [
          LoaderOverlayEntry(
            builder: (BuildContext context) {
              if (widget.child != null) {
                return widget.child!;
              } else {
                return Container();
              }
            },
          ),
          _overlayEntry,
        ],
      ),
    );
  }
}
