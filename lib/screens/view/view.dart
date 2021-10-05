import 'dart:io';

import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:discount_cards/routes.dart';
import 'package:discount_cards/screens/view/favorite_icon.dart';

class View extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final item =
        (ModalRoute.of(context)!.settings.arguments as RouteArguments).item;

    return Scaffold(
        appBar: AppBar(title: Text(item.name), actions: [
          FavoriteIcon(item),
          IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () => item.toEditRoute(context))
        ]),
        body: PhotoViewGallery(
            pageOptions: item.images
                .map((image) => PhotoViewGalleryPageOptions(
                      minScale: PhotoViewComputedScale.contained,
                      maxScale: PhotoViewComputedScale.contained * 3,
                      imageProvider: FileImage(File(image)),
                    ))
                .toList()));
  }
}
