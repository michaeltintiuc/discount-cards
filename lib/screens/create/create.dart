import 'dart:async';
import 'dart:io';
import 'dart:ui';
import 'package:path/path.dart';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

import 'package:discount_cards/screens/create/widgets/image_grid.dart';
import 'package:discount_cards/models/discount_card.dart';
import 'package:discount_cards/models/layout_type.dart';
import 'package:discount_cards/utils/index.dart';
import 'package:discount_cards/routes.dart';

class Create extends StatefulWidget {
  @override
  _CreateState createState() => _CreateState();
}

class _CreateState extends State<Create> {
  late TextEditingController _controller;
  late ImagePicker _picker;
  bool _nameIsValid = false;
  bool _isDirty = false;
  bool _firstRender = true;
  List<String> _imagePaths = [];
  final _appDir = getApplicationDocumentsDirectory();

  @override
  void initState() {
    _picker = ImagePicker();
    _controller = TextEditingController();
    _controller.addListener(_validateName);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _validateName() {
    final valid = _controller.text.isNotEmpty;
    setState(() {
      _nameIsValid = valid;
      // initial focus triggers an event too
      _isDirty = _isDirty || valid;
    });
  }

  void _selectFromGallery() async {
    final images =
        await _picker.pickMultiImage(maxWidth: 2000, imageQuality: 80);
    if (images != null) {
      setState(() => _imagePaths.addAll(images.map((image) => image.path)));
    }
  }

  void _takePicture() async {
    final image = await _picker.pickImage(
        source: ImageSource.camera, maxWidth: 2000, imageQuality: 80);
    if (image != null) {
      setState(() => _imagePaths.add(image.path));
    }
  }

  void _removeImage(String path) {
    setState(() {
      _imagePaths = _imagePaths.where((p) => p != path).toList();
    });
  }

  Future<List<String>> _saveNewImages() async {
    return Future.wait<String>(_imagePaths.map((path) async {
      final appDir = (await _appDir).path;
      if (path.contains('/cache/') || !path.contains(appDir)) {
        final imagePath = '$appDir/${basename(path)}';
        await XFile(path).saveTo(imagePath);
        return imagePath;
      }
      return path;
    }));
  }

  Future<Map<LayoutType, String>> _generateThumbnails(
      BuildContext context, String src) async {
    final Map<LayoutType, String> thumbnails = {};
    final List<Future<bool>> completers = [];

    [LayoutType.grid, LayoutType.list].forEach((layout) async {
      final width = layoutThumbnailSize(context, layout);
      final completer = new Completer<bool>();
      completers.add(completer.future);

      Image.file(File(src), width: width, cacheWidth: width.round())
          .image
          .resolve(createLocalImageConfiguration(context))
          .addListener(ImageStreamListener((info, _) async {
        final data = await info.image.toByteData(format: ImageByteFormat.png);
        if (data != null) {
          final file = XFile.fromData(data.buffer.asUint8List());
          final path = '${(await _appDir).path}/${basename(src)}.$layout.thumb';
          await file.saveTo(path);
          completer.complete(true);
          thumbnails[layout] = path;
          return;
        }
        completer.completeError('data is null');
      }));
    });

    await Future.wait(completers);
    return thumbnails;
  }

  Future<int> _create(String name, List<String> images,
          Map<LayoutType, String> thumbnails) =>
      DiscountCard.getBox().add(DiscountCard(name, images, false, thumbnails));

  Future<void> _update(DiscountCard item, String name, List<String> images,
      Map<LayoutType, String> thumbnails) async {
    DiscountCard.getBox()
        .put(item.key, DiscountCard(name, images, item.isFavorite, thumbnails));
    try {
      await item.cleanUp(_imagePaths + thumbnails.values.toList());
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final _args = ModalRoute.of(context)?.settings.arguments as RouteArguments?;

    if (_args != null && _firstRender) {
      WidgetsBinding.instance?.addPostFrameCallback((_) {
        setState(() {
          _imagePaths.addAll(_args.item.images);
          _firstRender = false;
        });
        _controller.value = TextEditingValue(text: _args.item.name);
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(_args?.item.name ?? 'New Discount Card'),
      ),
      body: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.all(10),
        children: [
          TextField(
              controller: _controller,
              decoration: InputDecoration(
                  hintText: 'Discount card name',
                  prefixIcon: const Icon(Icons.credit_card),
                  errorText: _nameIsValid || !_isDirty
                      ? null
                      : 'A discount card must have a name')),
          SizedBox(height: 10),
          ImageGrid(_imagePaths, _selectFromGallery, _takePicture, _removeImage)
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: Text(_args == null ? 'Create' : 'Save'),
        icon: const Icon(Icons.save),
        backgroundColor:
            _nameIsValid && _imagePaths.length > 0 ? Colors.blue : Colors.grey,
        onPressed: () async {
          if (!_nameIsValid || _imagePaths.length < 0) {
            return;
          }

          final images = await _saveNewImages();
          final thumbnails = await _generateThumbnails(context, images[0]);

          if (_args == null) {
            await _create(_controller.text, images, thumbnails);
          } else {
            await _update(_args.item, _controller.text, images, thumbnails);
          }

          Navigator.popUntil(context, ModalRoute.withName('/'));
        },
      ),
    );
  }
}
