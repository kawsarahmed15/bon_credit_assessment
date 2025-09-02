import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../domain/controllers/localization_controller.dart';

class LanguageSelectionScreen extends StatelessWidget {
  final LocalizationController controller = Get.find<LocalizationController>();

  LanguageSelectionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(controller.getTranslation('language_region')),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.black, Colors.grey[800]!],
          ),
        ),
        child: Column(
          children: [
            // Current Language Display
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(12.w),
              child: Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.r),
                ),
                color: Colors.grey[800],
                child: Padding(
                  padding: EdgeInsets.all(12.w),
                  child: Column(
                    children: [
                      Icon(Icons.language, size: 48.sp, color: Colors.white),
                      SizedBox(height: 16.h),
                      Text(
                        'Current Language',
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: Colors.white70,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Obx(
                        () => Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              controller.getLanguageFlag(
                                controller.currentLanguage.value,
                              ),
                              style: TextStyle(fontSize: 24.sp),
                            ),
                            SizedBox(width: 12.w),
                            Text(
                              controller.getLanguageName(
                                controller.currentLanguage.value,
                              ),
                              style: TextStyle(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Obx(
                        () => Text(
                          'Currency: ${controller.getCurrencySymbol()} ${controller.currentCurrency.value}',
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.white70,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Language Selection List
            Expanded(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 12.w),
                child: Card(
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.r),
                  ),
                  color: Colors.grey[800],
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(12.w),
                        child: Row(
                          children: [
                            Icon(Icons.translate, color: Colors.white),
                            SizedBox(width: 12.w),
                            Text(
                              'Select Language',
                              style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(height: 1),
                      Expanded(
                        child: ListView.builder(
                          itemCount: controller.supportedLanguages.length,
                          itemBuilder: (context, index) {
                            final language =
                                controller.supportedLanguages[index];
                            final languageCode = language['code']!;
                            final languageName = language['name']!;
                            final languageFlag = language['flag']!;

                            return Obx(
                              () => ListTile(
                                leading: Container(
                                  width: 40.w,
                                  height: 40.h,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color:
                                        controller.currentLanguage.value ==
                                                languageCode
                                            ? Colors.blue.withOpacity(0.2)
                                            : Colors.transparent,
                                  ),
                                  child: Center(
                                    child: Text(
                                      languageFlag,
                                      style: TextStyle(fontSize: 20.sp),
                                    ),
                                  ),
                                ),
                                title: Text(
                                  languageName,
                                  style: TextStyle(
                                    fontWeight:
                                        controller.currentLanguage.value ==
                                                languageCode
                                            ? FontWeight.bold
                                            : FontWeight.normal,
                                    color:
                                        controller.currentLanguage.value ==
                                                languageCode
                                            ? Colors.white
                                            : Colors.white70,
                                  ),
                                ),
                                subtitle: Text(
                                  languageCode.toUpperCase(),
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 12.sp,
                                  ),
                                ),
                                trailing:
                                    controller.currentLanguage.value ==
                                            languageCode
                                        ? Icon(
                                          Icons.check_circle,
                                          color: Colors.blue,
                                        )
                                        : Icon(
                                          Icons.circle_outlined,
                                          color: Colors.white70,
                                        ),
                                onTap:
                                    () => _showCountrySelection(
                                      context,
                                      languageCode,
                                      languageName,
                                    ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }

  void _showCountrySelection(
    BuildContext context,
    String languageCode,
    String languageName,
  ) {
    // Country/region mappings for each language
    final Map<String, List<Map<String, String>>> languageRegions = {
      'en': [
        {'code': 'US', 'name': 'United States', 'flag': '🇺🇸'},
        {'code': 'GB', 'name': 'United Kingdom', 'flag': '🇬🇧'},
        {'code': 'CA', 'name': 'Canada', 'flag': '🇨🇦'},
        {'code': 'AU', 'name': 'Australia', 'flag': '🇦🇺'},
      ],
      'es': [
        {'code': 'ES', 'name': 'Spain', 'flag': '🇪🇸'},
        {'code': 'MX', 'name': 'Mexico', 'flag': '🇲🇽'},
        {'code': 'AR', 'name': 'Argentina', 'flag': '🇦🇷'},
        {'code': 'CO', 'name': 'Colombia', 'flag': '🇨🇴'},
      ],
      'fr': [
        {'code': 'FR', 'name': 'France', 'flag': '🇫🇷'},
        {'code': 'CA', 'name': 'Canada', 'flag': '🇨🇦'},
        {'code': 'BE', 'name': 'Belgium', 'flag': '🇧🇪'},
        {'code': 'CH', 'name': 'Switzerland', 'flag': '🇨🇭'},
      ],
      'de': [
        {'code': 'DE', 'name': 'Germany', 'flag': '🇩🇪'},
        {'code': 'AT', 'name': 'Austria', 'flag': '🇦🇹'},
        {'code': 'CH', 'name': 'Switzerland', 'flag': '🇨🇭'},
      ],
      'it': [
        {'code': 'IT', 'name': 'Italy', 'flag': '🇮🇹'},
        {'code': 'CH', 'name': 'Switzerland', 'flag': '🇨🇭'},
      ],
      'pt': [
        {'code': 'BR', 'name': 'Brazil', 'flag': '🇧🇷'},
        {'code': 'PT', 'name': 'Portugal', 'flag': '🇵🇹'},
      ],
      'zh': [
        {'code': 'CN', 'name': 'China', 'flag': '🇨🇳'},
        {'code': 'TW', 'name': 'Taiwan', 'flag': '🇹🇼'},
        {'code': 'HK', 'name': 'Hong Kong', 'flag': '🇭🇰'},
      ],
      'ja': [
        {'code': 'JP', 'name': 'Japan', 'flag': '🇯🇵'},
      ],
      'ko': [
        {'code': 'KR', 'name': 'South Korea', 'flag': '🇰🇷'},
      ],
      'ar': [
        {'code': 'SA', 'name': 'Saudi Arabia', 'flag': '🇸🇦'},
        {'code': 'AE', 'name': 'UAE', 'flag': '🇦🇪'},
        {'code': 'EG', 'name': 'Egypt', 'flag': '🇪🇬'},
      ],
    };

    final regions =
        languageRegions[languageCode] ??
        [
          {'code': 'US', 'name': 'Default', 'flag': '🌐'},
        ];

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder:
          (context) => Container(
            decoration: BoxDecoration(
              color: Colors.grey[800],
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: EdgeInsets.all(20),
                  child: Row(
                    children: [
                      Icon(Icons.public, color: Colors.white),
                      SizedBox(width: 12.w),
                      Text(
                        'Select Region for $languageName',
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(height: 1),
                Container(
                  constraints: BoxConstraints(maxHeight: 300.h),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: regions.length,
                    itemBuilder: (context, index) {
                      final region = regions[index];
                      return ListTile(
                        leading: Text(
                          region['flag']!,
                          style: TextStyle(fontSize: 24.sp),
                        ),
                        title: Text(
                          region['name']!,
                          style: TextStyle(color: Colors.white),
                        ),
                        subtitle: Text(
                          region['code']!,
                          style: TextStyle(color: Colors.white70),
                        ),
                        onTap: () {
                          Navigator.pop(context);
                          controller.changeLanguage(
                            languageCode,
                            region['code']!,
                          );
                        },
                      );
                    },
                  ),
                ),
                SizedBox(height: 20.h),
              ],
            ),
          ),
    );
  }
}
