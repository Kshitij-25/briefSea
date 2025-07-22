import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../data/core/api_client.dart';
import '../../data/data_sources/reply_remote_data_source.dart';
import '../../data/di/get_it.dart';
import '../../data/models/comment_model.dart';
import '../../data/models/like_model.dart';
import '../../data/repositories/reply_repository.dart';
import '../params/reply_params.dart';

final textFieldFocusNodeProvider = Provider<FocusNode>((ref) {
  return FocusNode();
});

class ReplyProvider {
  static final replyRemoteDataSourceProvider = Provider<ReplyRemoteDataSource>((ref) {
    final apiClient = getItInstance<ApiClient>();
    return ReplyRemoteDataSourceImpl(apiClient);
  });

  static final replyRepositoryProvider = Provider<ReplyRepository>((ref) {
    final replyRemoteDataSource = ref.watch(replyRemoteDataSourceProvider);
    return ReplyRepository(replyRemoteDataSource);
  });

  static final postReplyProvider = FutureProvider.family<bool, PostReplyParams>((ref, params) async {
    final replyRepository = ref.watch(replyRepositoryProvider);
    final eitherReplyOrError = await replyRepository.postReply(
      params.userId,
      params.threadId,
      params.commentText,
      params.replyId,
    );
    return eitherReplyOrError!.fold(
      (error) => throw error,
      (reply) => reply,
    );
  });

  static final getCommentLikeProvider = FutureProvider.family<LikeModel, String?>((ref, replyId) async {
    final replyRepository = ref.watch(replyRepositoryProvider);
    final eitherLikeOrError = await replyRepository.getCommentLike(replyId);
    return eitherLikeOrError!.fold(
      (error) => throw error,
      (like) => like,
    );
  });

  static final getAllCommentsProvider = FutureProvider.family<List<CommentModel>, String?>((ref, threadId) async {
    final replyRepository = ref.watch(replyRepositoryProvider);
    final eitherCommentsOrError = await replyRepository.getAllComments(threadId);
    return eitherCommentsOrError!.fold(
      (error) => throw error,
      (comments) => comments,
    );
  });

  static final getAllReplyOnCommentProvider = FutureProvider.family<List<CommentModel>, String?>((ref, commentId) async {
    final replyRepository = ref.watch(replyRepositoryProvider);
    final eitherRepliesOrError = await replyRepository.getAllReplyOnComment(commentId);
    return eitherRepliesOrError!.fold(
      (error) => throw error,
      (replies) => replies,
    );
  });

  static final deleteCommentProvider = FutureProvider.family<bool, String?>((ref, commentId) async {
    final replyRepository = ref.watch(replyRepositoryProvider);
    final eitherDeletedOrError = await replyRepository.deleteComment(commentId);
    return eitherDeletedOrError!.fold(
      (error) => throw error,
      (deleted) => deleted,
    );
  });

  static final editCommentProvider = FutureProvider.family<bool, EditReplyParams>((ref, params) async {
    final replyRepository = ref.watch(replyRepositoryProvider);
    final eitherEditedOrError = await replyRepository.editComment(
      params.commentId,
      params.commentText,
    );
    return eitherEditedOrError!.fold(
      (error) => throw error,
      (edited) => edited,
    );
  });
}
