import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../utils/appt.dart';
import '../../utils/colors.dart';
import '../../utils/constants.dart';

class ImagePickerContainer extends StatelessWidget {
  final Function(Object image) setState;
  final bool isWeb;
  final bool forEncoding;

  const ImagePickerContainer(
      {super.key, required this.setState, required this.isWeb, required this.forEncoding});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: isWeb ? (width! * (forEncoding ? 0.32 : 0.29)) : 50),
      child: Column(
        children: [
          const SizedBox(height: 20),
          Text(
            "Upload your image to ${forEncoding ? "hide text in it": "decode it"}",
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
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
                  onPressed: () async{
                    final image= await Appt.pickImage();
                    if(image==null){
                      // TODO Do something when image is null
                      print("Image is null");
                    }else{
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
                const SizedBox(height: 20),
                const Text(
                  "Drop files here. 10 MB maximum file size",
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 50),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
