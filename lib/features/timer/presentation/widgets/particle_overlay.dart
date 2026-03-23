import 'package:flutter/material.dart';
import 'package:particles_flutter/particles_flutter.dart';

class ParticleOverlay extends StatelessWidget {
  final Widget child;

  const ParticleOverlay({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: CircularParticle(
            key: UniqueKey(),
            awayRadius: 80,
            numberOfParticles: 40,
            speedOfParticles: 0.4,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            onTapAnimation: true,
            particleColor: Colors.white.withOpacity(0.12),
            awayAnimationDuration: const Duration(milliseconds: 600),
            maxParticleSize: 2.5,
            isRandSize: true,
            isRandomColor: false,
            awayAnimationCurve: Curves.easeInOutBack,
            enableHover: true,
            hoverColor: Colors.white,
            hoverRadius: 90,
            connectDots: false,
          ),
        ),
        child,
      ],
    );
  }
}
