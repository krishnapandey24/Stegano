import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:stegano/ui/widgets/decode_image_picker_container.dart';
import 'package:stegano/ui/widgets/nav_bar.dart';
import 'package:stegano/utils/download_utils.dart';
import '../model/decode_response.dart';
import '../network/api_service.dart';
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
  bool imageSelected = false;
  bool imageDecoded = false;
  Uint8List? decodedTextFileBytes;
  String decodedText = subDescription * 10;
  API api = API();
  bool isEncrypted = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final decryptionKeyController = TextEditingController();

  @override
  void initState() async {
    super.initState();
    bool userLoggedIn = await Appt.isLoggedIn();
    if (!userLoggedIn && mounted) {
      Navigator.pushReplacementNamed(context, '/signup');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            NavBar(
                index: 8,
                atHome: false,
                openDrawer: () {
                  _scaffoldKey.currentState?.openDrawer(); // Open the drawer
                }),
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
        : DecodeImagePickerContainer(
            setState: setImage,
            isWeb: isWeb,
          );
  }

  void setImage(Uint8List imageBytes) async {
    if (imageBytes.length > maxImageFileSize) {
      Appt.fileSizeOverflowDialog(context);
      return;
    }
    webImage = imageBytes;

    setState(() {
      imageSelected = true;
      imageDecoded = false;
    });
  }

  imageSelectedLayout(bool isWeb) {
    return imageDecoded
        ? imageDecodedContainer(isWeb)
        : imageSelectedContainer(isWeb);
  }

  imageSelectedContainer(bool isWeb) {
    return Column(
      children: [
        Container(
          margin:
              EdgeInsets.symmetric(horizontal: isWeb ? (width! * 0.35) : 50),
          padding: const EdgeInsets.all(30),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: kFieldBlack,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 5),
                ),
                child: Image.memory(
                  webImage,
                  height: 210,
                  width: 210,
                  fit: BoxFit.contain,
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "Decrypt text",
                    style: TextStyle(fontSize: 15),
                  ),
                  Switch(
                    value: isEncrypted,
                    inactiveTrackColor: Colors.grey.shade900,
                    onChanged: (value) => setState(
                      () => isEncrypted = value,
                    ),
                  ),
                ],
              ),
              if (isEncrypted) ...[
                const SizedBox(height: 5),
                TextFormField(
                  controller: decryptionKeyController,
                  maxLength: 128,
                  minLines: 1,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.black,
                    counterText: '',
                    hintText: "enter the key you used to encrypt the text",
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
              ] else
                const SizedBox(),
              const SizedBox(height: 30),
              Center(
                child: ElevatedButton(
                  onPressed: () async {
                    try {
                      Appt.showLoading(context, "Decoding your image...");
                      DecodeResponse decodeResponse = await api.decodeImage(
                          webImage, isEncrypted, decryptionKeyController.text);
                      setState(() {
                        imageDecoded = true;
                        decodedText = decodeResponse.data;
                        decodedTextFileBytes = decodeResponse.byteData;
                      });
                    } catch (e) {
                      Appt.showAlertDialog(
                          context, "Something went wrong \n Please try again");
                    }
                    if (mounted) Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                      shape: const StadiumBorder(),
                      backgroundColor: kBlue,
                      padding: const EdgeInsets.all(18)),
                  child: const Text(
                    "Decode Image",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "Don't forget to download your image. It will be discarded automatically",
                style: TextStyle(fontSize: 12, color: Colors.grey),
              )
            ],
          ),
        ),
        const SizedBox(height: 20),
        OutlinedButton(
          onPressed: () => setState(() {
            imageSelected = false;
            webImage = Uint8List(8);
            isEncrypted = false;
            decryptionKeyController.clear();
          }),
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

  Container imageDecodedContainer(bool isWeb) {
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
                    Appt.toast("Text copied successfully!", context);
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
          onPressed: () {
            DownloadUtils.downloadFileForWeb(
                decodedTextFileBytes!, "decoded_text.txt");
          },
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
