import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../repositories/dashboard_repository.dart';

class ExportDashboardReport {
  final DashboardRepository repository;

  ExportDashboardReport(this.repository);

  Future<Either<Failure, String>> call(String organizerId) async {
    if (organizerId.isEmpty) {
      return left(ValidationFailure('Organizer ID is required'));
    }
    return await repository.exportDashboardReport(organizerId);
  }
}
