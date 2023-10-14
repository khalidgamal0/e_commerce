import 'package:flutter/material.dart';
import 'package:shop_app/constant.dart';
import 'package:shop_app/custom_component/custom_text_button.dart';
import 'package:shop_app/custom_component/navigator_push_remove_until.dart';
import 'package:shop_app/helper/shared_preferences.dart';
import 'package:shop_app/models/on_boarding_model.dart';
import 'package:shop_app/views/login_view.dart';
import 'package:shop_app/views/widgets/on_boarding_item.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingView extends StatefulWidget {
  const OnBoardingView({Key? key}) : super(key: key);

  @override
  State<OnBoardingView> createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {
  bool isLast = false;
  PageController? pageController = PageController();

  void submit() {
    CacheHelper.saveData(
      key: 'onBoarding',
      value: true,
    ).then((value) {
      if (value == true) {
        navigatorAndFinish(const LoginView(), context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          CustomTextButton(
            text: 'Skip',
            onPressed: () {
              submit();
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                onPageChanged: (value) {
                  if (value == OnBoardingModel.boarding.length - 1) {
                    setState(() {
                      isLast = true;
                    });
                  } else {
                    setState(() {
                      isLast = false;
                    });
                  }
                },
                controller: pageController,
                physics: const BouncingScrollPhysics(),
                itemCount: OnBoardingModel.boarding.length,
                itemBuilder: (context, index) {
                  return OnBoardingItem(
                    boardingItem: OnBoardingModel.boarding[index],
                  );
                },
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: pageController!,
                  count: OnBoardingModel.boarding.length,
                  effect: const ExpandingDotsEffect(
                    dotColor: Colors.grey,
                    dotHeight: 6,
                    dotWidth: 10,
                    spacing: 6,
                    activeDotColor: kPrimaryColor,
                  ),
                ),
                const Spacer(),
                FloatingActionButton(
                  elevation: 0,
                  onPressed: () {
                    if (isLast) {
                      submit();
                    } else {
                      pageController!.nextPage(
                          duration: const Duration(milliseconds: 700),
                          curve: Curves.fastLinearToSlowEaseIn);
                    }
                  },
                  child: const Icon(Icons.arrow_forward_ios_outlined),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
