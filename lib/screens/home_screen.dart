import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sd_beach_quality/locator.dart';
import 'package:sd_beach_quality/repositories/quality_report_repository.dart';
import 'package:sd_beach_quality/models/quality_report.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  QualityReportRepository get qualityReportRepository =>
      getIt<QualityReportRepository>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (qualityReportRepository.list
        .where((element) => element.favorite == true)
        .isEmpty) {
      return Center(child: Text("No Favorites"));
    } else {
      return ListenableBuilder(
        listenable: qualityReportRepository,
        builder: (context, child) {
          return SingleChildScrollView(
            child: SizedBox(
              width: double.infinity,
              child: DataTable(
                showCheckboxColumn: false,
                columns: const <DataColumn>[
                  DataColumn(label: Expanded(child: Text("DehID"))),
                  DataColumn(label: Expanded(child: Text("Name"))),
                  DataColumn(label: Expanded(child: Text("IndicatorID"))),
                ],
                rows: qualityReportRepository.list
                    .where((element) => element.favorite == true)
                    .map((report) {
                      return DataRow(
                        cells: <DataCell>[
                          DataCell(Text(report.dehId)),
                          DataCell(Text(report.name)),
                          DataCell(statusIcons[report.indicatorId - 1]),
                        ],
                        onSelectChanged: (value) {
                          context.push('/report/${report.siteId}');
                        },
                      );
                    })
                    .toList(),
              ),
            ),
          );
        },
      );
    }
  }
}
