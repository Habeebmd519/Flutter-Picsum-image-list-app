import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/gallery/bloc/gallery_bloc.dart';
import 'features/gallery/data/gallery_repository.dart';
import 'features/gallery/view/gallery_screen.dart';

class PicsumGalleryApp extends StatelessWidget {
  const PicsumGalleryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (_) => GalleryRepository(),
      child: BlocProvider(
        create: (context) =>
            GalleryBloc(repository: context.read<GalleryRepository>())
              ..add(const GalleryFetched()),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Picsum Gallery',
          theme: ThemeData(
            useMaterial3: true,
            fontFamily: 'Roboto',
            colorScheme: ColorScheme.fromSeed(
              seedColor: const Color(0xff2563eb),
              brightness: Brightness.light,
            ),
            scaffoldBackgroundColor: const Color(0xfff5f7fb),
          ),
          home: const GalleryScreen(),
        ),
      ),
    );
  }
}
