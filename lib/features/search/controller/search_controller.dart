import 'package:college_diary/features/search/repository/search_repository.dart';
import 'package:college_diary/model/user_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final searchUserControllerProvider = StreamProvider.family((ref, String query) {
  return ref.watch(searchControllerProvider.notifier).searchCommunity(query);
});

final searchControllerProvider =
    StateNotifierProvider<SearchController, bool>((ref) {
  return SearchController(
      searchRepository: ref.watch(searchRepositoryProvider));
});

class SearchController extends StateNotifier<bool> {
  final SearchRepository _searchRepository;

  SearchController({required SearchRepository searchRepository})
      : _searchRepository = searchRepository,
        super(false);

  Stream<List<UserModel>> searchCommunity(String query) {
    return _searchRepository.searchCommunity(query);
  }
}
