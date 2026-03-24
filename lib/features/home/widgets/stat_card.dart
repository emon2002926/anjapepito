import 'package:flutter/material.dart';

import '../../../core/util/screen_size.dart';
import '../models/stat_item.dart';
class StatCard extends StatelessWidget {
  const StatCard({super.key, required this.stats});

  final List<StatItem> stats;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(context.responsiveSize(12)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(context.responsiveSize(12)),
        boxShadow: [
          BoxShadow(
            color: Color(0xFFDFDFD8),
            blurRadius: 0,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: stats.asMap().entries.map((entry) {
          final index = entry.key;
          final stat = entry.value;
          return Expanded(
            child: Row(
              children: [
                Expanded(child: _buildCard(context, stat)),
                if (index < stats.length - 1)
                  SizedBox(width: context.responsiveSize(8)),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildCard(BuildContext context, StatItem stat) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: context.responsiveSize(10),
        vertical: context.responsiveSize(10),
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.white,
          width: context.responsiveSize(2),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
        gradient: LinearGradient(
          colors: stat.gradientColors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(context.responsiveSize(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Emoji + Value + Label row
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                stat.emoji,
                style: TextStyle(fontSize: context.responsiveSize(16)),
              ),
              SizedBox(width: context.responsiveSize(4)),
              Flexible(
                child:
                    stat.isSplit ? Text(
                      stat.value.isEmpty
                          ? stat.label
                          : '${stat.value} ${stat.label}',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: context.responsiveSize(13),
                        fontWeight: FontWeight.w800,
                        color: stat.color,
                      ),
                    ):
                    Row(
                      children: [
                        Text(
                          stat.value,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: context.responsiveSize(13),
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          " ${stat.label}",
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: context.responsiveSize(13),
                            fontWeight: FontWeight.w800,
                            color: stat.color,
                          ),
                        )
                      ],
                    ),


              ),
            ],
          ),

          SizedBox(height: context.responsiveSize(10)),

          // Progress Bar
          ClipRRect(
            borderRadius: BorderRadius.circular(context.responsiveSize(10)),
            child: LinearProgressIndicator(
              value: stat.barFill,
              minHeight: context.responsiveSize(6),
              backgroundColor: Colors.white.withOpacity(0.35),
              valueColor: AlwaysStoppedAnimation<Color>(
                Colors.white.withOpacity(0.7),
              ),
            ),
          ),
        ],
      ),
    );
  }
}