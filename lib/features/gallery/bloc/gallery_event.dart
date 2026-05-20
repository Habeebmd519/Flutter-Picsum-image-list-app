part of 'gallery_bloc.dart';

// import 'package:equatable/equatable.dart';

abstract class GalleryEvent extends Equatable {
  const GalleryEvent();

  @override
  List<Object?> get props => [];
}

class GalleryFetched extends GalleryEvent {
  const GalleryFetched();
}

class GalleryRefreshed extends GalleryEvent {
  const GalleryRefreshed();
}
