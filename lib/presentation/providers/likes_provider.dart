import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/core/api_client.dart';
import '../../data/data_sources/like_remote_data_source.dart';
import '../../data/di/get_it.dart';
import '../../data/models/briefs_model.dart';
import '../../data/models/like_model.dart';
import '../../data/repositories/like_repository.dart';

part 'likes_provider.g.dart';

@riverpod
LikeRemoteDataSource likeRemoteDataSource(LikeRemoteDataSourceRef ref) {
  final apiClient = getItInstance<ApiClient>();
  return LikeRemoteDataSourceImpl(apiClient);
}

@riverpod
LikeRepository likeRepository(LikeRepositoryRef ref) {
  final likeRemoteDataSource = ref.watch(likeRemoteDataSourceProvider);
  return LikeRepository(likeRemoteDataSource);
}

@riverpod
Future<bool> postLike(
  PostLikeRef ref, {
  required String? userId,
  required String? uName,
  String? replyId,
  required threadId,
  required type,
}) async {
  final likeRepository = ref.watch(likeRepositoryProvider);
  final eitherLikenOrError = await likeRepository.postLike(
    userId: userId,
    name: uName,
    replyId: replyId,
    threadId: threadId,
    type: type,
  );
  return eitherLikenOrError!.fold(
    (error) {
      throw error; // Throw the error for Riverpod to handle
    },
    (like) => like,
  );
}

@riverpod
Future<LikeModel> getALike(GetALikeRef ref, {threadId}) async {
  final likeRepository = ref.watch(likeRepositoryProvider);
  final eitherLikenOrError = await likeRepository.getALike(threadId);
  return eitherLikenOrError!.fold(
    (error) {
      throw error; // Throw the error for Riverpod to handle
    },
    (like) => like,
  );
}

@riverpod
Future<bool> deleteLike(DeleteLikeRef ref, {required userId, required uName, required type, threadId, replyId, required likeId}) async {
  final likeRepository = ref.watch(likeRepositoryProvider);
  final eitherLikenOrError = await likeRepository.deleteLike(userId, uName, type, threadId, replyId, likeId);
  return eitherLikenOrError!.fold(
    (error) {
      throw error; // Throw the error for Riverpod to handle
    },
    (like) => like,
  );
}
