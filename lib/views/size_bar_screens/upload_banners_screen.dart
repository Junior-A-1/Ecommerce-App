import 'package:app_web/views/size_bar_screens/widgets/banner_widget.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:app_web/controllers/banner_controller.dart';

class UploadBannersScreen extends StatefulWidget {
  static const String id = '\banners-screen';
  const UploadBannersScreen({super.key});

  @override
  State<UploadBannersScreen> createState() => _UploadBannersScreenState();
}

class _UploadBannersScreenState extends State<UploadBannersScreen> {
  final BannerController _bannerController = BannerController();
  dynamic _image;
  pickImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: false,
    );

    if (result != null) {
      print("File picked: ${result.files.first.name}");
      setState(() {
        _image = result.files.first.bytes;
      });
    } else {
      print("No file picked.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            alignment: Alignment.topLeft,
            child: const Text(
              "Banner",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 36),
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Divider(
            color: Colors.grey,
          ),
        ),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(5),
                ),
                height: 150,
                width: 150,
                child: _image != null
                    ? Image.memory(
                        _image!,
                        fit: BoxFit.cover,
                      )
                    : const Center(
                        child: Text('Upload Banner'),
                      ),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
              onPressed: () async {
                await _bannerController.uploadBanner(
                    pickedImage: _image, context: context);
              },
              child: const Text(
                'save',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            onPressed: () {
              pickImage();
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
            child: const Text(
              'Upload picture',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Divider(
            color: Colors.grey,
          ),
        ),
        BannerWidget(),
      ],
    );
  }
}
