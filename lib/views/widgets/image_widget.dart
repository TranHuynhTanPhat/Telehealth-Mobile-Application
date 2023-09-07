// import 'dart:io';

// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter_chat_sdk/data/api/api_constants.dart';
// import 'package:flutter_chat_sdk/res/theme/theme_service.dart';
// import 'package:flutter_chat_sdk/ui/widget/shimmer_widget.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:flutter_cache_manager/flutter_cache_manager.dart';

// class ImageLoader {
//   static Widget svg(
//     String path, {
//     double? width,
//     double? height,
//     BoxFit? fit,
//     Color? color,
//     BlendMode? blendMode,
//   }) {
//     return SvgPicture.asset(
//       path,
//       height: height,
//       width: width,
//       fit: fit ?? BoxFit.scaleDown,
//       color: color,
//       colorBlendMode: blendMode ?? BlendMode.srcIn,
//     );
//   }

//   static Widget local(
//     File file, {
//     double? width,
//     double? height,
//     double? radius,
//     BoxFit? fit,
//     Color? color,
//   }) {
//     return ClipRRect(
//       borderRadius: BorderRadius.circular(radius ?? 0),
//       child: Image.file(
//         file,
//         height: height,
//         width: width,
//         fit: fit,
//       ),
//     );
//   }

//   static Widget asset(
//     String path, {
//     double? width,
//     double? height,
//     BoxFit? fit,
//     Color? color,
//   }) {
//     return Image.asset(
//       path,
//       width: width,
//       height: height,
//       fit: fit,
//       color: color,
//     );
//   }

//   static Widget remote(
//       {required String? url,
//       required double height,
//       required double width,
//       double? radius,
//       Widget? errorHolder,
//       dynamic placeholder,
//       BoxFit? boxFit,
//       Color? strokeColor,
//       double? strokeWidth}) {
//     return RoundNetworkImage(
//       url: getFullLinkImage(url),
//       height: height,
//       width: width,
//       radius: radius,
//       errorHolder: errorHolder,
//       placeholder: placeholder,
//       boxFit: boxFit,
//       strokeColor: strokeColor,
//       strokeWidth: strokeWidth,
//     );
//   }

//   // static Widget avatar(
//   //     {required String? url,
//   //     required double radius,
//   //     required String? groupName,
//   //     Widget? errorHolder,
//   //     dynamic placeholder,
//   //     BoxFit? boxFit,
//   //     Color? strokeColor,
//   //     double? strokeWidth}) {
//   //   return url?.isNotEmpty == true
//   //       ? RoundNetworkImage(
//   //           url: getFullLinkAvatar(url),
//   //           height: radius * 2,
//   //           width: radius * 2,
//   //           radius: radius,
//   //           errorHolder: errorHolder,
//   //           placeholder: placeholder,
//   //           boxFit: boxFit,
//   //           strokeColor: strokeColor,
//   //           strokeWidth: strokeWidth,
//   //         )
//   //       : TextAvatar(
//   //           size: radius * 2,
//   //           shape: Shape.Circular,
//   //           text: groupName,
//   //           numberLetters: groupName != null && groupName.length >= 2 ? 2 : 0,
//   //           backgroundColor: getColorFromText(groupName),
//   //         );
//   // }

//   static String getFullLinkImage(String? url) {
//     if (url?.isNotEmpty == true) {
//       return url!.contains("http") ? url : PHOTO_URL + "/" + url;
//     } else {
//       return "";
//     }
//   }

//   static String getFullLinkAvatar(String? url) {
//     if (url?.isNotEmpty == true) {
//       return url!.contains("http") ? url : PHOTO_URL + "/" + url;
//     } else {
//       return "";
//     }
//   }
// }

// class CustomCacheManager {
//   static const key = 'customCacheKey';
//   static CacheManager instance = CacheManager(
//     Config(
//       key,
//       stalePeriod: const Duration(days: 2),
//       maxNrOfCacheObjects: 1000,
//       repo: JsonCacheInfoRepository(databaseName: key),
//       fileService: HttpFileService(),
//     ),
//   );
// }

// class RoundNetworkImage extends StatelessWidget {
//   final String? url;
//   final double height;
//   final double width;
//   final double? radius;
//   final Widget? errorHolder;
//   final dynamic placeholder;
//   final BoxFit? boxFit;
//   final Color? strokeColor;
//   final double? strokeWidth;

//   RoundNetworkImage(
//       {required this.width,
//       required this.height,
//       this.url,
//       this.radius = 0.0,
//       this.placeholder,
//       this.errorHolder,
//       this.boxFit,
//       this.strokeColor,
//       this.strokeWidth});

//   @override
//   Widget build(BuildContext context) {
//     return ClipRRect(
//       borderRadius: BorderRadius.circular(radius ?? 0),
//       child: CachedNetworkImage(
//         cacheManager: CustomCacheManager.instance,
//         fadeInDuration: const Duration(milliseconds: 300),
//         fadeOutDuration: const Duration(milliseconds: 500),
//         imageUrl: url ?? "",
//         imageBuilder: (context, imageProvider) => Container(
//           height: height,
//           width: width,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.all(Radius.circular(radius ?? 0)),
//             border: Border.all(
//                 color: strokeColor ?? getColor().themeColorTransparent,
//                 width: strokeWidth ?? 0),
//             image: DecorationImage(
//               image: imageProvider,
//               fit: boxFit ?? BoxFit.cover,
//             ),
//           ),
//         ),
//         placeholder: (context, url) => _placeHolder(context),
//         errorWidget: (context, url, error) =>
//             errorHolder ?? _placeHolder(context),
//         memCacheWidth: width > 200 ? 200 : width.toInt(),
//         memCacheHeight: height > 200 ? 200 : height.toInt(),
//       ),
//     );
//   }

//   Widget _placeHolder(BuildContext context) {
//     return SizedBox(
//       height: height,
//       width: width,
//       child: placeholder != null
//           ? placeholder is Widget
//               ? placeholder
//               : Container(
//                   decoration: BoxDecoration(
//                       borderRadius: BorderRadius.all(Radius.circular(radius!)),
//                       image: placeholder is String
//                           ? DecorationImage(
//                               image: AssetImage(placeholder),
//                               fit: boxFit ?? BoxFit.cover,
//                             )
//                           : null))
//           : ShimmerWidget(
//               child: Container(
//                 height: height,
//                 width: width,
//                 color: getColor().bgThemeColorWhite,
//               ),
//             ),
//     );
//   }
// }
