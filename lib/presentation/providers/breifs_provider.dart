import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http_parser/src/media_type.dart';

import '../../data/core/api_client.dart';
import '../../data/data_sources/briefs_remote_data_source.dart';
import '../../data/di/get_it.dart';
import '../../data/models/brief_model.dart';
import '../../data/models/briefs_result.dart';
import '../../data/models/thread_image_model.dart';
import '../../data/repositories/breifs_repository.dart';
import '../params/briefs_params.dart';

class BriefsProviders {
  static final briefsRemoteDataSourceProvider = Provider<BriefsRemoteDataSource>((ref) {
    final apiClient = getItInstance<ApiClient>();
    return BriefsRemoteDataSourceImpl(apiClient);
  });

  static final briefsRepositoryProvider = Provider<BreifsRepository>((ref) {
    final briefsRemoteDataSource = ref.watch(briefsRemoteDataSourceProvider);
    return BreifsRepository(briefsRemoteDataSource);
  });

  static final getAllBriefsProvider = FutureProvider.family<BriefModel?, int?>((ref, pageNumber) async {
    final briefsRepository = ref.watch(briefsRepositoryProvider);
    final eitherBriefsOrError = await briefsRepository.getAllBriefs(pageNumber);
    return eitherBriefsOrError!.fold(
      (error) => throw error,
      (briefs) => briefs,
    );
  });

  static final getUserBriefsProvider = FutureProvider<List<BriefsResult?>?>((ref) async {
    final briefsRepository = ref.watch(briefsRepositoryProvider);
    final eitherBriefsOrError = await briefsRepository.getUserBriefs();
    return eitherBriefsOrError!.fold(
      (error) => throw error,
      (briefs) => briefs,
    );
  });

  static final getSingleBriefProvider = FutureProvider.family<BriefsResult?, String?>((ref, briefId) async {
    final briefsRepository = ref.watch(briefsRepositoryProvider);
    final eitherBriefOrError = await briefsRepository.getSingleBrief(briefId);
    return eitherBriefOrError!.fold(
      (error) => throw error,
      (brief) => brief,
    );
  });

  static final postBriefProvider = FutureProvider.family<bool, PostBriefParams>((ref, params) async {
    final briefsRepository = ref.watch(briefsRepositoryProvider);
    final eitherBriefsOrError = await briefsRepository.postBrief(
      userId: params.userId,
      name: params.uName,
      type: params.type,
      category: params.category,
      postText: params.postText,
      imgSrc: params.imgSrc,
      isVisibleTo: params.isVisibleTo,
    );
    return eitherBriefsOrError!.fold(
      (error) => throw error,
      (briefs) => briefs,
    );
  });

  static final uploadThreadImageProvider = FutureProvider.family<ThreadImageModel, UploadThreadImageParams>((ref, params) async {
    final briefsRepository = ref.watch(briefsRepositoryProvider);
    final eitherBriefsOrError = await briefsRepository.uploadThreadImage(
      params.fileName,
      params.fileType as MediaType,
      params.userId,
      params.userType,
    );
    return eitherBriefsOrError!.fold(
      (error) => throw error,
      (briefs) => briefs,
    );
  });

  static final deleteBriefProvider = FutureProvider.family<bool, String?>((ref, briefId) async {
    final briefsRepository = ref.watch(briefsRepositoryProvider);
    final eitherBriefsOrError = await briefsRepository.deleteBrief(briefId: briefId);
    return eitherBriefsOrError!.fold(
      (error) => throw error,
      (briefs) => briefs,
    );
  });

  static final editBriefProvider = FutureProvider.family<bool, EditBriefParams>((ref, params) async {
    final briefsRepository = ref.watch(briefsRepositoryProvider);
    final eitherBriefsOrError = await briefsRepository.editBrief(
      briefId: params.briefId,
      isVisible: params.isVisible,
      avatarSrc: params.avatarSrc,
      category: params.category,
      createdAt: params.createdAt,
      imgSrc: params.imgSrc,
      likesCount: params.likesCount,
      name: params.uname,
      postedAt: params.postedAt,
      replyCount: params.replyCount,
      type: params.type,
      updatedAt: params.updatedAt,
      userId: params.userId,
      postText: params.postText,
      isVisibleTo: params.isVisibleTo,
    );
    return eitherBriefsOrError!.fold(
      (error) => throw error,
      (briefs) => briefs,
    );
  });
}
