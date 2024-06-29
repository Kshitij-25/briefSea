import 'dart:developer';

import 'package:briefsea/data/models/briefs_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../providers/auth_provider.dart';
import '../../providers/breifs_provider.dart';
import '../../providers/likes_provider.dart';
import '../../state_providers/briefs_state_provider.dart';
import '../../widgets/custom_briefs_card.dart';
import 'feed_screen.dart';

class MyBriefsScreen extends ConsumerWidget {
  const MyBriefsScreen({super.key, this.pageController});
  // AsyncValue<List<UserBriefsModel?>?> userBriefs;

  final PageController? pageController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userDetails = ref.watch(userDetailsProvider);
    final selectedFilter = ref.watch(selectedBriefsFilter);

    return ref.watch(getUserBriefsProvider).when(
          data: (briefs) {
            if (briefs == null || briefs.isEmpty) {
              return const Center(
                child: Text('All the briefs you’ve posted will be here'),
              );
            }
            List<BriefsModel?> filteredBriefs = briefs.where((brief) {
              if (selectedFilter == 'All') {
                return true;
              } else if (selectedFilter == 'Public') {
                return brief!.isVisible == true;
              } else if (selectedFilter == 'Private') {
                return brief!.isVisible == false;
              }
              return false;
            }).toList();
            return Column(
              children: [
                Row(
                  children: [
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all<Color>(
                          const Color(0xFF4B26FD),
                        ),
                      ),
                      onPressed: () {
                        ref.read(selectedBriefsFilter.notifier).setFilter('All');
                        ref.invalidate(getUserBriefsProvider);
                      },
                      child: const Text(
                        'All',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    const SizedBox(width: 5),
                    ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all<Color>(
                        const Color(0xFF4B26FD),
                      )),
                      onPressed: () {
                        ref.read(selectedBriefsFilter.notifier).setFilter('Public');
                        ref.invalidate(getUserBriefsProvider);
                      },
                      child: const Text(
                        'Public',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    const SizedBox(width: 5),
                    ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all<Color>(
                        const Color(0xFF4B26FD),
                      )),
                      onPressed: () {
                        ref.read(selectedBriefsFilter.notifier).setFilter('Private');
                        ref.invalidate(getUserBriefsProvider);
                      },
                      child: const Text(
                        'Private',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: filteredBriefs.isEmpty && selectedFilter == "Private"
                      ? const Center(
                          child: Text('All the private briefs you’ve posted will be here'),
                        )
                      : filteredBriefs.isEmpty
                          ? const Center(
                              child: Text('All the public briefs you’ve posted will be here'),
                            )
                          : ListView.builder(
                              shrinkWrap: true,
                              itemCount: filteredBriefs.length,
                              itemBuilder: (context, index) {
                                return CustomBriefsCard(
                                  isUserTrue: filteredBriefs[index]!.userId == userDetails['user_id'] ? true : false,
                                  brief: filteredBriefs[index],
                                  onSelected: (value) async {
                                    if (value == "delete") {
                                      var isDeleted = await ref.watch(deleteBriefProvider(briefId: filteredBriefs[index]?.id).future);
                                      if (isDeleted == true) {
                                        ref.invalidate(getUserBriefsProvider);
                                      }
                                    } else if (value == "visible") {
                                      var isVisible = await ref.watch(
                                          editBriefProvider(briefId: filteredBriefs[index]?.id, isVisible: !filteredBriefs[index]!.isVisible!)
                                              .future);
                                      if (isVisible == true) {
                                        ref.invalidate(getUserBriefsProvider);
                                      }
                                    }
                                  },
                                  onCommentTap: (brief) async {
                                    var singleBrief = await ref.read(getSingleBriefProvider(briefId: filteredBriefs[index]!.id).future);
                                    context.push(
                                      FeedScreen.routeName,
                                      extra: {'singleBrief': singleBrief},
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
                                  onTap: () async {
                                    var singleBrief = await ref.read(getSingleBriefProvider(briefId: filteredBriefs[index]!.id).future);
                                    context.push(
                                      FeedScreen.routeName,
                                      extra: {'singleBrief': singleBrief},
                                    );
                                  },
                                );
                              },
                            ),
                ),
              ],
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
