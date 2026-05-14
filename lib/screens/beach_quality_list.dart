import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sd_beach_quality/locator.dart';
import 'package:sd_beach_quality/models/quality_report.dart';
import 'package:sd_beach_quality/repositories/quality_report_repository.dart';

class BeachQualityList extends StatefulWidget {
  const BeachQualityList({super.key});

  @override
  State<StatefulWidget> createState() => _BeachQualityListState();
}

class _BeachQualityListState extends State<BeachQualityList> {
  QualityReportRepository get qualityReportRepository =>
      getIt<QualityReportRepository>();

  List<Icon> statusIcons = [
    Icon(Icons.block),
    Icon(Icons.check_box),
    Icon(Icons.warning),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
          rows: qualityReportRepository.list.map((report) {
            return DataRow(
              cells: <DataCell>[
                DataCell(Text(report.dehId)),
                DataCell(Text(report.name)),
                DataCell(statusIcons[report.indicatorId - 1]),
              ],
              onSelectChanged: (value) {
                context.go('/report/${report.siteId}');
              },
            );
          }).toList(),
        ),
      ),
    );
  }
}
