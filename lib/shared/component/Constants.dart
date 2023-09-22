import 'package:shop_app/modules/login/login.dart';
import 'package:shop_app/shared/component/Components.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';


void signOut(context){
  CacheHelper.removeData(key: 'token').then((value) {
    if(value){
      NavigateAndFinish(context, const ShopLoginScreen());
    }
  });
}

void printFullText(String? text){
  final pattern = RegExp('.{1,800}');
  pattern.allMatches(text!).forEach((match)=> print(match.group(0)));
}

String token = '';