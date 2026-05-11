import 'package:flutter/material.dart';
import 'package:sd_beach_quality/locator.dart';
import 'package:sd_beach_quality/repositories/quality_report_repository.dart';

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
  Widget build(Object context) {
    return SingleChildScrollView(
      child: DataTable(
        columns: const <DataColumn>[
          DataColumn(label: Expanded(child: Text("SiteID"))),
          DataColumn(label: Expanded(child: Text("Name"))),
          DataColumn(label: Expanded(child: Text("IndicatorID"))),
          DataColumn(label: Expanded(child: Text("Favorite?"))),
        ],
        rows: qualityReportRepository.list.map((report) {
          return DataRow(
            cells: <DataCell>[
              DataCell(Text(report.siteId.toString())),
              DataCell(Text(report.name)),
              DataCell(Text(report.indicatorId.toString())),
              DataCell(
                Icon(report.favorite ? Icons.star : Icons.star_border_outlined),
                onTap: () async {
                  await qualityReportRepository.toggleFavorite(report);
                  setState(() {});
                },
              ),
            ],
          );
        }).toList(),
      ),
    );
  }
}
