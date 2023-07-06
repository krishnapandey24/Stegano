import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:stegano/ui/encode_download.dart';
import 'package:stegano/ui/widgets/image_picker_container.dart';
import 'package:stegano/ui/widgets/nav_bar.dart';
import 'dart:io';


import '../network/api_service.dart';
import '../utils/appt.dart';
import '../utils/colors.dart';
import '../utils/constants.dart';

class EncodeImage extends StatefulWidget {
  const EncodeImage({Key? key}) : super(key: key);

  @override
  State<EncodeImage> createState() => _EncodeImageState();
}

class _EncodeImageState extends State<EncodeImage> {
  File? pickedImage;
  Uint8List webImage = Uint8List(8);
  bool imageSelected = false;
  final textController = TextEditingController();
  final encryptionKeyController = TextEditingController();
  bool encryptMessage = false;
  bool imageEncoded= false;
  Uint8List? encodedImageBytes;
  final API api = API();


  @override
  void dispose() {
    super.dispose();
    textController.dispose();
    encryptionKeyController.dispose();
  }

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
    if(imageEncoded){
      return EncodeDownload(isWeb: isWeb, setState: setImage, fileBytes: encodedImageBytes!);
    }else{
      return imageSelected
          ? imageSelectedLayout(isWeb)
          : ImagePickerContainer(
        setState: setImage,
        isWeb: isWeb,
        forEncoding: true,
      );
    }

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
      imageEncoded=false;
      encodedImageBytes=null;
    });
  }

  imageSelectedLayout(bool isWeb) {
    Widget imageContainer = Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white, width: 5),
      ),
      child: kIsWeb
          ? Image.memory(
              webImage,
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

    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: isWeb ? (width! * 0.1) : 10, vertical: 40),
      child: Wrap(
        alignment: WrapAlignment.start,
        runSpacing: 50,
        children: [
          buildTextColumn(isWeb),
          const SizedBox(width: 200),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Selected image: ",
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 20),
              isWeb
                  ? imageContainer
                  : Center(
                      child: imageContainer,
                    ),
            ],
          ),
        ],
      ),
    );
  }

  Column buildTextColumn(bool isWeb) {
    Row buttonRow = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        ElevatedButton(
          onPressed: () async {
            print("start");
            encodedImageBytes = await api.encodeImageForWeb(webImage, textController.text, false);
            setState(() {
              imageEncoded=true;
            });
          },
          style: ElevatedButton.styleFrom(
              shape: const StadiumBorder(),
              backgroundColor: kBlue,
              padding: const EdgeInsets.all(18)),
          child: const Text(
            "Encode Image",
            style: TextStyle(fontSize: 18),
          ),
        ),
        const SizedBox(width: 25),
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

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          " Encode message: ",
          style: TextStyle(fontSize: 18),
        ),
        const SizedBox(height: 20),
        SizedBox(
          width: 500,
          height: 200,
          child: TextFormField(
            controller: textController,
            maxLength: 50,
            maxLines: 10,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.black,
              hintText: "Enter text you want to hide here",
              hintStyle: TextStyle(color: Colors.grey.shade500),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: kBlue),
                borderRadius: BorderRadius.circular(10.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.white),
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter a text';
              }
              return null;
            },
          ),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Encrypt Text: ",
              style: TextStyle(fontSize: 15),
            ),
            Switch(
              value: encryptMessage,
              inactiveTrackColor: Colors.grey.shade900,
              onChanged: (value) => setState(
                () => encryptMessage = value,
              ),
            ),
          ],
        ),
        ...(encryptMessage ? encryption() : [const SizedBox()]),
        const SizedBox(height: 20),
        isWeb ? buttonRow : Center(child: buttonRow),
      ],
    );
  }

  List<Widget> encryption() {
    return [
      const SizedBox(height: 20),
      const Text(
        "Encryption key:",
        style: TextStyle(fontSize: 18),
      ),
      const SizedBox(height: 20),
      SizedBox(
        width: 500,
        child: TextFormField(
          controller: encryptionKeyController,
          maxLength: 128,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.black,
            hintText: "enter a strong encryption key",
            hintStyle: TextStyle(color: Colors.grey.shade500),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: kBlue),
              borderRadius: BorderRadius.circular(10.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          validator: (value) {
            if (value!.isEmpty) {
              return 'Please enter a text';
            }
            return null;
          },
        ),
      ),
    ];
  }
}
