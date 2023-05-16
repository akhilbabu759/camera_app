import 'package:camera_app/model/data_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/hive_flutter.dart';

ValueNotifier<List<ImageModel>> imageListNotifier = ValueNotifier([]);

Future<void> getImage(ImageModel vlaue) async {
  final imageDB = await Hive.openBox<ImageModel>('image_db');
  await imageDB.add(vlaue);
  imageListNotifier.value.add(vlaue);
  // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
  imageListNotifier.notifyListeners();
}

Future<void> createDB() async {
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(
    ImageModelAdapter().typeId,
  )) {
    Hive.registerAdapter(
      ImageModelAdapter(),
    );
  }
}

Future<void> getAllImages() async {
  final imageDB = await Hive.openBox<ImageModel>('image_db');
  imageListNotifier.value.clear();
  imageListNotifier.value.addAll(imageDB.values);
  // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
  imageListNotifier.notifyListeners();
}


