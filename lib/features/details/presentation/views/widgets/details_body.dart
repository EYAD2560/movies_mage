import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_mage/core/widgets/shimmer/details_shimmer.dart';
import 'package:movies_mage/features/details/presentation/manger/details/details_cubit.dart';
import 'package:movies_mage/features/details/presentation/views/widgets/sections/details.dart';
import 'package:movies_mage/core/global_model.dart';

class DetailsBody extends StatelessWidget {
  const DetailsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DetailsCubit, DetailsState>(
      builder: (context, state) {
        if (state is DetailsLoading) {
          return const DetailShimmer();
        }

        if (state is DetailsFailed) {
          return Center(
            child: Text(
              state.error,
              style: const TextStyle(color: Colors.white),
            ),
          );
        }

        if (state is DetailsSuccess) {
          // ✅ Convert data to GlobalModel
          final model = GlobalModel(
            id: state.data.id,
            name: state.data.name,
            backdropImage: state.data.backdropImage,
            overview: state.data.overview,
            poster: state.data.poster,
            releaseDate: state.data.releaseDate,
            rate: state.data.rate.toString(),
            genres: state.genres,
            mediaType: state.contentType == 'anime' ? 'tv' : state.contentType,
          );

          return DetailsBodyStack(model: model);
        }

        return const SizedBox();
      },
    );
  }
}

