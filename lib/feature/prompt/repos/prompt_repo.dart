import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'package:path_provider/path_provider.dart';
import 'package:dio/dio.dart';

class PromptRepo{
  static Future<File?> generateImage(String prompt) async{
    try{
      String url = "https://api.vyro.ai/v2/image/generations";
      Map<String,dynamic> headers = {
        'Authorization': 'Bearer vk-AF3D92Ez3x7263WmK2FgofrrFNJFnf2RJ0D3fFDsyg2fMF2DG'
      };

      Map<String,dynamic> payload = {
        'prompt': prompt,
        'style': 'realistic',
        'aspect_ratio': '1:1',
        'seed': '1'
      };

      FormData formData = FormData.fromMap(payload);

      Dio dio = Dio();
      dio.options = BaseOptions(
        headers: headers,
        responseType: ResponseType.bytes,
      );
      final response = await dio.post(url, data: formData);
      print(response.data);
      if(response.statusCode == 200){
        print("API Response: ${response.data}");
        Uint8List bytes = response.data as Uint8List; // response.data is raw bytes

        // Save in temporary directory
        final dir = await getTemporaryDirectory();
        final file = File('${dir.path}/generated_image.jpg');
        await file.writeAsBytes(bytes);

        return file;
      }else{
        return null;
      }
    }catch(e){
      log(e.toString());
      return null;
    }
  }
}