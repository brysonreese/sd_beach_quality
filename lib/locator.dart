import 'package:get_it/get_it.dart';
import 'package:sd_beach_quality/repositories/quality_report_repository.dart';

final GetIt getIt = GetIt.instance;

void setupLocator() {
  getIt.registerSingletonAsync<QualityReportRepository>(() async {
    final repo = QualityReportRepository();
    await repo.initialize();
    return repo;
  });
}
