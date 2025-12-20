import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_numkit/flutter_numkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:siraj/core/services/hive_services.dart';
import 'package:siraj/core/shared/widgets/cached_network_image_widget.dart';
import 'package:siraj/core/shared/widgets/container_widget.dart';
import 'package:siraj/core/theme/app_colors.dart';
import 'package:siraj/core/theme/app_fonts.dart';
import 'package:siraj/core/utils/constants/app_icons.dart';
import 'package:siraj/core/utils/constants/app_images.dart';
import 'package:siraj/core/utils/constants/app_strings.dart';
import 'package:siraj/core/utils/extensions/context_extension.dart';
import 'package:siraj/core/utils/extensions/widget_extension.dart';
import 'package:siraj/features/quran/quran_kareem/data/quran_kareem_activity_model.dart';
import 'package:siraj/features/quran/quran_kareem/data/quran_kareem_surah_screen_args_model.dart';
import 'package:siraj/features/quran/quran_kareem/logic/quran_kareem_change_focus_cubit/quran_kareem_change_focus_cubit.dart';
import 'package:siraj/features/quran/quran_kareem/logic/quran_kareem_surah_page_details_cubit/quran_kareem_surah_page_details_cubit.dart';
import 'package:siraj/features/quran/quran_kareem/logic/quran_kareem_surah_page_drag_detector_cubit/quran_kareem_surah_page_drag_detector_cubit.dart';
import 'package:siraj/features/quran/quran_kareem/logic/quran_kareem_surah_page_number_cubit/quran_kareem_surah_page_number_cubit.dart';
import 'package:siraj/features/quran/quran_kareem/ui/widgets/quran_kareem_surah_page_details_bottom_sheet.dart';

class SurahScreen extends StatelessWidget {
  final QuranKareemSurahScreenArgsModel? args;

