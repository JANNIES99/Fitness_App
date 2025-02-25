import 'dart:io';

import 'package:fitnessapp/model/userProfile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class ProfileView extends StatefulWidget {
  const ProfileView(
      {required this.userData, required this.addImage, super.key});
  final UserProfile userData;
  final void Function(Uint8List) addImage;

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  Future _pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      File img = File(image.path);
      setState(() {
        widget.userData.image = img.readAsBytesSync();
        widget.addImage(img.readAsBytesSync());
        Navigator.of(context).pop();
      });
    } on PlatformException catch (e) {
      print(e);
      Navigator.of(context).pop();
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Profile",
          style: Theme.of(context).textTheme.headlineLarge,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
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
                                _pickImage(ImageSource.gallery);
                              },
                              child: Text("Gallery"),
                            ),
                            const SizedBox(height: 10),
                            Text("OR"),
                            const SizedBox(height: 10),
                            ElevatedButton(
                              onPressed: () {
                                _pickImage(ImageSource.camera);
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
                      ? const CircleAvatar(
                          backgroundImage: AssetImage("images/default.jpeg"))
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
            ],
          ),
        ),
      ),
    );
  }
}
