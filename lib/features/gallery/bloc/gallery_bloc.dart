import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/gallery_repository.dart';
import '../data/image_model.dart';

part 'gallery_event.dart';
part 'gallery_state.dart';

class GalleryBloc extends Bloc<GalleryEvent, GalleryState> {
  final GalleryRepository repository;

  GalleryBloc({required this.repository}) : super(const GalleryState()) {
    on<GalleryFetched>(_onGalleryFetched);
    on<GalleryRefreshed>(_onGalleryRefreshed);
  }

  Future<void> _onGalleryFetched(
    GalleryFetched event,
    Emitter<GalleryState> emit,
  ) async {
    emit(state.copyWith(status: GalleryStatus.loading));

    try {
      final images = await repository.fetchImages();

      emit(
        state.copyWith(
          status: GalleryStatus.success,
          images: images,
          message: '',
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: GalleryStatus.failure,
          message: e.toString().replaceFirst('Exception: ', ''),
        ),
      );
    }
  }

  Future<void> _onGalleryRefreshed(
    GalleryRefreshed event,
    Emitter<GalleryState> emit,
  ) async {
    try {
      final images = await repository.fetchImages();

      emit(
        state.copyWith(
          status: GalleryStatus.success,
          images: images,
          message: '',
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: GalleryStatus.failure,
          message: e.toString().replaceFirst('Exception: ', ''),
        ),
      );
    }
  }
}
