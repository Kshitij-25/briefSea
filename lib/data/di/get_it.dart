import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../core/api_client.dart';
import '../data_sources/auth_remote_data_source.dart';
import '../data_sources/briefs_remote_data_source.dart';
import '../data_sources/chat_remote_data_source.dart';
import '../data_sources/like_remote_data_source.dart';
import '../data_sources/reply_remote_data_source.dart';
import '../data_sources/user_profile_remote_data_source.dart';
import '../repositories/auth_repository.dart';
import '../repositories/breifs_repository.dart';
import '../repositories/chat_repository.dart';
import '../repositories/like_repository.dart';
import '../repositories/reply_repository.dart';
import '../repositories/user_profile_repository.dart';

final getItInstance = GetIt.I;

Future init() async {
  getItInstance.registerLazySingleton<Dio>(() => Dio()
    ..interceptors.add(LogInterceptor(
      requestHeader: false,
      requestBody: false,
      request: false,
      responseBody: false,
      responseHeader: false,
      error: false,
    )));

  getItInstance.registerLazySingleton<ApiClient>(() => ApiClient(getItInstance()));

  getItInstance.registerLazySingleton<AuthRemoteDataSource>(() => AuthRemoteDataSourceImpl(getItInstance()));

  getItInstance.registerLazySingleton<AuthRepository>(() => AuthRepository(getItInstance()));

  getItInstance.registerLazySingleton<UserProfileRemoteDataSource>(() => UserProfileRemoteDataSourceImpl(getItInstance()));

  getItInstance.registerLazySingleton<UserProfileRepository>(() => UserProfileRepository(getItInstance()));

  getItInstance.registerLazySingleton<BriefsRemoteDataSource>(() => BriefsRemoteDataSourceImpl(getItInstance()));

  getItInstance.registerLazySingleton<BreifsRepository>(() => BreifsRepository(getItInstance()));

  getItInstance.registerLazySingleton<LikeRemoteDataSource>(() => LikeRemoteDataSourceImpl(getItInstance()));

  getItInstance.registerLazySingleton<LikeRepository>(() => LikeRepository(getItInstance()));

  getItInstance.registerLazySingleton<ReplyRemoteDataSource>(() => ReplyRemoteDataSourceImpl(getItInstance()));

  getItInstance.registerLazySingleton<ReplyRepository>(() => ReplyRepository(getItInstance()));

  getItInstance.registerLazySingleton<ChatRemoteDataSource>(() => ChatRemoteDataSourceImpl(getItInstance()));

  getItInstance.registerLazySingleton<ChatRepository>(() => ChatRepository(getItInstance()));
}
