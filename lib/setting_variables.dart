import 'dart:async';
import 'dart:convert';
import 'dart:io' as io;
import 'package:path_provider/path_provider.dart';
import 'Globals.dart' as globals;

class setting_variables{
  static io.Directory _externalDocumentsDirectory;
  bool lightmode,darkmode;

  setting_variables(bool lightmode,bool darkmode){
    this.lightmode = lightmode;
    this.darkmode = darkmode;
  }
  static Future<String> _requestExternalStorageDirectory() async{
    _externalDocumentsDirectory = await getExternalStorageDirectory();
    return _externalDocumentsDirectory.path;
  }
  static Future<io.File>  localFile() async{
    final path = await _requestExternalStorageDirectory();
    return io.File('$path/settings.cfg');
  }
  static Future<io.File> defaultConfigWriter() async{
    final file = await localFile();
    return file.writeAsString(new globals.MyGlobals().toString());
  }
  static Future<setting_variables> configReader() async {
    int i = 0;
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
        arr.insert(i, l == 'true' ? true : false);
        i++;
      });
      globals.MyGlobals.islightmode = arr[0];
      globals.MyGlobals.isdarkmode = arr[1];
      return new setting_variables(arr[0], arr[1]);
    }
  }

}