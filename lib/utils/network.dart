
import 'package:connectivity/connectivity.dart';

Future<bool> isNetworkOn() async{
  var conn = await(Connectivity().checkConnectivity());
  return conn == ConnectivityResult.none ? false : true;
}