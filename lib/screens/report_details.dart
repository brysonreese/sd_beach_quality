import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:html/parser.dart';
import 'package:sd_beach_quality/locator.dart';
import 'package:sd_beach_quality/models/quality_report.dart';
import 'package:sd_beach_quality/repositories/quality_report_repository.dart';

class ReportDetails extends StatefulWidget {
  const ReportDetails({super.key, required this.siteId});
  final int siteId;

  @override
  State<StatefulWidget> createState() => _ReportDetailsState();
}

class _ReportDetailsState extends State<ReportDetails> {
  QualityReportRepository get qualityReportRepository =>
      getIt<QualityReportRepository>();
  late QualityReport report;

  @override
  void initState() {
    super.initState();
    report = qualityReportRepository.getBySiteId(widget.siteId);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        IconButton(icon: Icon(Icons.close), onPressed: () => context.pop()),
        ListView(
          shrinkWrap: true,
          children: [
            ListTile(
              title: Text(
                "DEH ID",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(report.dehId),
            ),
            ListTile(
              title: Text(
                "Status",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Align(
                alignment: Alignment.centerLeft,
                child: statusIcons[report.indicatorId - 1],
              ),
            ),
            ListTile(
              title: Text(
                "Name",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(report.name),
            ),
            ListTile(
              title: Text(
                "Description",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                parse(report.description).body != null
                    ? parse(report.description).body!.text
                    : "No Description",
              ),
            ),
            report.advisory != null && report.advisory != ""
                ? ListTile(
                    title: Text(
                      "Advisory",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      parse(report.advisory).body != null
                          ? parse(report.advisory).body!.text
                          : "No Advisory",
                    ),
                  )
                : null,
            report.closure != null && report.closure != ""
                ? ListTile(
                    title: Text(
                      "Closure",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      parse(report.closure).body != null
                          ? parse(report.closure).body!.text
                          : "No Closure",
                    ),
                  )
                : null,
          ].whereType<Widget>().toList(),
        ),
        ElevatedButton.icon(
          icon: Icon(report.favorite ? Icons.star : Icons.star_border),
          label: Text(report.favorite ? "Favorited" : "Add to Favorites"),
          onPressed: () {
            qualityReportRepository.toggleFavorite(report);
            setState(() {});
          },
        ),
      ],
    );
  }
}
