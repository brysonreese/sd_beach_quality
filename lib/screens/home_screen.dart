import 'package:flutter/material.dart';
import 'package:sd_beach_quality/locator.dart';
import 'package:sd_beach_quality/models/quality_report.dart';
import 'package:sd_beach_quality/repositories/quality_report_repository.dart';

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
    return ListenableBuilder(
      listenable: qualityReportRepository,
      builder: (context, _) {
        return SingleChildScrollView(
          child: SizedBox(
            width: double.infinity,
            child: DataTable(
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
                        DataCell(
                          Text(Indicator.values[report.indicatorId - 1].name),
                        ),
                      ],
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
