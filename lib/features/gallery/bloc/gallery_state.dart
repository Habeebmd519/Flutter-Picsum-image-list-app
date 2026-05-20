part of 'gallery_bloc.dart';

enum GalleryStatus { initial, loading, success, failure }

class GalleryState extends Equatable {
  final GalleryStatus status;
  final List<ImageModel> images;
  final String message;

  const GalleryState({
    this.status = GalleryStatus.initial,
    this.images = const [],
    this.message = '',
  });

  GalleryState copyWith({
    GalleryStatus? status,
    List<ImageModel>? images,
    String? message,
  }) {
    return GalleryState(
      status: status ?? this.status,
      images: images ?? this.images,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [status, images, message];
}
