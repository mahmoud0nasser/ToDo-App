import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:to_do_app/core/common/commons.dart';
import 'package:to_do_app/core/database/Cache/cache_helper.dart';
import 'package:to_do_app/core/services/service_locator.dart';
import 'package:to_do_app/core/widgets/custom_button.dart';
import 'package:to_do_app/features/auth/data/model/on_boarding_model.dart';
import 'package:to_do_app/features/task/presentation/screens/home_screen/home_screen.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_strings.dart';
import '../../../../../core/widgets/custom_text_button.dart';

class OnBoardingScreens extends StatelessWidget {
  OnBoardingScreens({super.key});

  PageController controller = PageController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // backgroundColor: AppColors.background,
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: PageView.builder(
            controller: controller,
            // itemCount: 3,
            itemCount: OnBoardingModel.onBoardingScreens.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  // Skip Text
                  index != 2
                      ? Align(
                          alignment: Alignment.centerLeft,
                          child: CustomTextButton(
                            text: AppStrings.skip,
                            onPressed: () {
                              controller.jumpToPage(
                                  OnBoardingModel.onBoardingScreens.length - 1);
                            },
                          ),
                          /* child: TextButton(
                            onPressed: () {
                              // controller.jumpToPage(2);
                              controller.jumpToPage(
                                  OnBoardingModel.onBoardingScreens.length - 1);
                            },
                            child: Text(
                              AppStrings.skip,
                              style: Theme.of(context).textTheme.displaySmall,
                              /* style: Theme.of(context).textTheme.displaySmall!.copyWith(
                                color: AppColors.white.withOpacity(.44),
                              ), */
                              // style: Theme.of(context).textTheme.displayLarge,
                              /* style: GoogleFonts.lato(
                                color: AppColors.white.withOpacity(.44),
                                fontSize: 16.0,
                              ), */
                            ),
                          ), */
                        )
                      : SizedBox(
                          height: 54.0,
                        ),
                  SizedBox(
                    height: 16.0,
                  ),
                  // image

                  Image.asset(
                    // AppAssets.on1,
                    OnBoardingModel.onBoardingScreens[index].imgPath,
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  // dots
                  SmoothPageIndicator(
                    controller: controller,
                    // count: 3,
                    count: OnBoardingModel.onBoardingScreens.length,
                    effect: ExpandingDotsEffect(
                      activeDotColor: AppColors.primary,
                      // dotColor: AppColors.red,
                      dotHeight: 8.0,
                      spacing: 8.0,
                    ),
                  ),
                  SizedBox(
                    height: 52.0,
                  ),
                  // title
                  Text(
                    // AppStrings.onBoardingTitleOne,
                    OnBoardingModel.onBoardingScreens[index].title,
                    style: Theme.of(context).textTheme.displayLarge,
                    /* style: GoogleFonts.lato(
                      color: AppColors.white,
                      fontSize: 32.0,
                      fontWeight: FontWeight.bold,
                    ), */
                  ),
                  SizedBox(
                    height: 42.0,
                  ),
                  // sub title
                  Text(
                    // AppStrings.onBoardingSubTitleOne,
                    OnBoardingModel.onBoardingScreens[index].subTitle,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.displayMedium,
                    /* style: GoogleFonts.lato(
                      color: AppColors.white.withOpacity(.44),
                      fontSize: 16.0,
                    ), */
                  ),
                  /* SizedBox(
                    height: 200.0,
                    // height: 100.0,
                  ), */
                  Spacer(),
                  // buttons
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // back Button
                      index != 0
                          ? CustomTextButton(
                              text: AppStrings.back,
                              onPressed: () {
                                controller.previousPage(
                                  duration: Duration(
                                    milliseconds: 500,
                                  ),
                                  curve: Curves.fastLinearToSlowEaseIn,
                                );
                              },
                            )
                          /* ? TextButton(
                              onPressed: () {
                                controller.previousPage(
                                  duration: Duration(
                                    milliseconds: 500,
                                  ),
                                  curve: Curves.fastLinearToSlowEaseIn,
                                );
                              },
                              child: Text(
                                AppStrings.back,
                                style: Theme.of(context).textTheme.displaySmall,
                                /* style: Theme.of(context).textTheme.displaySmall!.copyWith(
                                  color: AppColors.white.withOpacity(.44),
                                ), */
                                /* style: GoogleFonts.lato(
                                  color: AppColors.white.withOpacity(.44),
                                  fontSize: 16.0,
                                ), */
                              ),
                            ) */
                          : Container(),
                      // Spacer
                      Spacer(),
                      // Next Button
                      // index != 2
                      index != OnBoardingModel.onBoardingScreens.length - 1
                          ? CustomButton(
                              text: AppStrings.next,
                              onPressed: () {
                                controller.nextPage(
                                  duration: Duration(
                                    milliseconds: 500,
                                  ),
                                  curve: Curves.fastLinearToSlowEaseIn,
                                );
                              })
                          /* ? ElevatedButton(
                              onPressed: () {
                                controller.nextPage(
                                  duration: Duration(
                                    milliseconds: 500,
                                  ),
                                  curve: Curves.fastLinearToSlowEaseIn,
                                );
                              },
                              style:
                                  Theme.of(context).elevatedButtonTheme.style,
                              /* style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primary,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4.0),
                                ),
                              ), */
                              child: Text(
                                AppStrings.next,
                              ),
                            ) */
                          : CustomButton(
                              text: AppStrings.getStarted,
                              onPressed: () async {
                                // navigate to home Screen
                                // await CacheHelper()
                                sl<CacheHelper>()
                                    .saveData(
                                  key: AppStrings.onBoardingKey,
                                  value: true,
                                )
                                    .then((value) {
                                  navigate(
                                    context: context,
                                    screen: HomeScreen(),
                                  );
                                  /* Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => HomeScreen(),
                                    ),
                                  ); */
                                }).catchError((e) {
                                  print(e.toString());
                                });
                                // });
                              })
                      /* : ElevatedButton(
                              onPressed: () async {
                                // navigate to home Screen
                                // await CacheHelper()
                                sl<CacheHelper>()
                                    .saveData(
                                  key: AppStrings.onBoardingKey,
                                  value: true,
                                )
                                    .then((value) {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => HomeScreen(),
                                    ),
                                  ).catchError((e) {
                                    print(e.toString());
                                  });
                                });

                                /* Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => HomeScreen(),
                                  ),
                                ); */
                              },
                              style:
                                  Theme.of(context).elevatedButtonTheme.style,
                              /* style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primary,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4.0),
                                ),
                              ), */
                              child: Text(
                                // AppStrings.next,
                                AppStrings.getStarted,
                              ),
                            ), */
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
