import 'dart:async';
import 'dart:convert';
import 'dart:io' as io;
import 'package:path_provider/path_provider.dart';
import 'Globals.dart' as globals;

class session_token{
  static io.Directory _externalDocumentsDirectory;
  String api_token;
  session_token(String api_token){
    this.api_token = api_token;
  }
  static Future<String> _requestExternalStorageDirectory() async{
    _externalDocumentsDirectory = await getExternalStorageDirectory();
    return _externalDocumentsDirectory.path;
  }
  static Future<io.File> defaultSessionWriter() async{
    final file = await localFile();
    return file.writeAsString(globals.MyGlobals.api_token);
  }
  static Future<session_token> SessionReader() async {
    var arr = [];
    var file = await localFile();
    var path = file.path;
    if(!io.File(path).existsSync()){
      return null;
    }else{
      await new io.File(path)
          .openRead()
          .map(utf8.decode)
          .transform(new LineSplitter())
          .forEach((l) {
        arr.add(l);
      });
      globals.MyGlobals.api_token = arr[0];
      return new session_token(arr[0]);
    }

  }
  static Future<io.File>  localFile() async{
    final path = await _requestExternalStorageDirectory();
    return io.File('$path/session.text');
  }
}