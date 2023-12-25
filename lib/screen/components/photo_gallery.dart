// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:cloudinary_flutter/cloudinary_context.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

import 'package:healthline/res/style.dart';
import 'package:healthline/utils/log_data.dart';

class PhotoGallery extends StatefulWidget {
  const PhotoGallery({super.key, required this.galleryItems});
  final List<String> galleryItems;

  @override
  State<PhotoGallery> createState() => _PhotoGalleryState();
}

class _PhotoGalleryState extends State<PhotoGallery> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      extendBody: true,
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 10,
      ),
      body: SafeArea(
        child: PhotoViewGallery.builder(
          backgroundDecoration: const BoxDecoration(color: white),
          scrollPhysics: const BouncingScrollPhysics(),
          builder: (BuildContext context, int index) {
            var image;

            try {
              if (widget.galleryItems[index] != 'default' &&
                  widget.galleryItems[index] != '') {
                image = image ??
                    NetworkImage(
                      CloudinaryContext.cloudinary
                          .image(widget.galleryItems[index])
                          .toString(),
                    );
              } else {
                image = AssetImage(DImages.placeholder);
              }
            } catch (e) {
              logPrint(e);
              image = AssetImage(DImages.placeholder);
            }
            return PhotoViewGalleryPageOptions(
              imageProvider: image,
              initialScale: PhotoViewComputedScale.contained * .8,
              // heroAttributes: PhotoViewHeroAttributes(tag: widget.galleryItems[index]),
            );
          },
          itemCount: widget.galleryItems.length,
          loadingBuilder: (context, event) => Center(
            child: SizedBox(
              width: 20.0,
              height: 20.0,
              child: CircularProgressIndicator(
                value: event == null
                    ? 0
                    : event.cumulativeBytesLoaded /
                        (event.expectedTotalBytes ??
                            event.cumulativeBytesLoaded),
              ),
            ),
          ),
          // backgroundDecoration: widget.backgroundDecoration,
          // pageController: widget.pageController,
          // onPageChanged: onPageChanged,
        ),
      ),
    );
  }
}
