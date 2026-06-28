import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/error/failure.dart';
import '../../../../shared/widgets/widgets.dart';
import '../../../materials/data/material_providers.dart';
import '../../../materials/presentation/widgets/material_view.dart';

/// Просмотр одного материала студентом (ТЗ §5.4, шаг 16).
class StudentMaterialViewScreen extends ConsumerWidget {
  const StudentMaterialViewScreen({
    super.key,
    required this.courseId,
    required this.materialId,
  });

  final String courseId;
  final String materialId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final materialAsync = ref.watch(materialByIdProvider(materialId));

    return AppScaffold(
      title: materialAsync.valueOrNull?.title.isNotEmpty ?? false
          ? materialAsync.value!.title
          : 'Материал',
      body: materialAsync.when(
        data: (material) {
          if (material == null) {
            return const AppEmptyView(message: 'Материал не найден');
          }
          return SingleChildScrollView(
            child: MaterialView(material: material),
          );
        },
        loading: () => const AppLoader(),
        error: (e, _) => AppErrorView(
          failure: e as Failure,
          onRetry: () => ref.invalidate(materialByIdProvider(materialId)),
        ),
      ),
    );
  }
}
