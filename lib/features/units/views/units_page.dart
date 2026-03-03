import 'package:anjapepito/core/constants/app_assert_image.dart';
import 'package:flutter/material.dart';
import '../../../core/util/screen_size.dart';
import '../../../core/widgets/Drawer/app_drawer.dart';
import '../../../core/widgets/text/app_text.dart';
import '../controllers/units_controllers.dart';
import 'package:get/get.dart';

class UnitsPage extends StatelessWidget {
  const UnitsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UnitsController());

    final assets = AppAssertImage.instance;
    return Scaffold(
      key: controller.scaffoldKey,
      backgroundColor: const Color(0xFFF8F5F1),
      drawer: const CustomAppDrawer(),

      body: SafeArea(
        child: Column(
          children: [
            // App Bar
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: context.responsiveSize(20),
                vertical: context.responsiveSize(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => controller.openDrawer(),
                    child: Icon(
                      Icons.menu,
                      size: context.responsiveSize(28),
                      color: const Color(0xFF2D2D2D),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => controller.onNotificationTap(context),
                    child: Image.asset(
                      assets.notificationIcon,
                      height: context.responsiveSize(28),
                      width: context.responsiveSize(28),
                      color: const Color(0xFF2D2D2D),
                    ),
                  ),
                ],
              ),
            ),

            Container(height: 1, color: const Color(0xFFE8E4DC)),

            // Content
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: context.responsiveSize(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: context.responsiveSize(16)),

                    // Completed Units Header
                    AppText(
                      data: 'Completed Units',
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF2D2D2D),
                      useResponsiveFontSize: true,
                    ),

                    SizedBox(height: context.responsiveSize(14)),

                    // Completed Units List
                    Obx(
                          () => ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: controller.completedUnits.length,
                        separatorBuilder: (context, index) =>
                            SizedBox(height: context.responsiveSize(12)),
                        itemBuilder: (context, index) {
                          return _buildUnitCard(
                            context,
                            controller,
                            controller.completedUnits[index],
                          );
                        },
                      ),
                    ),

                    SizedBox(height: context.responsiveSize(28)),

                    // Available Units Header
                    AppText(
                      data: 'Available Units',
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF2D2D2D),
                      useResponsiveFontSize: true,
                    ),

                    SizedBox(height: context.responsiveSize(14)),

                    // Available Units List
                    Obx(
                          () => ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: controller.availableUnits.length,
                        separatorBuilder: (context, index) =>
                            SizedBox(height: context.responsiveSize(12)),
                        itemBuilder: (context, index) {
                          return _buildUnitCard(
                            context,
                            controller,
                            controller.availableUnits[index],
                          );
                        },
                      ),
                    ),

                    SizedBox(height: context.responsiveSize(100)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUnitCard(
      BuildContext context,
      UnitsController controller,
      UnitItem unit,
      ) {
    final bool isCompleted = unit.status == UnitStatus.completed;
    final bool isInProgress = unit.status == UnitStatus.inProgress;
    final bool isLocked = unit.status == UnitStatus.locked;

    return GestureDetector(
      onTap: () => controller.onUnitTap(context, unit),
      child: Container(
        padding: EdgeInsets.all(context.responsiveSize(14)),
        decoration: BoxDecoration(
          color: isLocked
              ? Colors.white
              : const Color(0xFFEFF1DD),
          borderRadius: BorderRadius.circular(
            context.responsiveSize(10),
          ),
          border: (isCompleted || isInProgress)
              ? Border.all(
            color: const Color(0xFFD4D0C4),
            width: 1,
          )
              : null,
        ),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Status Icon
                Container(
                  width: context.responsiveSize(24),
                  height: context.responsiveSize(24),
                  decoration: BoxDecoration(
                    color: (isCompleted || isInProgress)
                        ? const Color(0xFF4CAF50)
                        : Colors.transparent,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: (isCompleted || isInProgress)
                        ? Icon(
                      Icons.check,
                      size: context.responsiveSize(22),
                      color: Colors.white,
                    )
                        : Image.asset(
                      AppAssertImage.instance.lockIcon,
                      height:  context.responsiveSize(20),
                      width:  context.responsiveSize(20),
                    ),
                  ),
                ),

                SizedBox(width: context.responsiveSize(12)),

                // Text Content
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                        children: [
                          AppText(
                            data: unit.title,
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF2D2D2D),
                            useResponsiveFontSize: true,
                          ),
                          // XP Badge
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: context.responsiveSize(10),
                              vertical: context.responsiveSize(4),
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFFF3D6),
                              borderRadius: BorderRadius.circular(
                                context.responsiveSize(8),
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  '✦',
                                  style: TextStyle(
                                    fontSize: context.responsiveSize(11),
                                    color: const Color(0xFFE8A838),
                                  ),
                                ),
                                AppText(
                                  data: '${unit.xp}XP',
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFFE8A838),
                                  useResponsiveFontSize: true,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),


                      AppText(
                        data: unit.subtitle,
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFFB0B0B0),
                        useResponsiveFontSize: true,
                      ),


                      // Status Text
                      AppText(
                        data: _getStatusText(unit.status),
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: _getStatusColor(unit.status),
                        useResponsiveFontSize: true,
                      ),

                      SizedBox(height: context.responsiveSize(6)),

                      // Progress Bar
                      ClipRRect(
                        borderRadius: BorderRadius.circular(
                          context.responsiveSize(3),
                        ),
                        child: LinearProgressIndicator(
                          value: unit.progress,
                          minHeight: context.responsiveSize(5),
                          backgroundColor: isLocked
                              ? const Color(0xFFE0E0E0)
                              : const Color(0xFF4CB8B3).withOpacity(0.2),
                          valueColor: AlwaysStoppedAnimation<Color>(
                            isLocked
                                ? const Color(0xFFE8A838)
                                : const Color(0xFF4CAF50),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(width: context.responsiveSize(8)),

                // Arrow
                Padding(
                  padding: EdgeInsets.only(
                    top: context.responsiveSize(16),
                  ),
                  child: Icon(
                    Icons.chevron_right,
                    size: context.responsiveSize(24),
                    color: const Color(0xFFB0B0B0),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _getStatusText(UnitStatus status) {
    switch (status) {
      case UnitStatus.completed:
        return 'Completed';
      case UnitStatus.inProgress:
        return 'In-progress';
      case UnitStatus.locked:
        return 'Locked';
    }
  }

  Color _getStatusColor(UnitStatus status) {
    switch (status) {
      case UnitStatus.completed:
        return const Color(0xFF4CAF50);
      case UnitStatus.inProgress:
        return const Color(0xFFE8A838);
      case UnitStatus.locked:
        return const Color(0xFFB0B0B0);
    }
  }
}