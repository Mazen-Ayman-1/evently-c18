import 'package:evently_c16_mon/core/providers/app_config_provider.dart';
import 'package:evently_c16_mon/core/theme/app_colors.dart';
import 'package:evently_c16_mon/firebase/firebase_auth_service.dart';
import 'package:evently_c16_mon/models/category_dm.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    var color = provider.isDark() ? AppColors.white : AppColors.lightBlue;
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: provider.isDark() ? AppColors.darkPurple : AppColors.purple,
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(24),
          bottomLeft: Radius.circular(24),
        ),
      ),

      child: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Welcome Back ✨",
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color:
                              provider.isDark()
                                  ? AppColors.lightBlue
                                  : AppColors.white,
                        ),
                      ),
                      Text(
                        FirebaseAuthService().getUserData()?.displayName ?? "",
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color:
                              provider.isDark()
                                  ? AppColors.lightBlue
                                  : AppColors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () {
                    provider.changeTheme(
                      provider.isDark() ? ThemeMode.light : ThemeMode.dark,
                    );
                  },
                  icon: Icon(
                    provider.isDark() ? Icons.dark_mode : Icons.light_mode,
                    color: color,
                  ),
                ),
                InkWell(
                  onTap: () {
                    provider.changeLocale(provider.isEn() ? "ar" : "en");
                  },
                  child: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      provider.isEn() ? "En" : "ع",
                      style: TextStyle(
                        color:
                            provider.isDark()
                                ? AppColors.darkPurple
                                : AppColors.purple,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.location_on_outlined, color: color),
                SizedBox(width: 8),
                Text(
                  "Cairo , Egypt",
                  style: Theme.of(
                    context,
                  ).textTheme.bodyLarge!.copyWith(color: color),
                ),
              ],
            ),
            SizedBox(height: 16),
            DefaultTabController(
              length: categoriesList.length,

              child: TabBar(
                isScrollable: true,
                indicator: null,
                indicatorColor: Colors.transparent,
                dividerHeight: 0,
                labelPadding: EdgeInsets.symmetric(horizontal: 8.0),
                padding: EdgeInsets.symmetric(horizontal: 8),
                tabAlignment: TabAlignment.start,
                tabs:
                    categoriesList
                        .map(
                          (category) => Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(1000),
                              border: Border.all(width: 1, color: color),
                            ),
                            child: Row(
                              children: [
                                Icon(category.icon, color: color),
                                SizedBox(width: 8),
                                Text(
                                  provider.isEn()
                                      ? category.nameEn
                                      : category.nameAr,
                                  style: TextStyle(color: color),
                                ),
                              ],
                            ),
                          ),
                        )
                        .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
