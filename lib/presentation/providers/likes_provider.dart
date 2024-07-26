import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../data/core/api_client.dart';
import '../../data/data_sources/like_remote_data_source.dart';
import '../../data/di/get_it.dart';
import '../../data/models/like_model.dart';
import '../../data/repositories/like_repository.dart';
import '../params/likes_params.dart';

class LikesProvider {
  static final likeRemoteDataSourceProvider = Provider<LikeRemoteDataSource>((ref) {
    final apiClient = getItInstance<ApiClient>();
    return LikeRemoteDataSourceImpl(apiClient);
  });

  static final likeRepositoryProvider = Provider<LikeRepository>((ref) {
    final likeRemoteDataSource = ref.watch(likeRemoteDataSourceProvider);
    return LikeRepository(likeRemoteDataSource);
  });

  static final postLikeProvider = FutureProvider.family<bool, PostLikeParams>((ref, params) async {
    final likeRepository = ref.watch(likeRepositoryProvider);
    final eitherLikeOrError = await likeRepository.postLike(
      userId: params.userId,
      name: params.uName,
      replyId: params.replyId,
      threadId: params.threadId,
      type: params.type,
    );
    return eitherLikeOrError!.fold(
      (error) => throw error,
      (like) => like,
    );
  });

  static final getALikeProvider = FutureProvider.family<LikeModel, String?>((ref, threadId) async {
    final likeRepository = ref.watch(likeRepositoryProvider);
    final eitherLikeOrError = await likeRepository.getALike(threadId);
    return eitherLikeOrError!.fold(
      (error) => throw error,
      (like) => like,
    );
  });

  static final deleteLikeProvider = FutureProvider.family<bool, DeleteLikeParams>((ref, params) async {
    final likeRepository = ref.watch(likeRepositoryProvider);
    final eitherLikeOrError = await likeRepository.deleteLike(params.threadId, params.likeId);
    return eitherLikeOrError!.fold(
      (error) => throw error,
      (like) => like,
    );
  });
}
