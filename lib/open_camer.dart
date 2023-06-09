import 'dart:io';

import 'package:camera_app/functions/db_functions.dart';
import 'package:camera_app/model/data_model.dart';

import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';

class OpenCam extends StatefulWidget {
  const OpenCam({Key? key}) : super(key: key);

  @override
  State<OpenCam> createState() => _OpenCamState();
}

class _OpenCamState extends State<OpenCam> {
  @override
  void initState() {
    getAllImages();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Camera App'),
        centerTitle: true,
        
      ),
      body: Column(
        children: [
          ValueListenableBuilder(
            valueListenable: imageListNotifier,
            builder: (BuildContext context, List<ImageModel> imageList,
                Widget? child) {
              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: imageList.isEmpty
                      ? const Center(
                          child: Text(
                            'No Image',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 30,
                            ),
                          ),
                        )
                      : GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  crossAxisSpacing: 3,
                                  mainAxisSpacing: 3),
                          itemCount: imageList.length,
                          itemBuilder: (cotex, index) {
                            return InkWell(
                              child: Image.file(
                                File(
                                  imageList[index].image,
                                ),
                                fit: BoxFit.fill,
                              ),
                              
                            );
                          },
                        ),
                ),
              );
            },
          ),
          const Spacer(),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(10),
        child: FloatingActionButton.extended(
          onPressed: () {
            openCamera();
          },
          label: const Text('Camera'),
          icon: const Icon(Icons.camera),
        ),
      ),
    );
  }

  File? _image;

  void openCamera() async {
    final image = await ImagePicker().pickImage(source: ImageSource.camera);
    if (image == null) {
      return;
    } else {
      final imageTemp = File(image.path);
      setState(() {
        _image = imageTemp;
      });
    }
    final camera = ImageModel(
      image: _image!.path,
    );
    await getImage(
      camera,
    );
  }
}
