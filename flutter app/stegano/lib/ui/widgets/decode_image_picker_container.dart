import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../utils/appt.dart';
import '../../utils/colors.dart';
import '../../utils/constants.dart';

class DecodeImagePickerContainer extends StatefulWidget {
  final Function(Uint8List image,bool isEncrypted, [String? decryptionKey]) setState;
  final bool isWeb;

  @override
  State<StatefulWidget> createState() => _DecodeImagePickerContainerState();

  const DecodeImagePickerContainer(
      {super.key, required this.setState, required this.isWeb});
}

class _DecodeImagePickerContainerState
    extends State<DecodeImagePickerContainer> {
  bool isEncrypted = false;
  final decryptionKeyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: widget.isWeb ? (width! * (0.29)) : 50),
      child: Column(
        children: [
          const SizedBox(height: 20),
          const Text(
            "Upload your image to decode it",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 50),
          Container(
            padding: const EdgeInsets.all(30),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16), color: kFieldBlack),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 30),
                SvgPicture.asset(
                  "assets/icons/choose_image.svg",
                  height: 100,
                  width: 100,
                  colorFilter: const ColorFilter.mode(
                    Colors.white,
                    BlendMode.srcIn,
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton.icon(
                  onPressed: () async {
                    final image = await Appt.pickImage();
                    if (image == null) {
                      // TODO Do something when image is null
                      print("Image is null");
                    } else {
                      widget.setState(image,isEncrypted,decryptionKeyController.text);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kBlue,
                    shape: const StadiumBorder(),
                    padding: const EdgeInsets.all(16),
                  ),
                  icon: const Icon(
                    Icons.upload,
                    size: 30.0,
                  ),
                  label: const Text(
                    'Upload Image',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  "Drop files here. 10 MB maximum file size",
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 50),
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
                  const SizedBox()
              ],
            ),
          ),
        ],
      ),
    );
  }
}
