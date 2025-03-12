import 'package:flutter/material.dart';
import 'dart:io';
import 'package:fitnessapp/model/userProfile.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class ProfileSection extends StatefulWidget {
  const ProfileSection(
      {required this.userData,
      required this.addImage,
      required this.logOut,
      super.key});
  final UserProfile userData;
  final void Function(Uint8List) addImage;
  final void Function() logOut;

  @override
  State<ProfileSection> createState() => _ProfileSectionState();
}

class _ProfileSectionState extends State<ProfileSection> {
  late String defaultImage =
      widget.userData.gender == "Male" ? "images/u1.png" : "images/u2.png";
  Future _pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      File img = File(image.path);
      setState(() {
        widget.userData.image = img.readAsBytesSync();
        widget.addImage(img.readAsBytesSync());
      });
    } on PlatformException catch (e) {
      print(e);
      return;
    }
  }

  Future _galleryImage() async {
    Navigator.of(context).pop();
    var status = await Permission.storage.status;
    if (status.isGranted) {
      _pickImage(ImageSource.gallery);
    } else {
      requestStorageAccess();
    }
  }

  void requestStorageAccess() async {
    var status = await Permission.photos.request();
    if (status.isGranted) {
      _pickImage(ImageSource.gallery);
    } else if (status.isDenied) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        duration: Duration(seconds: 3),
        margin: EdgeInsets.all(10),
        content: Text("Gallery access denied"),
        behavior: SnackBarBehavior.floating,
      ));
    } else if (status.isPermanentlyDenied) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        duration: Duration(seconds: 3),
        margin: EdgeInsets.all(10),
        content: Text("Gallery access Permanently denied"),
        behavior: SnackBarBehavior.floating,
      ));
    }
  }

  Future _cameraImage() async {
    Navigator.of(context).pop();
    var status = await Permission.camera.status;
    if (status.isGranted) {
      _pickImage(ImageSource.camera);
    } else {
      requestStorageAccess();
    }
  }

  void requestCameraAccess() async {
    var status = await Permission.camera.request();
    if (status.isGranted) {
      _pickImage(ImageSource.camera);
    } else if (status.isDenied) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        duration: Duration(seconds: 3),
        margin: EdgeInsets.all(10),
        content: Text("Camera access denied"),
        behavior: SnackBarBehavior.floating,
      ));
    } else if (status.isPermanentlyDenied) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        duration: Duration(seconds: 3),
        margin: EdgeInsets.all(10),
        content: Text("Camera access Permanently denied"),
        behavior: SnackBarBehavior.floating,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () async {
                Permission.camera.request();
                Permission.photos.request();
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  useSafeArea: true,
                  builder: (BuildContext ctx) {
                    return SizedBox(
                      width: double.infinity,
                      height: 200,
                      child: Column(
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              _galleryImage();
                            },
                            child: Text("Gallery"),
                          ),
                          const SizedBox(height: 10),
                          Text("OR"),
                          const SizedBox(height: 10),
                          ElevatedButton(
                            onPressed: () {
                              _cameraImage();
                            },
                            child: Text("Use Camera"),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
              child: Container(
                width: 200,
                height: 200,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey,
                ),
                child: widget.userData.image == null
                    ? CircleAvatar(backgroundImage: AssetImage(defaultImage))
                    : CircleAvatar(
                        backgroundImage: MemoryImage(widget.userData.image!),
                      ),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "Name",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 10),
            Text(
              "${widget.userData.firstName} ${widget.userData.lastName}",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 10),
            Text(
              "Date of Birth",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 10),
            Text(
              widget.userData.formateedDate,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 10),
            Text(
              "Height",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 10),
            Text(
              "${widget.userData.height} Meters",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 10),
            Text(
              "Weight",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 10),
            Text(
              "${widget.userData.weight} KG",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => widget.logOut(),
              child: Text(
                "Log Out",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
