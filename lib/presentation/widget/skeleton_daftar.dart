import 'package:flutter/material.dart';

import '../theme/tokens.dart';

class SkeletonDaftar extends StatefulWidget {
  const SkeletonDaftar({super.key, this.jumlah = 4});

  final int jumlah;

  @override
  State<SkeletonDaftar> createState() => _SkeletonDaftarState();
}

class _SkeletonDaftarState extends State<SkeletonDaftar>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: AppDuration.sedang)
      ..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final skema = Theme.of(context).colorScheme;

    return ListView.builder(
      padding: const EdgeInsets.all(AppSpacing.md),
      itemCount: widget.jumlah,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: AppSpacing.sm),
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Container(
                height: 72,
                decoration: BoxDecoration(
                  color: skema.surfaceContainerHighest.withValues(
                    alpha: 0.4 + (_controller.value * 0.3),
                  ),
                  borderRadius: BorderRadius.circular(AppRadius.md),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
