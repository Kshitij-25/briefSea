import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/core/api_client.dart';
import '../../data/data_sources/reply_remote_data_source.dart';
import '../../data/di/get_it.dart';
import '../../data/models/comment_model.dart';
import '../../data/models/like_model.dart';
import '../../data/repositories/reply_repository.dart';

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
Future<bool> postReply(PostReplyRef ref, {required String? userId, required String? threadId, required String? commentText, String? replyId}) async {
  final replyRepository = ref.read(replyRepositoryProvider);
  final eitherReplynOrError = await replyRepository.postReply(
    userId,
    threadId,
    commentText,
    replyId,
  );
  return eitherReplynOrError!.fold(
    (error) {
      throw error; // Throw the error for Riverpod to handle
    },
    (reply) => reply,
  );
}

@riverpod
Future<LikeModel> getCommentLike(GetCommentLikeRef ref, {required String? replyId}) async {
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
Future<List<CommentModel>> getAllComments(GetAllCommentsRef ref, {required String? threadId}) async {
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

@riverpod
Future<List<CommentModel>> getAllReplyOnComment(GetAllReplyOnCommentRef ref, {required String? commentId}) async {
  final replyRepository = ref.read(replyRepositoryProvider);
  final eitherReplyLikenOrError = await replyRepository.getAllReplyOnComment(commentId);
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
