import 'dart:developer';

import 'package:briefsea/data/models/image_model.dart';
import 'package:briefsea/presentation/providers/chat_provider.dart';
import 'package:briefsea/presentation/providers/likes_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../providers/auth_provider.dart';
import '../../providers/breifs_provider.dart';
import '../../providers/user_profile_provider.dart';
import '../../widgets/custom_briefs_card.dart';
import '../messages/chat_screen.dart';
import 'feed_screen.dart';

class AllBriefsScreen extends ConsumerWidget {
  const AllBriefsScreen({super.key});

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
                Future<ImageModel>? avatarUrl;

                // Check if imgSrc is not null before fetching the avatarUrl
                if (briefs[index]!.imgSrc != null) {
                  avatarUrl = ref.watch(getImageProvider(src: briefs[index]!.imgSrc!).future);
                }

                return CustomBriefsCard(
                  isUserTrue: briefs[index]!.userId != userDetails['user_id'] ? false : true,
                  brief: briefs[index],
                  avatarUrl: avatarUrl,
                  onSelected: (value) async {
                    if (value == "message") {
                      var isChatCreated = await ref.watch(createNewChatProvider(
                        receiverId: briefs[index]!.userId!,
                        senderId: userDetails['user_id']!,
                      ).future);

                      if (isChatCreated == true) {
                        context.push(ChatScreen.routeName);
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
                      } else {
                        await ref.read(deleteLikeProvider(
                          likeId: brief.postLikeId,
                          type: userDetails['type'],
                          uName: userDetails['user_name'],
                          userId: userDetails['user_id'],
                          threadId: brief.id,
                          replyId: null,
                        ).future);
                      }
                      ref.invalidate(getAllBriefsProvider);
                    } catch (e) {
                      log(e.toString());
                    }
                  },
                  onShareTap: (brief) {},
                  onTap: () {
                    context.push(
                      FeedScreen.routeName,
                      extra: {'allBrief': briefs[index]},
                    );
                  },
                );
                return null;
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
}
