import 'package:go_router/go_router.dart';
import '../domain/catatan.dart';
import 'layar_detail_catatan.dart';
import '../main.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const MyHomePage(
        title: 'Muhammad Dzulhisyam Izbadillah - 256151053',
      ),
    ),
    GoRoute(
      path: '/detail',
      builder: (context, state) {
        final catatan = state.extra as Catatan;
        return LayarDetailCatatan(catatan: catatan);
      },
    ),
  ],
);