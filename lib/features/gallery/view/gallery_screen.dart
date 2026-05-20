import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/gallery_bloc.dart';
import 'widgets/image_card.dart';

class GalleryScreen extends StatelessWidget {
  const GalleryScreen({super.key});

  Future<void> _refresh(BuildContext context) async {
    context.read<GalleryBloc>().add(const GalleryRefreshed());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<GalleryBloc, GalleryState>(
        builder: (context, state) {
          return CustomScrollView(
            physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
            slivers: [
              SliverAppBar(
                pinned: true,
                expandedHeight: 170,
                elevation: 0,
                backgroundColor: Colors.white,
                surfaceTintColor: Colors.white,
                flexibleSpace: FlexibleSpaceBar(
                  titlePadding: const EdgeInsets.only(left: 20, bottom: 18),
                  title: const Text(
                    'Picsum Gallery',
                    style: TextStyle(
                      color: Color(0xff111827),
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  background: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xffdbeafe), Color(0xfff8fafc)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.fromLTRB(20, 70, 20, 20),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Browse beautiful moments captured by photographers around the world.',
                          style: TextStyle(
                            color: Color(0xff475569),
                            fontSize: 15,
                            height: 1.4,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              if (state.status == GalleryStatus.loading)
                const SliverFillRemaining(
                  child: Center(child: CircularProgressIndicator()),
                ),

              if (state.status == GalleryStatus.failure)
                SliverFillRemaining(child: _ErrorView(message: state.message)),

              if (state.status == GalleryStatus.success && state.images.isEmpty)
                const SliverFillRemaining(
                  child: Center(child: Text('No images found.')),
                ),

              if (state.status == GalleryStatus.success &&
                  state.images.isNotEmpty)
                CupertinoSliverRefreshWrapper(
                  onRefresh: () => _refresh(context),
                  child: SliverPadding(
                    padding: const EdgeInsets.all(16),
                    sliver: SliverList.separated(
                      itemCount: state.images.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 16),
                      itemBuilder: (context, index) {
                        final image = state.images[index];

                        return ImageCard(image: image, index: index);
                      },
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}

class CupertinoSliverRefreshWrapper extends StatelessWidget {
  final Future<void> Function() onRefresh;
  final Widget child;

  const CupertinoSliverRefreshWrapper({
    super.key,
    required this.onRefresh,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return SliverMainAxisGroup(
      slivers: [
        CupertinoSliverRefreshControlAdapter(onRefresh: onRefresh),
        child,
      ],
    );
  }
}

class CupertinoSliverRefreshControlAdapter extends StatelessWidget {
  final Future<void> Function() onRefresh;

  const CupertinoSliverRefreshControlAdapter({
    super.key,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: RefreshIndicator(
        onRefresh: onRefresh,
        child: const SizedBox.shrink(),
      ),
    );
  }
}

class _ErrorView extends StatelessWidget {
  final String message;

  const _ErrorView({required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Container(
          padding: const EdgeInsets.all(22),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(22),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.06),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.wifi_off_rounded,
                size: 52,
                color: Colors.redAccent,
              ),
              const SizedBox(height: 14),
              const Text(
                'Oops, something went wrong',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
              ),
              const SizedBox(height: 8),
              Text(
                message,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Color(0xff64748b), height: 1.4),
              ),
              const SizedBox(height: 18),
              ElevatedButton.icon(
                onPressed: () {
                  context.read<GalleryBloc>().add(const GalleryFetched());
                },
                icon: const Icon(Icons.refresh_rounded),
                label: const Text('Try again'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
