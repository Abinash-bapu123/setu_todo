import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:setu_todo/providors/todo_provider.dart';
import 'package:setu_todo/utils/app_assets.dart';
import 'package:setu_todo/utils/app_colors.dart';

class StackedWidget extends StatelessWidget {
  final bool isOnTop;
  final double top;
  final String pageName;
  final Widget child;
  final void Function() onTap;
  const StackedWidget({
    required this.isOnTop,
    required this.pageName,
    required this.top,
    required this.child,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Positioned(
      top: size.height * top,
      left: isOnTop ? size.width * 0.026 : size.width * 0.035,
      right: isOnTop ? size.width * 0.026 : size.width * 0.035,
      child: InkWell(
        onTap: onTap,
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.515,
          child: Stack(
            children: [
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.appText.withOpacity(0.2),
                      offset: const Offset(5, 5),
                      blurRadius: 10,
                      spreadRadius: 7,
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 30,
                    horizontal: 25,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            pageName,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          if (pageName == "JOURNAL")
                            Consumer<TodoProvider>(
                              builder: (context, journalPr, _) {
                                final isJournalEditState =
                                    journalPr.isJournalEditState;
                                return InkWell(
                                  onTap: () {
                                    isJournalEditState
                                        ? journalPr.changeJournalEditState(true)
                                        : journalPr
                                            .changeJournalEditState(false);
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 6,
                                      vertical: 3,
                                    ),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: isJournalEditState
                                            ? AppColors.appPrimary
                                            : AppColors.editButtonColor,
                                        width: 1.0,
                                      ),
                                      color: isJournalEditState
                                          ? AppColors.appPrimary
                                          : Colors.transparent,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Row(
                                      children: [
                                        Image.asset(isJournalEditState
                                            ? AppAssets.tickSquare
                                            : AppAssets.editIcon),
                                        const SizedBox(width: 5),
                                        Text(
                                          isJournalEditState ? "SAVE" : "EDIT",
                                          style: GoogleFonts.manrope(
                                            color: isJournalEditState
                                                ? AppColors.appSecondary
                                                : AppColors.editButtonColor,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w800,
                                            height: 1.3,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.029,
                      ),
                      Expanded(child: child),
                    ],
                  ),
                ),
              ),
              !isOnTop
                  ? Positioned(
                      left: 5,
                      right: 5,
                      bottom: 5,
                      height: 100,
                      child: Container(
                        padding: const EdgeInsets.only(
                          top: 55,
                          left: 20,
                        ),
                        color: AppColors.appSecondary,
                        child: Text(
                          pageName,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                    )
                  : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
