import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:share_plus/share_plus.dart';

import '../../../common/app_utils/app_utility.dart';
import '../../../data/core/api_constants.dart';
import '../../../data/core/app_error.dart';
import '../../../data/models/briefs_result.dart';
import '../../params/briefs_params.dart';
import '../../params/likes_params.dart';
import '../../params/notification_params.dart';
import '../../providers/auth_provider.dart';
import '../../providers/breifs_provider.dart';
import '../../providers/likes_provider.dart';
import '../../providers/notification_provider.dart';
import '../../state_providers/image_picker_provider.dart';
import '../../widgets/custom_briefs_card.dart';
import '../../widgets/post_brief_modal_sheet.dart';
import 'feed_screen.dart';

class AllBriefsScreen extends ConsumerStatefulWidget {
  const AllBriefsScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AllBriefsScreenState();
}

class _AllBriefsScreenState extends ConsumerState<AllBriefsScreen> {
  final TextEditingController postEditController = TextEditingController();
  final ScrollController scrollController = ScrollController();
  static const pageSize = 10;
  int currentPage = 1;
  bool isLoadingMore = false;
  bool hasMore = true;

  @override
  void initState() {
    super.initState();
    scrollController.addListener(_onScroll);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(briefsNotifierProvider.notifier).fetchBriefs(page: currentPage);
    });
  }

  @override
  void dispose() {
    scrollController.removeListener(_onScroll);
    postEditController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (scrollController.position.extentAfter < 300 && !isLoadingMore && hasMore) {
      _fetchNextPage();
    }
  }

  void _fetchNextPage() {
    setState(() {
      isLoadingMore = true;
      currentPage++;
    });

    ref.read(briefsNotifierProvider.notifier).fetchBriefs(page: currentPage).then((fetchedData) {
      setState(() {
        isLoadingMore = false;
        hasMore = fetchedData.length == pageSize;
      });
    });
  }

  Future<void> _refreshBriefs() async {
    setState(() {
      currentPage = 1;
      hasMore = true;
      isLoadingMore = false;
    });

    await ref.read(briefsNotifierProvider.notifier).fetchBriefs(page: currentPage);
  }

  @override
  Widget build(BuildContext context) {
    final briefsState = ref.watch(briefsNotifierProvider);
    final userDetails = ref.watch(userDetailsProvider);

    return RefreshIndicator.adaptive(
      onRefresh: _refreshBriefs,
      child: briefsState.when(
        data: (briefs) {
          if (briefs.isEmpty) {
            return const Center(child: Text('No briefs available.'));
          }

          return ListView.builder(
            controller: scrollController,
            itemCount: briefs.length + (isLoadingMore ? 1 : 0),
            itemBuilder: (context, index) {
              if (index == briefs.length) {
                return const Center(child: CircularProgressIndicator());
              }

              final brief = briefs[index];

              return CustomBriefsCard(
                isUserTrue: brief.userId != userDetails['user_id'] ? false : true,
                brief: brief,
                onSelected: (value) async {
                  if (value == 'edit') {
                    await _editBrief(context, brief);
                  } else if (value == "delete") {
                    await _deleteBrief(context, brief);
                  } else if (value == "visible") {
                    await _toggleBriefVisibility(brief);
                  }
                },
                onCommentTap: (brief) {
                  context.pushNamed(
                    FeedScreen.routeName,
                    extra: {'briefId': brief?.id},
                  );
                },
                onLikeTap: (_) async {
                  await _toggleLikeBrief(brief, userDetails);
                },
                onShareTap: (brief) => shareBrief(brief!),
                onTap: () {
                  context.pushNamed(
                    FeedScreen.routeName,
                    extra: {'briefId': brief.id},
                  );
                },
              );
            },
          );
        },
        error: (error, stackTrace) => Center(
          child: Text(
            error is AppError ? error.errorMessage.toString() : 'ERROR: ${error.toString()}',
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.black),
          ),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }

  Future<void> _editBrief(BuildContext context, BriefsResult brief) async {
    postEditController.text = brief.postText ?? '';
    List<String>? initialVisibleTo = brief.isVisibleTo;
    await customPostBriefModalSheet(
      context,
      selectedImage: ref.watch(selectedPostImageProvider),
      postTextCont: postEditController,
      postingAs: brief.name,
      onVisbileSelect: (List<String?> values) {
        if (!listEquals(values, initialVisibleTo)) {
          List<String>? updatedVisibleTo = List.from(brief.isVisibleTo ?? []);
          updatedVisibleTo.clear();
          updatedVisibleTo.addAll(values.whereType<String>().toList());
          updatedVisibleTo = updatedVisibleTo.toSet().toList();
          final updatedBrief = brief.copyWith(isVisibleTo: updatedVisibleTo);
          brief = updatedBrief;
        }
      },
      selectedVisibleTo: brief.isVisibleTo ?? [],
      photoOnTap: () async {
        // ... (Image picker logic)
      },
      postOnTap: (postText, selectedCategory) async {
        if (postEditController.text.isNotEmpty && selectedCategory != '') {
          var status = await ref.watch(
            BriefsProviders.editBriefProvider(
              EditBriefParams(
                briefId: brief.id!,
                isVisible: brief.isVisible!,
                userId: brief.userId!,
                uname: brief.name!,
                type: brief.type!,
                category: selectedCategory,
                postText: postText.trim(),
                imgSrc: brief.imgSrc ?? '',
                avatarSrc: brief.avatarSrc!,
                createdAt: brief.createdAt!,
                updatedAt: brief.updatedAt!,
                likesCount: brief.likesCount!,
                replyCount: brief.replyCount!,
                postedAt: brief.postedAt!,
                isVisibleTo: brief.isVisibleTo,
              ),
            ).future,
          );

          if (status == true) {
            postEditController.clear();
            GoRouter.of(context).pop();
          }
          ref.invalidate(briefsNotifierProvider);
          ref.read(briefsNotifierProvider.notifier).fetchBriefs(page: 1);
          ref.invalidate(BriefsProviders.getUserBriefsProvider);
        } else {
          AppUtility(context).error('Choose a category first.');
        }
      },
    );
  }

  Future<void> _deleteBrief(BuildContext context, BriefsResult brief) async {
    await showAdaptiveDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog.adaptive(
          content: const Text(
            'Deleting this brief will permanently remove it from the system. This action cannot be undone.',
            style: TextStyle(color: Colors.black),
          ),
          title: const Text(
            'Are you sure you want to delete this brief?',
            style: TextStyle(color: Colors.black),
          ),
          actions: [
            TextButton(
              onPressed: () => context.pop(false),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                var isDeleted = await ref.watch(BriefsProviders.deleteBriefProvider(brief.id).future);
                if (isDeleted == true) {
                  ref.invalidate(briefsNotifierProvider);
                  ref.read(briefsNotifierProvider.notifier).fetchBriefs(page: 1);
                  ref.invalidate(BriefsProviders.getUserBriefsProvider);
                  context.pop();
                }
              },
              child: Text(
                'Delete',
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: Colors.black,
                    ),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> _toggleBriefVisibility(BriefsResult brief) async {
    var isVisible = await ref.watch(
      BriefsProviders.editBriefProvider(
        EditBriefParams(
          briefId: brief.id!,
          isVisible: !brief.isVisible!,
          userId: brief.userId!,
          uname: brief.name!,
          type: brief.type!,
          category: brief.category!,
          postText: brief.postText!,
          imgSrc: brief.imgSrc!,
          avatarSrc: brief.avatarSrc!,
          createdAt: brief.createdAt!,
          updatedAt: brief.updatedAt!,
          likesCount: brief.likesCount!,
          replyCount: brief.replyCount!,
          postedAt: brief.postedAt!,
          isVisibleTo: brief.isVisibleTo,
        ),
      ).future,
    );
    if (isVisible == true) {
      ref.invalidate(briefsNotifierProvider);
      ref.read(briefsNotifierProvider.notifier).fetchBriefs(page: 1);
      ref.invalidate(BriefsProviders.getUserBriefsProvider);
    }
  }

  Future<void> _toggleLikeBrief(BriefsResult brief, Map<String, String> userDetails) async {
    final tempBrief = brief;
    try {
      await Future.delayed(Duration(milliseconds: 200));

      if (brief.likeObj!.userId == null) {
        // User likes the brief
        final updatedBrief = brief.copyWith(
          likeObj: brief.likeObj?.copyWith(userId: userDetails['user_id'], threadId: brief.id),
          likesCount: brief.likesCount! + 1,
        );

        // Update the state with the updated brief
        _updateBriefState(updatedBrief);

        // Simulate network request to post like
        await _postLike(brief.id!, userDetails);

        // Send notification if the user is not the one who posted the brief
        if (brief.userId != userDetails['user_id']) {
          await _sendLikeNotification(brief, userDetails);
        }
      } else {
        // User unlikes the brief
        final updatedBrief = brief.copyWith(
          likeObj: brief.likeObj?.copyWith(userId: null, threadId: brief.id),
          likesCount: brief.likesCount! - 1,
        );

        // Update the state with the updated brief
        _updateBriefState(updatedBrief);

        // Fetch the updated like object from the API
        final updatedLikeObj = await ref.read(
          LikesProvider.getALikeProvider(brief.id).future,
        );

        // Simulate network request to delete like
        await ref.read(
          LikesProvider.deleteLikeProvider(
            DeleteLikeParams(
              likeId: updatedLikeObj.likeId,
              threadId: brief.id,
            ),
          ).future,
        );
      }
    } catch (e) {
      log(e.toString());
      // If there's an error, revert the state to the original brief
      _updateBriefState(tempBrief);
      AppUtility(context).error('Something went wrong.');
    }
  }

  void _updateBriefState(BriefsResult updatedBrief) {
    setState(() {
      final index = ref.read(briefsNotifierProvider).value?.indexWhere((element) => element.id == updatedBrief.id);
      if (index != null) {
        ref.read(briefsNotifierProvider).value![index] = updatedBrief;
      }
    });
  }

  Future<void> _postLike(String threadId, Map<String, String> userDetails) async {
    await ref.read(
      LikesProvider.postLikeProvider(
        PostLikeParams(
          threadId: threadId,
          type: userDetails['type'],
          uName: userDetails['user_name'],
          userId: userDetails['user_id'],
          replyId: null,
        ),
      ).future,
    );
  }

  Future<void> _sendLikeNotification(BriefsResult brief, Map<String, String> userDetails) async {
    var requestBody = {
      "type": 'brief liked',
      "sender_id": userDetails['user_id'],
      "sender_name": userDetails['user_name'],
      "receiver_id": brief.userId,
      "notification": "${userDetails['user_name']} liked your brief.",
      "thread_id": brief.id,
    };
    await ref.read(NotificationProvider.postNewNotificationProvider(
      PostNewNotificationParams(requestBody: requestBody),
    ).future);
  }

  void shareBrief(BriefsResult brief) {
    Share.share(
      'Check out this brief by: ${brief.name![0].toUpperCase()}${brief.name!.substring(1)} at\n ${ApiConstants.shareBrief}/${brief.id}',
      subject: 'Check out this brief!',
    );
  }
}
