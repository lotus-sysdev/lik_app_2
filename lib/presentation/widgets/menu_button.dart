import 'package:flutter/material.dart';

class MenuButton extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final Color borderColor;
  final VoidCallback? onPressed;

  const MenuButton({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.borderColor,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isLargeScreen = screenWidth > 600;
    final isSmallScreen = screenWidth < 375;

    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: borderColor.withOpacity(0.2), width: 1),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onPressed,
        splashColor: color.withOpacity(0.1),
        highlightColor: color.withOpacity(0.05),
        child: Padding(
          padding: EdgeInsets.all(isLargeScreen ? 20 : 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width:
                    isLargeScreen
                        ? 64
                        : isSmallScreen
                        ? 48
                        : 56,
                height:
                    isLargeScreen
                        ? 64
                        : isSmallScreen
                        ? 48
                        : 56,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  size:
                      isLargeScreen
                          ? 32
                          : isSmallScreen
                          ? 24
                          : 28,
                  color: color,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize:
                      isLargeScreen
                          ? 18
                          : isSmallScreen
                          ? 14
                          : 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize:
                      isLargeScreen
                          ? 14
                          : isSmallScreen
                          ? 10
                          : 12,
                  color: Colors.grey[600],
                  height: 1.4,
                ),
              ),
              if (onPressed != null) ...[
                const SizedBox(height: 8),
                Icon(
                  Icons.chevron_right,
                  size: isLargeScreen ? 24 : 20,
                  color: color.withOpacity(0.7),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
