import 'package:earn_streak/src/Constants/api_url.dart';
import 'package:earn_streak/src/Model/ArticleModel/article_model.dart';
import 'package:earn_streak/src/Networking/ApiDataHelper/AuthDataHelper/auth_data_helper.dart';
import 'package:earn_streak/src/Networking/ApiService/api_service.dart';

class ArticleHelper {

  getArticle(context)async{
    List<ArticleModel> tempArticleList = [];
    String authToken = await sharedPref.read("authToken");
    try{
      var res = await ApiService.request(context, AppUrls.getArticle, RequestMethods.GET, header: commonHeaderWithToken(authToken));
      if(res != null){
        for(var element in res){
          ArticleModel tempData = ArticleModel.fromJson(element ?? {});
          tempArticleList.add(tempData);
        }
      }
    }
      catch(e){
        print("Get article throw exception $e");
      }
      return tempArticleList;
  }

}