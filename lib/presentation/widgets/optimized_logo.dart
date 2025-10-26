/// 🎨 Optimized Logo Widget
///
/// Bu widget, optimize edilmiş logo ve branding bölümünü içerir.
library;

import 'package:flutter/material.dart';

class OptimizedLogo extends StatefulWidget {
  final bool isAnimated;
  final double? scale;

  const OptimizedLogo({super.key, this.isAnimated = true, this.scale});

  @override
  State<OptimizedLogo> createState() => _OptimizedLogoState();
}

class _OptimizedLogoState extends State<OptimizedLogo>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOutCubic),
    );

    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );

    if (widget.isAnimated) {
      _animationController.forward();
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.isAnimated) {
      return _buildStaticLogo();
    }

    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value * (widget.scale ?? 1.0),
          child: Opacity(
            opacity: _opacityAnimation.value,
            child: _buildStaticLogo(),
          ),
        );
      },
    );
  }

  Widget _buildStaticLogo() {
    return Row(
      children: [
        // Optimized ŞEBO Logo Container
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 28.0, vertical: 10.0),
          decoration: BoxDecoration(
            color: const Color(0xFFE0E0E0),
            borderRadius: BorderRadius.circular(25.0),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFFE0E0E0).withValues(alpha: 0.2),
                blurRadius: 4,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          child: const Text(
            'ŞEBO',
            style: TextStyle(
              color: Color(0xFF4A4A4A),
              fontWeight: FontWeight.w900,
              fontSize: 16,
              letterSpacing: 0.5,
            ),
          ),
        ),
        const SizedBox(width: 16.0),

        // Creative Agency Text
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(color: const Color(0xFFE0E0E0), width: 1.5),
            ),
          ),
          child: const Text(
            'creative agency',
            style: TextStyle(
              color: Color(0xFFE0E0E0),
              fontWeight: FontWeight.w300,
              fontSize: 13,
              letterSpacing: 1.2,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
      ],
    );
  }
}

/// Compact version of the logo for smaller spaces
class CompactLogo extends StatelessWidget {
  final bool showTagline;

  const CompactLogo({super.key, this.showTagline = true});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Compact ŞEBO Logo
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
          decoration: BoxDecoration(
            color: const Color(0xFFE0E0E0),
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: const Text(
            'ŞEBO',
            style: TextStyle(
              color: Color(0xFF4A4A4A),
              fontWeight: FontWeight.w900,
              fontSize: 14,
              letterSpacing: 0.5,
            ),
          ),
        ),

        if (showTagline) ...[
          const SizedBox(width: 8.0),
          // Compact tagline
          Text(
            'creative agency',
            style: TextStyle(
              color: const Color(0xFFE0E0E0),
              fontWeight: FontWeight.w300,
              fontSize: 11,
              letterSpacing: 1.0,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ],
    );
  }
}

/// Logo with hover effects for interactive elements
class InteractiveLogo extends StatefulWidget {
  final VoidCallback? onTap;
  final bool showHoverEffect;

  const InteractiveLogo({super.key, this.onTap, this.showHoverEffect = true});

  @override
  State<InteractiveLogo> createState() => _InteractiveLogoState();
}

class _InteractiveLogoState extends State<InteractiveLogo>
    with SingleTickerProviderStateMixin {
  late AnimationController _hoverController;
  late Animation<double> _hoverAnimation;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();

    _hoverController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    _hoverAnimation = Tween<double>(begin: 1.0, end: 1.05).animate(
      CurvedAnimation(parent: _hoverController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _hoverController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: widget.showHoverEffect ? (_) => _onHover(true) : null,
      onExit: widget.showHoverEffect ? (_) => _onHover(false) : null,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedBuilder(
          animation: _hoverAnimation,
          builder: (context, child) {
            return Transform.scale(
              scale: _hoverAnimation.value,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 28.0,
                  vertical: 10.0,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFE0E0E0),
                  borderRadius: BorderRadius.circular(25.0),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(
                        0xFFE0E0E0,
                      ).withValues(alpha: _isHovered ? 0.3 : 0.2),
                      blurRadius: _isHovered ? 8 : 4,
                      offset: Offset(0, _isHovered ? 2 : 1),
                    ),
                  ],
                ),
                child: const Text(
                  'ŞEBO',
                  style: TextStyle(
                    color: Color(0xFF4A4A4A),
                    fontWeight: FontWeight.w900,
                    fontSize: 16,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _onHover(bool isHovered) {
    setState(() {
      _isHovered = isHovered;
    });

    if (isHovered) {
      _hoverController.forward();
    } else {
      _hoverController.reverse();
    }
  }
}
