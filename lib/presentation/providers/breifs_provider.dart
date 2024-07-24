import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/core/api_client.dart';
import '../../data/data_sources/briefs_remote_data_source.dart';
import '../../data/di/get_it.dart';
import '../../data/models/briefs_model.dart';
import '../../data/models/thread_image_model.dart';
import '../../data/repositories/breifs_repository.dart';

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
  final eitherBriefsOrError = await breifsRepository.getAllBriefs(0);
  return eitherBriefsOrError!.fold((error) => throw error, (briefs) async {
    // final updatedBriefs = await Future.wait(briefs!.map((brief) async {
    //   // final likedModel = await ref.watch(getALikeProvider(threadId: brief!.id).future);
    //   // return brief.copyWith(
    //   //   isPostLiked: likedModel.likeId != null,
    //   //   postLikeId: likedModel.likeId,
    //   // );
    //   if (brief!.likeObj != null && brief.likeObj!.id != null) {
    //     return brief.copyWith(
    //       isPostLiked: brief.id != null,
    //       postLikeId: brief.likeObj!.id,
    //     );
    //   } else {
    //     return brief;
    //   }
    // }).toList());
    return briefs ?? [];
  });
}

class BriefsNotifier extends StateNotifier<List<BriefsModel?>> {
  BriefsNotifier(this.ref) : super([]);

  final Ref ref;
  bool isLoading = false;
  bool _hasMore = true;
  int _page = 0;
  bool hasFetchedInitial = false;
  Timer? _debounceTimer;

  Future<void> fetchBriefs() async {
    if (isLoading || !_hasMore) return;
    isLoading = true;

    try {
      final briefsRepository = ref.read(briefsRepositoryProvider);
      final eitherBriefsOrError = await briefsRepository.getAllBriefs(_page);

      eitherBriefsOrError!.fold(
        (error) {
          // Handle error (e.g., show an error message)
          throw error;
        },
        (briefs) {
          if (briefs!.isEmpty) {
            _hasMore = false;
          } else {
            state = [...state, ...briefs];
            _page++;
          }
        },
      );
    } catch (e) {
      // Handle any unexpected errors
      print('Error fetching briefs: $e');
    } finally {
      isLoading = false; // Reset loading state
      hasFetchedInitial = true; // Indicate that initial fetch has been done
    }
  }

  void debounceFetch() {
    _debounceTimer?.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 300), fetchBriefs);
  }
}

final briefsProvider = StateNotifierProvider<BriefsNotifier, List<BriefsModel?>>((ref) {
  return BriefsNotifier(ref);
});

@riverpod
Future<List<BriefsModel?>?> getUserBriefs(GetUserBriefsRef ref) async {
  final breifsRepository = ref.watch(briefsRepositoryProvider);
  final eitherBriefsOrError = await breifsRepository.getUserBriefs();
  return eitherBriefsOrError!.fold(
    (error) {
      throw error; // Throw the error for Riverpod to handle
    },
    (briefs) async {
      // final updatedBriefs = await Future.wait(briefs!.map((brief) async {
      //   // final likedModel = await ref.watch(getALikeProvider(threadId: brief!.id).future);
      //   // return brief.copyWith(
      //   //   isPostLiked: likedModel.likeId != null,
      //   //   postLikeId: likedModel.likeId,
      //   // );
      //   if (brief!.likeObj != null && brief.likeObj!.id != null) {
      //     return brief.copyWith(
      //       isPostLiked: brief.id != null,
      //       postLikeId: brief.likeObj!.id,
      //     );
      //   } else {
      //     return brief;
      //   }
      // }).toList());
      return briefs ?? [];
    },
  );
}

@riverpod
Future<BriefsModel?> getSingleBrief(GetSingleBriefRef ref, {required String? briefId}) async {
  final breifsRepository = ref.watch(briefsRepositoryProvider);
  final eitherBriefOrError = await breifsRepository.getSingleBrief(briefId);
  return eitherBriefOrError!.fold(
    (error) {
      throw error; // Throw the error for Riverpod to handle
    },
    (brief) => brief,
  );
}

@riverpod
Future<bool> postBrief(
  PostBriefRef ref, {
  required String? userId,
  required String? uName,
  required String? type,
  required String? category,
  required String? postText,
  String? imgSrc,
  required List<String>? isVisibleTo,
}) async {
  final breifsRepository = ref.watch(briefsRepositoryProvider);
  final eitherBriefsOrError = await breifsRepository.postBrief(
    userId: userId,
    name: uName,
    type: type,
    category: category,
    postText: postText,
    imgSrc: imgSrc,
    isVisibleTo: isVisibleTo,
  );
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

@riverpod
Future<bool> deleteBrief(DeleteBriefRef ref, {required String? briefId}) async {
  final breifsRepository = ref.watch(briefsRepositoryProvider);
  final eitherBriefsOrError = await breifsRepository.deleteBrief(briefId: briefId);
  return eitherBriefsOrError!.fold(
    (error) {
      throw error; // Throw the error for Riverpod to handle
    },
    (briefs) => briefs,
  );
}

@riverpod
Future<bool> editBrief(
  EditBriefRef ref, {
  required String briefId,
  required bool isVisible,
  required String userId,
  required String uname,
  required String type,
  required String category,
  required String postText,
  required String imgSrc,
  required String avatarSrc,
  required String createdAt,
  required String updatedAt,
  required int likesCount,
  required int replyCount,
  required int postedAt,
  required List<String>? isVisibleTo,
}) async {
  final breifsRepository = ref.watch(briefsRepositoryProvider);
  final eitherBriefsOrError = await breifsRepository.editBrief(
    briefId: briefId,
    isVisible: isVisible,
    avatarSrc: avatarSrc,
    category: category,
    createdAt: createdAt,
    imgSrc: imgSrc,
    likesCount: likesCount,
    name: uname,
    postedAt: postedAt,
    replyCount: replyCount,
    type: type,
    updatedAt: updatedAt,
    userId: userId,
    postText: postText,
    isVisibleTo: isVisibleTo,
  );
  return eitherBriefsOrError!.fold(
    (error) {
      throw error; // Throw the error for Riverpod to handle
    },
    (briefs) => briefs,
  );
}
