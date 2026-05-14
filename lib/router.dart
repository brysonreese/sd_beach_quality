import 'package:go_router/go_router.dart';
import 'package:sd_beach_quality/screens/beach_quality_list.dart';
import 'package:sd_beach_quality/screens/home_screen.dart';
import 'package:sd_beach_quality/screens/report_details.dart';
import 'package:sd_beach_quality/shell.dart';

final router = GoRouter(
  routes: [
    ShellRoute(
      builder: (context, state, child) => Shell(child: child),
      routes: [
        GoRoute(path: '/', builder: (context, state) => const HomeScreen()),
        GoRoute(
          path: '/list',
          builder: (context, state) => const BeachQualityList(),
        ),
        GoRoute(
          path: '/report/:siteId',
          builder: (context, state) {
            final siteId = int.parse(state.pathParameters['siteId']!);
            return ReportDetails(siteId: siteId);
          },
        ),
      ],
    ),
  ],
);
