import 'package:flutter/material.dart';
import 'package:sd_beach_quality/locator.dart';
import 'package:sd_beach_quality/models/quality_report.dart';
import 'package:sd_beach_quality/repositories/quality_report_repository.dart';
import 'package:sd_beach_quality/screens/report_details.dart';

class BeachQualityList extends StatefulWidget {
  const BeachQualityList({super.key});

  @override
  State<StatefulWidget> createState() => _BeachQualityListState();
}

class _BeachQualityListState extends State<BeachQualityList> {
  QualityReportRepository get qualityReportRepository =>
      getIt<QualityReportRepository>();

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
                DataCell(Text(Indicator.values[report.indicatorId - 1].name)),
              ],
              onSelectChanged: (value) {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ReportDetails(siteId: report.siteId),
                  ),
                );
              },
            );
          }).toList(),
        ),
      ),
    );
  }
}
