import 'package:flutter/material.dart';
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
          ],
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
