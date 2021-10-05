import 'dart:io';

import 'package:flutter/material.dart';
import 'package:discount_cards/utils/index.dart';
import 'package:discount_cards/models/layout_type.dart';

class ImageGrid extends StatelessWidget {
  final List<String> imagePaths;
  final void Function() onGalleryImage;
  final void Function() onCameraImage;
  final void Function(String path) onRemoveImage;

  const ImageGrid(
    this.imagePaths,
    this.onGalleryImage,
    this.onCameraImage,
    this.onRemoveImage,
  ) : super();

  List<Card> _buildImageCards(BuildContext context) => imagePaths.map((path) {
        final size = layoutThumbnailSize(context, LayoutType.smallGrid);
        return Card(
            clipBehavior: Clip.hardEdge,
            child: Stack(children: [
              FittedBox(
                  child: Image.file(File(path),
                      width: size, height: size, fit: BoxFit.cover),
                  clipBehavior: Clip.hardEdge),
              Positioned(
                  right: 5,
                  top: 5,
                  child: CircleAvatar(
                    radius: 10,
                    backgroundColor: Colors.red,
                    child: IconButton(
                        padding: const EdgeInsets.all(0),
                        icon: const Icon(Icons.remove,
                            color: Colors.white, size: 20),
                        color: Colors.white,
                        onPressed: () => onRemoveImage(path)),
                  ))
            ]));
      }).toList();

  List<Card> _buildsActions() => [
        Card(
            child: IconButton(
                icon: const Icon(Icons.photo_library),
                onPressed: onGalleryImage)),
        Card(
            child: IconButton(
                icon: const Icon(Icons.camera), onPressed: onCameraImage)),
      ];

  @override
  Widget build(context) {
    return GridView.count(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        crossAxisCount: 5,
        children: _buildsActions() + _buildImageCards(context));
  }
}
