import 'package:anjapepito/core/constants/app_assert_image.dart';
import 'package:flutter/material.dart';
import '../../../core/util/screen_size.dart';
import '../../../core/widgets/text/app_text.dart';
import '../controllers/units_controllers.dart';
import 'package:get/get.dart';

class UnitsPage extends StatelessWidget {
  const UnitsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<UnitsController>();
    final assets = AppAssertImage.instance;
    return Scaffold(
      backgroundColor: Colors.transparent,

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
                    child: Image.asset(
                      assets.drawerIcon,
                      height: context.responsiveSize(28),
                      width: context.responsiveSize(28),
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
    final bool isActive = isCompleted || isInProgress;

    return GestureDetector(
      onTap: () => controller.onUnitTap(context, unit),
      child: Container(
        padding: EdgeInsets.all(context.responsiveSize(14)),
        decoration: BoxDecoration(
          color: isLocked ? const Color(0xFFD8D8D8) : null,
          image: isActive
              ? DecorationImage(
            image: AssetImage(AppAssertImage.instance.activeLessonCardBg),
            fit: BoxFit.fill,
          )
              : null,
          borderRadius: BorderRadius.circular(context.responsiveSize(16)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // ── Status Icon ──
            SizedBox(
              height: context.responsiveSize(80),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  isActive
                      ? Image.asset(
                    AppAssertImage.instance.checkIcon,
                    height: context.responsiveSize(36),
                    width: context.responsiveSize(36),
                  ) : SizedBox(
                    width: context.responsiveSize(36),
                    height: context.responsiveSize(36),
                    child: Center(
                      child: Image.asset(
                        AppAssertImage.instance.lockIconWithBg,
                        height: context.responsiveSize(36),
                        width: context.responsiveSize(36),
                        // color: const Color(0xFF9CA3AF),
                      ),
                    ),
                  ),

                ]
              ),
            ),

            SizedBox(width: context.responsiveSize(12)),

            // ── Text Content ──
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppText(
                        data: unit.title,
                        fontSize: 15,
                        fontWeight: FontWeight.w900,
                        color: isLocked
                            ? const Color(0xFF9CA3AF)
                            : const Color(0xFF624D40),
                        useResponsiveFontSize: true,
                      ),
                    ],
                  ),

                  SizedBox(height: context.responsiveSize(2)),

                  AppText(
                    data: unit.subtitle,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: isLocked
                        ? const Color(0xFF9CA3AF)
                        : const Color(0xFFA68978),
                    useResponsiveFontSize: true,
                  ),

                  SizedBox(height: context.responsiveSize(4)),

                  // ── Status Text / LOCKED Badge ──
                  isLocked
                      ? Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: context.responsiveSize(10),
                      vertical: context.responsiveSize(3),
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE0E0E0),
                      borderRadius: BorderRadius.circular(
                        context.responsiveSize(6),
                      ),
                    ),
                    child: AppText(
                      data: 'LOCKED',
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFFB0B0B0),
                      useResponsiveFontSize: true,
                    ),
                  )
                      : AppText(
                    data: _getStatusText(unit.status),
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: _getStatusColor(unit.status),
                    useResponsiveFontSize: true,
                  ),

                  SizedBox(height: context.responsiveSize(8)),

                  // ── Progress Bar ──
                  ClipRRect(
                    borderRadius: BorderRadius.circular(
                      context.responsiveSize(6),
                    ),
                    child: SizedBox(
                      height: context.responsiveSize(8),
                      child: Stack(
                        children: [
                          Container(
                            color: isActive
                                ? const Color(0xFFE0E0E0)
                                : const Color(0xFFEEEEEE),
                          ),
                          FractionallySizedBox(
                            widthFactor: unit.progress,
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: isActive
                                      ? [
                                    const Color(0xFFFB923C),
                                    const Color(0xFFFDE047),
                                  ]
                                      : [
                                    const Color(0xFFDDDDDD),
                                    const Color(0xFFDDDDDD),
                                  ],
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(width: context.responsiveSize(8)),

            // ── XP Badge + Arrow ──
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: context.responsiveSize(10),
                    vertical: context.responsiveSize(4),
                  ),
                  decoration: BoxDecoration(
                    color: isActive
                        ? const Color(0xFFE8A838)
                        : const Color(0xFFDDDDDD),
                    borderRadius: BorderRadius.circular(
                      context.responsiveSize(20),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '✦ ',
                        style: TextStyle(
                          fontSize: context.responsiveSize(11),
                          color: isActive
                              ? Colors.white
                              : const Color(0xFFAAAAAA),
                        ),
                      ),
                      AppText(
                        data: '${unit.xp} XP',
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: isActive
                            ? Colors.white
                            : const Color(0xFFAAAAAA),
                        useResponsiveFontSize: true,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: context.responsiveSize(12)),
                Icon(
                  Icons.chevron_right,
                  size: context.responsiveSize(24),
                  color: isLocked
                      ? const Color(0xFFD0D0D0)
                      : const Color(0xFFB0B0B0),
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