import 'dart:developer';

import 'package:camera/camera.dart';
import 'package:flutter_tflite/flutter_tflite.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:permission_handler/permission_handler.dart';

class ScanController extends GetxController{

   @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    initCamera();
    initTFLite();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    cameraController.dispose();
  }

   late CameraController cameraController;
   late List<CameraDescription> cameras;

   //late CameraImage cameraImage;
   var cameraCount = 0;
   var isCameraInitialized = false.obs;

   var x=1,y=1,h=1,w = 5.0;
   var label = "";

   initCamera() async{
      if(await Permission.camera.request().isGranted){
        cameras = await availableCameras();

        cameraController = CameraController(
           cameras[0],
           ResolutionPreset.max,
          imageFormatGroup:  ImageFormatGroup.yuv420
        );

        await cameraController.initialize().then((value){
          cameraController.startImageStream((image){
            cameraCount++;
            if(cameraCount % 10 == 0) {
              cameraCount++;
              objectDetector(image);
            }
            update();
          });


        });
        isCameraInitialized(true);
        update();

      }else{
         print("Permission denied");
      }
   }

   initTFLite() async{
     await Tflite.loadModel(
       model: "assets/model.tflite",
       labels: "assets/labels.txt",
       isAsset:true,
       numThreads: 0,
       useGpuDelegate: true
     );
   }

   bool isInferenceInProgress = false;
   void objectDetector(CameraImage image) async {
     // Perform inference only if the previous inference task has completed
     if (!isInferenceInProgress) {
       isInferenceInProgress = true;

       var detector = await Tflite.runModelOnFrame(
         bytesList: image.planes.map((e) {
           return e.bytes;
         }).toList(),
         asynch: true,
         imageHeight: image.height,
         imageWidth: image.width,
         imageMean: 127.5,
         imageStd: 127.5,
         numResults: 1,
         rotation: 90,
         threshold: 0.4,
       );

       if (detector != null) {
         var ourDetectedObject = detector.first;
         if((detector.first['confidenceInClass'])*100 > 45){
          label = detector.first['detectedClass'].toString();
          h = ourDetectedObject['rect']['h'];
          w = ourDetectedObject['rect']['w'];
          x = ourDetectedObject['rect']['x'];
          y = ourDetectedObject['rect']['y'];
          // update();
         }
         update();

       }

       isInferenceInProgress = false;
     }
   }

}
