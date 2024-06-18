import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../providers/auth_provider.dart';
import '../../providers/breifs_provider.dart';
import '../../providers/likes_provider.dart';
import '../../widgets/custom_briefs_card.dart';
import 'feed_screen.dart';

class MyBriefsScreen extends ConsumerWidget {
  const MyBriefsScreen({super.key, this.pageController});
  // AsyncValue<List<UserBriefsModel?>?> userBriefs;

  final PageController? pageController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userDetails = ref.watch(userDetailsProvider);
    return ref.watch(getUserBriefsProvider).when(
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
                return CustomBriefsCard(
                  isUserTrue: briefs[index]!.userId == userDetails['userId'] ? true : false,
                  brief: briefs[index],
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
                          threadId: brief.id,
                        ).future);
                      }
                      ref.invalidate(getUserBriefsProvider);
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
