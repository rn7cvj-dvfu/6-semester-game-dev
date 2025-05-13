import 'package:go_router/go_router.dart';

extension PathExtension on GoRouterState {
  String get fullPathWithQuery {
    final query = uri.queryParameters.entries
        .map((e) => '${e.key}=${e.value}')
        .join('&');

    return '${uri.toFilePath()}${query.isNotEmpty ? '?$query' : ''}';
  }
}
