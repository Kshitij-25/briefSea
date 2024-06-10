import 'package:briefsea/data/models/thread_image_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/core/api_client.dart';
import '../../data/data_sources/briefs_remote_data_source.dart';
import '../../data/di/get_it.dart';
import '../../data/models/briefs_model.dart';
import '../../data/repositories/breifs_repository.dart';
import 'likes_provider.dart';

part 'breifs_provider.g.dart';

@riverpod
BriefsRemoteDataSource briefsRemoteDataSource(BriefsRemoteDataSourceRef ref) {
  final apiClient = getItInstance<ApiClient>();
  return BriefsRemoteDataSourceImpl(apiClient);
}

@riverpod
BreifsRepository briefsRepository(BriefsRepositoryRef ref) {
  final briefsRemoteDataSource = ref.watch(briefsRemoteDataSourceProvider);
  return BreifsRepository(briefsRemoteDataSource);
}

@riverpod
Future<List<BriefsModel?>?> getAllBriefs(GetAllBriefsRef ref) async {
  final breifsRepository = ref.watch(briefsRepositoryProvider);
  final eitherBriefsOrError = await breifsRepository.getAllBriefs();
  return eitherBriefsOrError!.fold((error) => throw error, (briefs) async {
    final updatedBriefs = await Future.wait(briefs!.map((brief) async {
      final likedModel = await ref.watch(getALikeProvider(threadId: brief!.id).future);
      return brief.copyWith(
        isPostLiked: likedModel.likeId != null,
        postLikeId: likedModel.likeId,
      );
    }).toList());
    return updatedBriefs;
  });
}

@riverpod
Future<List<BriefsModel?>?> getUserBriefs(GetUserBriefsRef ref) async {
  final breifsRepository = ref.watch(briefsRepositoryProvider);
  final eitherBriefsOrError = await breifsRepository.getUserBriefs();
  return eitherBriefsOrError!.fold(
    (error) {
      throw error; // Throw the error for Riverpod to handle
    },
    (briefs) => briefs!,
  );
}

@riverpod
Future<bool> postBrief(PostBriefRef ref, {userId, uName, type, category, postText, imgSrc}) async {
  final breifsRepository = ref.watch(briefsRepositoryProvider);
  final eitherBriefsOrError = await breifsRepository.postBrief(userId, uName, type, category, postText, imgSrc);
  return eitherBriefsOrError!.fold(
    (error) {
      throw error; // Throw the error for Riverpod to handle
    },
    (briefs) => briefs,
  );
}

@riverpod
Future<ThreadImageModel> uploadThreadImage(UploadThreadImageRef ref,
    {required fileName, required fileType, required userId, required userType}) async {
  final breifsRepository = ref.watch(briefsRepositoryProvider);
  final eitherBriefsOrError = await breifsRepository.uploadThreadImage(fileName, fileType, userId, userType);
  return eitherBriefsOrError!.fold(
    (error) {
      throw error; // Throw the error for Riverpod to handle
    },
    (briefs) => briefs,
  );
}
