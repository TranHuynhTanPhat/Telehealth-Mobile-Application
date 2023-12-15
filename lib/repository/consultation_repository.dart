// ignore_for_file: unused_field
import 'package:healthline/data/api/services/consultation_service.dart';
import 'package:healthline/repository/base_repository.dart';

class ConsultationRepository extends BaseRepository {
  final ConsultationService _consultationService = ConsultationService();

  Future<List<int>> fetchTimeline(
      {required String id, required String date}) async {
    return await _consultationService.fetchTimeline(id: id, date: date);
  }
}
