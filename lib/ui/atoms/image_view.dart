import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../core/constants/value_constants.dart';

import '../../core/helpers/ui_helpers.dart';

class ImageView extends StatefulWidget {
  final ImageShapes shape;
  final String strIconData;
  final double dBorderTopLeftRadius;
  final double dBorderTopRightRadius;
  final double dBorderBottomLeftRadius;
  final double dBorderBottomRightRadius;
  final VoidCallback? clickAction;
  final Color borderColor;
  final BoxFit? boxFit;
  final double? loaderHeight;
  final double? loaderwidth;
  final double? width;
  final double? height;
  final bool isSVG;

  const ImageView(
      {Key? key,
      this.shape = ImageShapes.Standard, // Default
      required this.strIconData,
      this.dBorderTopLeftRadius = HEADER_CARD_BORDER_RADIUS,
      this.dBorderTopRightRadius = HEADER_CARD_BORDER_RADIUS,
      this.dBorderBottomLeftRadius = HEADER_CARD_BORDER_RADIUS,
      this.dBorderBottomRightRadius = HEADER_CARD_BORDER_RADIUS,
      this.clickAction = _defaultFunction,
      this.borderColor = Colors.white,
      this.boxFit = BoxFit.fill,
      this.loaderHeight = 0,
      this.loaderwidth = 0,
      this.isSVG = false,
      this.width,
      this.height})
      : super(key: key);

  static _defaultFunction() {
    // Does nothing
  }

  factory ImageView.square(
      {required String strIconData, VoidCallback? clickAction}) {
    return ImageView(
        strIconData: strIconData,
        shape: ImageShapes.Square,
        dBorderTopLeftRadius: 0,
        dBorderTopRightRadius: 0,
        dBorderBottomLeftRadius: 0,
        dBorderBottomRightRadius: 0,
        clickAction: clickAction);
  }
  factory ImageView.file(
      {required String strIconData,
      VoidCallback? clickAction,
      double? height,
      double? width}) {
    return ImageView(
        strIconData: strIconData,
        shape: ImageShapes.File,
        dBorderTopLeftRadius: 0,
        dBorderTopRightRadius: 0,
        dBorderBottomLeftRadius: 0,
        dBorderBottomRightRadius: 0,
        width: width,
        height: height,
        clickAction: clickAction);
  }

  @override
  State<ImageView> createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {
  // late CachedNetworkImage image = CachedNetworkImage(
  //   imageUrl: widget.strIconData,
  //   fit: BoxFit.fill,
  //   placeholder: (context, url) =>
  //       Container(child: HelperUI.getProgressIndicator()),
  //   errorWidget: (context, url, error) => Padding(
  //     padding: const EdgeInsets.symmetric(horizontal: 8.0),
  //     child: Container(
  //       color: Colors.grey,
  //     ),
  //   ),
  // );

  Image? images;
  bool isLooading = true;

  @override
  void initState() {
    if (widget.shape != ImageShapes.File) {
      images = Image(
        image: NetworkImage(widget.strIconData),
        errorBuilder: (context, error, stackTrace) => Container(
          color: Colors.grey,
        ),
        fit: widget.boxFit,
      );

      images!.image
          .resolve(const ImageConfiguration())
          .addListener(ImageStreamListener((_, __) {
            if (mounted) {
              setState(() {
                isLooading = false;
              });
            }
          }, onError: (exception, stackTrae) {
            if (mounted) {
              setState(() {
                isLooading = false;
              });
            }
          }));
    }

    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (widget.shape != ImageShapes.File) precacheImage(images!.image, context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.clickAction,
      child: widget.shape == ImageShapes.File
          ? widget.isSVG
              ? SvgPicture.asset(
                  widget.strIconData,
                  height: widget.height,
                  width: widget.width,
                )
              : Image.asset(
                  widget.strIconData,
                  height: widget.height,
                  width: widget.width,
                )
          : ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(widget.dBorderTopLeftRadius),
                topRight: Radius.circular(widget.dBorderTopRightRadius),
                bottomLeft: Radius.circular(widget.dBorderBottomLeftRadius),
                bottomRight: Radius.circular(widget.dBorderBottomRightRadius),
              ),
              child: isLooading
                  ? UIHelper.getProgressGhost(
                      height: widget.loaderHeight, width: widget.loaderHeight)
                  : images),
    );
  }
}
