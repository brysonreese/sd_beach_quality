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

  final _searchController = TextEditingController();
  String _query = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<QualityReport> filteredReports = qualityReportRepository.list
        .where(
          (reports) =>
              reports.name.toLowerCase().contains(_query.toLowerCase()),
        )
        .toList();

    filteredReports.sort((a, b) => a.regionId.compareTo(b.regionId));

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'Search beaches...',
              prefixIcon: const Icon(Icons.search),
              suffixIcon: _query.isEmpty
                  ? null
                  : IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        _searchController.clear();
                        setState(() => _query = '');
                      },
                    ),
            ),
            onChanged: (value) => setState(() => _query = value),
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: SizedBox(
              width: double.infinity,
              child: DataTable(
                showCheckboxColumn: false,
                columns: const <DataColumn>[
                  DataColumn(label: Expanded(child: Text("DehID"))),
                  DataColumn(label: Expanded(child: Text("Name"))),
                  DataColumn(label: Expanded(child: Text("IndicatorID"))),
                ],
                rows: filteredReports.map((report) {
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
                }).toList(),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
