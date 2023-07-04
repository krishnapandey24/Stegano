import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:stegano/ui/widgets/image_picker_container.dart';
import 'package:stegano/ui/widgets/nav_bar.dart';
import 'package:path_provider/path_provider.dart';
import '../utils/appt.dart';
import '../utils/colors.dart';
import '../utils/constants.dart';

class DecodeImage extends StatefulWidget {
  const DecodeImage({Key? key}) : super(key: key);

  @override
  State<DecodeImage> createState() => _DecodeImageState();
}

class _DecodeImageState extends State<DecodeImage> {
  File? pickedImage;
  Uint8List webImage = Uint8List(8);
  bool imageSelected = true;
  final encryptionKeyController = TextEditingController();
  bool messageIsEncrypted = false;
  bool imageEncoded = false;
  Uint8List? encodedTextFileBytes;
  String decodedText = subDescription * 10;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const NavBar(index: 8),
            ScreenTypeLayout.builder(
              desktop: (BuildContext context) => mainContainer(true),
              mobile: (BuildContext context) => mainContainer(false),
            )
          ],
        ),
      ),
    );
  }

  mainContainer(bool isWeb) {
    return imageSelected
        ? imageSelectedLayout(isWeb)
        : ImagePickerContainer(
            setState: setImage,
            isWeb: isWeb,
            forEncoding: false,
          );
  }

  void setImage(Object image) {
    if (kIsWeb) {
      Uint8List imageBytes = image as Uint8List;
      if (imageBytes.length > maxImageFileSize) {
        Appt.fileSizeOverflowDialog(context);
        return;
      }
      webImage = imageBytes;
    } else {
      if (pickedImage!.lengthSync() > maxImageFileSize) {
        Appt.fileSizeOverflowDialog(context);
        return;
      }
      pickedImage = image as File?;
    }
    setState(() {
      imageSelected = true;
      imageEncoded = false;
      encodedTextFileBytes = null;
    });
  }

  imageSelectedLayout(bool isWeb) {
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: isWeb ? (width! * 0.1) : 10, vertical: 40),
      child: Wrap(
        alignment: WrapAlignment.start,
        runSpacing: 50,
        children: getMainRowWidgets(isWeb),
      ),
    );
  }

  List<Widget> getMainRowWidgets(bool isWeb) {
    List<Widget> widgets = [
      isWeb ? buildImageColumn(isWeb) : buildTextColumn(isWeb),
      const SizedBox(width: 200),
      isWeb ? buildTextColumn(isWeb) : buildImageColumn(isWeb),
    ];
    return widgets;
  }

  Column buildImageColumn(bool isWeb) {
    Widget imageContainer = Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white, width: 5),
      ),
      child: kIsWeb
          ? Image.asset(
              "assets/images/16b.png",
              height: 300,
              width: 300,
              fit: BoxFit.contain,
            )
          : Image.file(
              pickedImage!,
              height: 300,
              width: 300,
              fit: BoxFit.fill,
            ),
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Selected image: ",
          style: TextStyle(fontSize: 18),
        ),
        const SizedBox(height: 20),
        isWeb ? imageContainer : Center(child: imageContainer),
        const SizedBox(height: 20),
        OutlinedButton(
          onPressed: () async {
            final image = await Appt.pickImage();
            if (image == null) {
              print("Image is null");
            } else {
              setImage(image);
            }
          },
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.all(17.7),
            shape: const StadiumBorder(),
            side: const BorderSide(color: kBlue),
          ),
          child: const Text(
            "Change Image",
            style: TextStyle(fontSize: 17.7, color: kBlue),
          ),
        )
      ],
    );
  }

  Column buildTextColumn(bool isWeb) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          " Decoded message: ",
          style: TextStyle(fontSize: 18),
        ),
        const SizedBox(height: 20),
        Stack(
          children: [
            Container(
              width: 500,
              height: 300,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.white,
                  width: 2.0,
                ),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: SingleChildScrollView(
                child: SelectableText(
                  decodedText,
                ),
              ),
            ),
            Positioned(
              bottom: 15,
              right: 15,
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () {
                    Clipboard.setData(ClipboardData(text: decodedText));
                    Appt.toast("Text copied successfully!",context);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey.withOpacity(0.5),
                    ),
                    child: const Icon(
                      Icons.paste,
                      color: Colors.white,
                      size: 23,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
        const SizedBox(height: 20),
        ElevatedButton.icon(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: kBlue,
            shape: const StadiumBorder(),
            padding: const EdgeInsets.all(16),
          ),
          icon: const Icon(
            Icons.download,
            size: 30.0,
          ),
          label: const Text(
            'Download as text file',
            style: TextStyle(fontSize: 20),
          ),
        ),
      ],
    );
  }

}
