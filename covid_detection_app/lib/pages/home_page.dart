import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pytorch_mobile/pytorch_mobile.dart';
import 'package:pytorch_mobile/model.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Model? _imageModel;
  String? _imagePrediction;
  File? _image;
  ImagePicker _picker = ImagePicker();
  File? pickedImage;
  bool _loading = false;
  PickedFile? tempImage;

  @override
  void initState() {
    super.initState();
    _loading = true;
    loadModel().then((value) {
      setState(() {
        _loading = false;
      });
    });
  }

  //load covid Resnet18 modified model
  Future loadModel() async {
    String pathImageModel = "assets/models/covid_model.pt";
    try {
      _imageModel = await PyTorchMobile.loadModel(pathImageModel);
    } on PlatformException {
      print("only supported for android and ios so far");
    }
  }

  //run an image model
  Future runImageModel() async {
    //pick a random image
    final PickedFile? image =
        await _picker.getImage(source: ImageSource.gallery);
    //get prediction
    //labels are 1000 random english words for show purposes
    _imagePrediction = await _imageModel!.getImagePrediction(
        File(image!.path), 224, 224, "assets/labels/labels.csv");
    setState(() {
      _image = File(image.path);
    });
  }

  Future loadImageFromGallery() async {
    //pick an image from the user gallery
    tempImage = await _picker.getImage(source: ImageSource.gallery);

    if (tempImage == null) return null;
    setState(() {
      _loading = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'COVID-19 CHEST-XRAY DETECTION',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          elevation: 0,
          backgroundColor: Color(0xFF2898D8),
        ),
        body: Container(
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _loading
                  ? Container(
                      margin: EdgeInsets.all(30),
                      child: CircularProgressIndicator(),
                    )
                  : Container(
                      margin: EdgeInsets.all(20),
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          //_image == null ? Text('No image selected.') : Image.file(_image!),
                          Center(
                            child: Container(
                              padding: const EdgeInsets.only(
                                  bottom: 20, top: 15, left: 20, right: 20),
                              decoration: BoxDecoration(
                                color: Color(0xFFCDE1EC),
                                borderRadius: BorderRadius.circular(25),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Stack(
                                    alignment: Alignment.bottomLeft,
                                    children: [
                                      _image == null
                                          ? Image.asset(
                                              "assets/images/no_image.png")
                                          : Image.file(_image!,
                                              fit: BoxFit.cover),
                                    ],
                                  ),
                                  Container(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: Text(
                                      "Image Detection Result:",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 19,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Container(
                                      height: 40,
                                      width: 160,
                                      padding: EdgeInsets.only(
                                          top: 10,
                                          left: 5,
                                          bottom: 10,
                                          right: 5),
                                      decoration: BoxDecoration(
                                        color: Color(0xFF2898D8),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: _imagePrediction != null
                                          ? Text(
                                              "$_imagePrediction".toUpperCase(),
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            )
                                          : Text(
                                              "NO IMAGE",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Color(0xFF2898D8),
          onPressed: runImageModel,
          child: Icon(
            Icons.photo_album,
          ),
        ),
      ),
    );
  }
}
