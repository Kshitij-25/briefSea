import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:share_plus/share_plus.dart';

import '../../../data/models/briefs_model.dart';
import '../../../data/models/image_model.dart';
import '../../providers/auth_provider.dart';
import '../../providers/breifs_provider.dart';
import '../../providers/chat_provider.dart';
import '../../providers/likes_provider.dart';
import '../../providers/notification_provider.dart';
import '../../providers/user_profile_provider.dart';
import '../../state_providers/bottom_nav_bar_state_provider.dart';
import '../../widgets/custom_briefs_card.dart';
import 'feed_screen.dart';

class AllBriefsScreen extends ConsumerWidget {
  const AllBriefsScreen({super.key, this.pageController});

  final PageController? pageController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userDetails = ref.watch(userDetailsProvider);
    return ref.watch(getAllBriefsProvider).when(
          data: (briefs) {
            if (briefs == null || briefs.isEmpty) {
              return const Center(
                child: Text('No Briefs Found'),
              );
            }
            return ListView.builder(
              shrinkWrap: true,
              itemCount: briefs.length,
              itemBuilder: (context, index) {
                Future<ImageModel>? postImage;

                // Check if imgSrc is not null before fetching the avatarUrl
                if (briefs[index]!.imgSrc != null) {
                  postImage = ref.watch(getImageProvider(src: briefs[index]!.imgSrc!).future);
                }

                return CustomBriefsCard(
                  isUserTrue: briefs[index]!.userId != userDetails['user_id'] ? false : true,
                  brief: briefs[index],
                  postImage: postImage,
                  onSelected: (value) async {
                    if (value == "message") {
                      var isChatCreated = await ref.watch(createNewChatProvider(
                        receiverId: briefs[index]!.userId!,
                        senderId: userDetails['user_id']!,
                      ).future);

                      if (isChatCreated == true) {
                        pageController?.jumpToPage(1);
                        ref.read(currentIndexProvider.notifier).state = 1;
                        //   // context.push(ChatScreen.routeName);
                        //   // isChatCreated = false;
                      }
                    }
                  },
                  onCommentTap: (brief) {
                    context.push(
                      FeedScreen.routeName,
                      extra: {'allBrief': briefs[index]},
                    );
                  },
                  onLikeTap: (brief) async {
                    try {
                      if (!brief!.isPostLiked) {
                        await ref.read(postLikeProvider(
                          threadId: brief.id,
                          type: userDetails['type'],
                          uName: userDetails['user_name'],
                          userId: userDetails['user_id'],
                          replyId: null,
                        ).future);
                        if (brief.userId != userDetails['user_id']) {
                          await ref.read(postNewNotificationProvider(
                            requestBody: {
                              "type": 'brief liked',
                              "sender_id": userDetails['user_id'],
                              "sender_name": userDetails['user_name'],
                              "receiver_id": brief.userId,
                              "notification": "${userDetails['user_name']} liked your brief.",
                              "thread_id": brief.id,
                            },
                          ).future);
                        }
                      } else {
                        await ref.read(deleteLikeProvider(
                          likeId: brief.postLikeId,
                          threadId: brief.id,
                        ).future);
                      }
                      ref.invalidate(getAllBriefsProvider);
                    } catch (e) {
                      log(e.toString());
                    }
                  },
                  onShareTap: (brief) {
                    shareBrief(brief!);
                  },
                  onTap: () {
                    context.push(
                      FeedScreen.routeName,
                      extra: {'allBrief': briefs[index]},
                    );
                  },
                );
              },
            );
          },
          error: (error, stackTrace) {
            return Center(child: Text('Error: $error'));
          },
          loading: () => const Center(
            child: CircularProgressIndicator.adaptive(),
          ),
        );
  }

  void shareBrief(BriefsModel brief) {
    Share.share(
      'Check out this brief by: ${brief.name![0].toUpperCase()}${brief.name!.substring(1)}\n${brief.postText}',
      subject: 'Check out this brief!',
    );
  }
}
