import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../entities/dashboard_summary.dart';
import '../repositories/dashboard_repository.dart';

class GetDashboardSummary {
  final DashboardRepository repository;

  GetDashboardSummary(this.repository);

  Future<Either<Failure, DashboardSummary>> call(String organizerId) async {
    if (organizerId.isEmpty) {
      return left(ValidationFailure('Organizer ID is required'));
    }
    return await repository.getDashboardSummary(organizerId);
  }
}