  const SurahScreen({this.args, super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (didPop, _) {
        if (didPop) {
          QuranKareemActivityModel lastRead = context.read<QuranKareemSurahPageDetailsCubit>().state.maybeWhen(
            orElse: () => QuranKareemActivityModel(juz: 1, page: 1, surahs: [1]),
            success: (details) => QuranKareemActivityModel(juz: details.juz, page: details.page, surahs: details.surahs.map((surah) => surah.number).toList()),
          );
          HiveServices.addLastRead(lastRead);
        }
      },
      child: BlocBuilder<QuranKareemSurahPageNumberCubit, int>(
        builder: (context, pageNumber) {
          context.read<QuranKareemSurahPageDetailsCubit>().getPageDetails(pageNumber);
          return Column(
            children: [
              SizedBox(
                height: 20,
                child: BlocBuilder<QuranKareemSurahPageDetailsCubit, QuranKareemSurahPageDetailsState>(
                  builder: (context, pageDetails) {
                    return pageDetails.maybeWhen(
                      orElse: () {
                        return 20.verticalGap;
                      },
                      success: (details) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SvgPicture.asset("${AppIcons.juzsBase}/${details.juz}.svg", height: 20, fit: BoxFit.fill),
                            ListView.separated(
                              shrinkWrap: true,
                              itemCount: details.surahs.length,
                              scrollDirection: Axis.horizontal,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (_, int index) {
                                int surahNumber = details.surahs.map((surah) => surah.number).toList()[index];
                                return SvgPicture.asset("${AppIcons.surahsBase}/$surahNumber.svg", height: 20, fit: BoxFit.fill);
                              },
                              separatorBuilder: (_, __) {
                                return VerticalDivider(color: AppColors.whiteColor);
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ).center().expanded(flex: 6),
              BlocBuilder<QuranKareemChangeFocusCubit, bool>(
                builder: (context, focused) {
                  return BlocBuilder<QuranKareemSurahPageNumberCubit, int>(
                    builder: (context, currentPageNumber) {
                      int previousPage = currentPageNumber;
                      return AnimatedSwitcher(
                        duration: 300.milSec,
                        transitionBuilder: (Widget child, Animation<double> animation) {
                          return FadeTransition(
                            opacity: animation,
                            child: SlideTransition(
                              position: Tween<Offset>(begin: Offset(currentPageNumber > previousPage ? -0.1 : 0.1, 0.0), end: Offset.zero).animate(animation),
                              child: child,
                            ),
                          );
                        },
                        child: GestureDetector(
                          key: ValueKey<int>(pageNumber),
                          onLongPress: () =>
                              context.read<QuranKareemSurahPageDetailsCubit>().state.whenOrNull(success: (pageDetails) => quranKareemSurahPageDetailsBottomSheet(context, pageDetails: pageDetails)),
                          onVerticalDragEnd: (details) => context.read<QuranKareemSurahPageDragDetectorCubit>().detectDrag(false),
                          onHorizontalDragEnd: (details) => context.read<QuranKareemSurahPageDragDetectorCubit>().detectDrag(false),
                          onVerticalDragStart: (details) => context.read<QuranKareemSurahPageDragDetectorCubit>().detectDrag(false),
                          onHorizontalDragStart: (details) => context.read<QuranKareemSurahPageDragDetectorCubit>().detectDrag(false),
                          onVerticalDragUpdate: (details) {
                            if (details.primaryDelta == null || context.read<QuranKareemSurahPageDragDetectorCubit>().state) return;

                            if (details.primaryDelta! > 0) {
                              context.read<QuranKareemSurahPageDragDetectorCubit>().detectDrag(true);
                              context.read<QuranKareemChangeFocusCubit>().changeFocus(focus: false);
                            } else if (details.primaryDelta! < 0) {
                              context.read<QuranKareemSurahPageDragDetectorCubit>().detectDrag(true);
                              context.read<QuranKareemChangeFocusCubit>().changeFocus(focus: true);
                            }
                          },
                          onHorizontalDragUpdate: (details) {
                            if (details.primaryDelta == null || context.read<QuranKareemSurahPageDragDetectorCubit>().state) return;

                            if (details.primaryDelta! > 0 && pageNumber < (args?.juz?.pagesTo ?? args?.surah?.pagesTo ?? 604)) {
                              context.read<QuranKareemSurahPageDragDetectorCubit>().detectDrag(true);
                              context.read<QuranKareemSurahPageNumberCubit>().changePage(pageNumber + 1);
                            } else if (details.primaryDelta! < 0 && pageNumber > (args?.juz?.pagesFrom ?? args?.surah?.pagesFrom ?? 1)) {
                              context.read<QuranKareemSurahPageDragDetectorCubit>().detectDrag(true);
                              context.read<QuranKareemSurahPageNumberCubit>().changePage(pageNumber - 1);
                            }
                          },
                          child: Column(
                            children: [
                              AnimatedSize(
                                duration: 300.milSec,
                                child: CachedNetworkImageWidget("${AppImages.quranBase}/$pageNumber.png", height: context.screenHeight, width: context.screenWidth, fit: BoxFit.fill),
                              ).align(alignment: Alignment.topRight).expanded(),
                              AnimatedSize(
                                duration: 300.milSec,
                                child: focused
                                    ? Row(
                                        children: [
                                          ContainerWidget(
                                            onTap: () {
                                              context.read<QuranKareemSurahPageDetailsCubit>().changeFav();
                                              context.read<QuranKareemChangeFocusCubit>().changeFocus();
                                            },
                                            border: Border.all(color: AppColors.whiteColor),
                                            gradient: LinearGradient(
                                              begin: AlignmentGeometry.topLeft,
                                              end: AlignmentGeometry.bottomRight,
                                              colors: [AppColors.transparentColor.withAlpha(100), AppColors.whiteColor.withAlpha(100), AppColors.transparentColor.withAlpha(100)],
                                            ),
                                            child: Row(
                                              children: [
                                                Icon(Icons.favorite_border_rounded, color: AppColors.whiteColor, size: 20),
                                                10.horizontalGap,
                                                Text(
                                                  context.read<QuranKareemSurahPageDetailsCubit>().state.maybeWhen(
                                                    orElse: () => AppStrings.addToFav,
                                                    success: (pageDetails) => pageDetails.isFav ? AppStrings.removeFromFav : AppStrings.addToFav,
                                                  ),
                                                  style: TextStyle(fontSize: AppFonts.h4, color: AppColors.whiteColor),
                                                ),
                                              ],
                                            ),
                                          ).animate().scale(duration: 300.milSec),
                                          Spacer(),
                                          ContainerWidget(
                                            onTap: () {
                                              context.read<QuranKareemSurahPageDetailsCubit>().changeBookMark();
                                              context.read<QuranKareemChangeFocusCubit>().changeFocus();
                                            },
                                            border: Border.all(color: AppColors.whiteColor),
                                            gradient: LinearGradient(
                                              begin: AlignmentGeometry.topLeft,
                                              end: AlignmentGeometry.bottomRight,
                                              colors: [AppColors.transparentColor.withAlpha(100), AppColors.whiteColor.withAlpha(100), AppColors.transparentColor.withAlpha(100)],
                                            ),
                                            child: Row(
                                              children: [
                                                Text(
                                                  context.read<QuranKareemSurahPageDetailsCubit>().state.maybeWhen(
                                                    orElse: () => AppStrings.addBookMark,
                                                    success: (pageDetails) => pageDetails.hasBookMark ? AppStrings.removeBookMark : AppStrings.addBookMark,
                                                  ),
                                                  style: TextStyle(fontSize: AppFonts.h4, color: AppColors.whiteColor),
                                                ),
                                                10.horizontalGap,
                                                Icon(Icons.bookmark_border_rounded, color: AppColors.whiteColor, size: 20),
                                              ],
                                            ),
                                          ).animate().scale(duration: 300.milSec),
                                        ],
                                      ).padding(insets: 12.verticalEdgeInsets)
                                    : 0.squareGap,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ).expanded(flex: 88),
              GestureDetector(
                onHorizontalDragUpdate: (details) {
                  if (details.delta.dx > 0 && pageNumber < (args?.juz?.pagesTo ?? args?.surah?.pagesTo ?? 604)) {
                    context.read<QuranKareemSurahPageNumberCubit>().changePage(++pageNumber);
                  } else if (details.delta.dx < 0 && pageNumber > (args?.juz?.pagesFrom ?? args?.surah?.pagesFrom ?? 1)) {
                    context.read<QuranKareemSurahPageNumberCubit>().changePage(--pageNumber);
                  }
                },
                child: SizedBox(
                  height: 5.percentOf(context.screenHeight),
                  child: Row(
                    children: [
                      BlocBuilder<QuranKareemSurahPageDetailsCubit, QuranKareemSurahPageDetailsState>(
                        builder: (context, pageDetails) {
                          return pageDetails.maybeWhen(
                            orElse: () => 0.squareGap,
                            success: (details) => details.isFav ? Icon(Icons.favorite_rounded, color: AppColors.whiteColor, size: 20).animate().scale(duration: 300.milSec) : 20.squareGap,
                          );
                        },
                      ),
                      Container(
                        alignment: Alignment.center,
                        child: Text(pageNumber.toString(), style: TextStyle(fontSize: AppFonts.h3)),
                      ).center().expanded(),
                      BlocBuilder<QuranKareemSurahPageDetailsCubit, QuranKareemSurahPageDetailsState>(
                        builder: (context, pageDetails) {
                          return pageDetails.maybeWhen(
                            orElse: () => 0.squareGap,
                            success: (details) => details.hasBookMark ? Icon(Icons.bookmark_rounded, color: AppColors.whiteColor, size: 20).animate().scale(duration: 300.milSec) : 20.squareGap,
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ).expanded(flex: 6),
            ],
          ).padding(insets: 12.horizontalEdgeInsets);
        },
      ),
    ).defaultScaffold();
  }
}
