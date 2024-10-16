import 'package:earn_streak/src/Constants/app_images.dart';
import 'package:earn_streak/src/Constants/app_strings.dart';
import 'package:earn_streak/src/Model/UiModel/onboarding_model.dart';
import 'package:earn_streak/src/Screens/MainScreen/main_screen.dart';
import 'package:earn_streak/src/Utils/Helper/page_route.dart';
import 'package:flutter/material.dart';

import '../../Networking/ApiDataHelper/AuthDataHelper/auth_data_helper.dart';
import '../../Screens/Auth/login_screen.dart';

class OnBoardingNotifier extends ChangeNotifier{

  int currentPage = 0;
  int numberOfPages = 4;
  var pageController= PageController();

  List<OnBoardingModel> onBoardingList = [];

  addIntroductionMessage(){
    onBoardingList = [
      OnBoardingModel(image:AppImages.onBoardingImage, title: OnBoardingString.welcomeToQuizzit, subTitle: OnBoardingString.enhanceYourReading, subSubTitle: OnBoardingString.diveIntoWorld),
      OnBoardingModel(image:AppImages.onBoardingImage, title: OnBoardingString.howItWorks, subTitle: OnBoardingString.readThroughInformativeContents, subSubTitle: OnBoardingString.completeComprehensionTasks),
      OnBoardingModel(image:AppImages.onBoardingImage, title: OnBoardingString.unlockRewards, subTitle: OnBoardingString.earnPointsAsYouProgress, subSubTitle: OnBoardingString.redeemPointsExciting),
      OnBoardingModel(image:AppImages.onBoardingImage, title: OnBoardingString.startYourJourney, subTitle: OnBoardingString.joinCommunity),
    ];
    notifyListeners();
  }

  onPageChange(int index){
    currentPage = index;
    notifyListeners();
  }

  navigateScreen(context){
    if(currentPage != 4){
      currentPage ++;
      debugPrint("check current page $currentPage");
      notifyListeners();
    }
    if(currentPage == 4){
      sharedPref.save("isOnBoardComplete", true);
      pushReplacement(context,  LoginScreen());
    }
      pageController.animateToPage(currentPage, duration: const Duration(milliseconds: 300), curve: Curves.linear);
  }

  navigateBackScreen(){
    if(currentPage != 0){
      currentPage --;
      notifyListeners();
    }
    pageController.animateToPage(currentPage, duration: const Duration(milliseconds: 300), curve: Curves.linear);
  }

  redirectMainScreen(){

  }

  initState(){
    addIntroductionMessage();
  }

}