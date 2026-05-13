import 'package:flutter/material.dart';
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
    return Center(child: Text(report.toString()));
  }
}
