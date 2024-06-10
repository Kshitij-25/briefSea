import 'package:briefsea/data/data_sources/reply_remote_data_source.dart';
import 'package:briefsea/data/models/comment_model.dart';
import 'package:briefsea/data/repositories/reply_repository.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/core/api_client.dart';
import '../../data/di/get_it.dart';
import '../../data/models/like_model.dart';

part 'reply_provider.g.dart';

final textFieldFocusNodeProvider = Provider<FocusNode>((ref) {
  return FocusNode();
});

@riverpod
ReplyRemoteDataSource replyRemoteDataSource(ReplyRemoteDataSourceRef ref) {
  final apiClient = getItInstance<ApiClient>();
  return ReplyRemoteDataSourceImpl(apiClient);
}

@riverpod
ReplyRepository replyRepository(ReplyRepositoryRef ref) {
  final replyRemoteDataSource = ref.read(replyRemoteDataSourceProvider);
  return ReplyRepository(replyRemoteDataSource);
}

@riverpod
Future<bool> postReply(PostReplyRef ref, {required userId, required threadId, required commentText}) async {
  final replyRepository = ref.read(replyRepositoryProvider);
  final eitherReplynOrError = await replyRepository.postReply(userId, threadId, commentText);
  return eitherReplynOrError!.fold(
    (error) {
      throw error; // Throw the error for Riverpod to handle
    },
    (reply) => reply,
  );
}

@riverpod
Future<LikeModel> getCommentLike(GetCommentLikeRef ref, {replyId}) async {
  final replyRepository = ref.watch(replyRepositoryProvider);
  final eitherLikenOrError = await replyRepository.getCommentLike(replyId);
  return eitherLikenOrError!.fold(
    (error) {
      throw error; // Throw the error for Riverpod to handle
    },
    (like) => like,
  );
}

@riverpod
Future<List<CommentModel>> getAllComments(GetAllCommentsRef ref, {required threadId}) async {
  final replyRepository = ref.read(replyRepositoryProvider);
  final eitherReplyLikenOrError = await replyRepository.getAllComments(threadId);
  return eitherReplyLikenOrError!.fold((error) => throw error, (replyLike) async {
    final updatedcomment = await Future.wait(replyLike.map((comment) async {
      final likedModel = await ref.watch(getCommentLikeProvider(replyId: comment.id).future);
      return comment.copyWith(
        isCommentLiked: likedModel.likeId != null,
        commentLikeId: likedModel.likeId,
      );
    }).toList());
    return updatedcomment;
  });
}



// @riverpod
// Future<List<BriefsModel?>?> getAllBriefs(GetAllBriefsRef ref) async {
//   final breifsRepository = ref.watch(briefsRepositoryProvider);
//   final eitherBriefsOrError = await breifsRepository.getAllBriefs();
//   return eitherBriefsOrError!.fold((error) => throw error, (briefs) async {
//     final updatedBriefs = await Future.wait(briefs!.map((brief) async {
//       final likedModel = await ref.watch(getALikeProvider(threadId: brief!.id).future);
//       return brief.copyWith(
//         isPostLiked: likedModel.likeId != null,
//         postLikeId: likedModel.likeId,
//       );
//     }).toList());
//     return updatedBriefs;
//   });
// }