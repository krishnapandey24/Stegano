import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:stegano/utils/download_utils.dart';

import '../utils/appt.dart';
import '../utils/colors.dart';
import '../utils/constants.dart';

class EncodeDownload extends StatelessWidget {
  final bool isWeb;
  final Function(Object) setState;
  final Uint8List fileBytes;

  const EncodeDownload(
      {Key? key,
      required this.isWeb,
      required this.setState,
      required this.fileBytes})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          downloadContainer(),
          const SizedBox(height: 50),
          const Text("Try another: ",style: TextStyle(fontSize: 15,color: Colors.grey)),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: () async {
              final image = await Appt.pickImage();
              if (image == null) {
                // TODO Do something when image is null
                print("Image is null");
              } else {
                setState(image);
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
          const SizedBox(height: 15),
          const Text(
            "Drop files here. 10 MB maximum file size",
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 25),
          // Container(
          //   width: double.maxFinite,
          //   height: 2,
          //   color: kFieldBlack,
          // ),
          const SizedBox(height: 25),
        ],
      );
  }

  downloadContainer() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: isWeb ? (width! * 0.35) : 50),
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: kFieldBlack,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            "Your Image has been successfully encoded!",
            style: TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 20),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white, width: 5),
            ),
            child: Image.memory(
              fileBytes,
              height: 210,
              width: 210,
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(height: 30),
          Center(
            child: ElevatedButton(
              onPressed: () {DownloadUtils.downloadFileForWeb(fileBytes, "encoded_image.jpg");},
              style: ElevatedButton.styleFrom(
                  shape: const StadiumBorder(),
                  backgroundColor: kBlue,
                  padding: const EdgeInsets.all(18)),
              child: const Text(
                "Download",
                style: TextStyle(fontSize: 18),
              ),
            ),
          ),
          const SizedBox(height: 20),
          const Text("Don't forget to download your image. It will be discarded automatically",style: const TextStyle(fontSize: 12,color: Colors.grey),)
        ],
      ),
    );
  }

  
}
