import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/bloc/news_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

enum PopUpItem { ru, oz, en }

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    PopUpItem? item;
    return Scaffold(
      appBar: AppBar(
        leading: PopupMenuButton(
          itemBuilder: (context) => <PopupMenuEntry<PopUpItem>>[
            const PopupMenuItem(
              value: PopUpItem.ru,
              child: Text('Ru'),
            ),
            const PopupMenuItem(
              value: PopUpItem.oz,
              child: Text('Uz'),
            ),
            const PopupMenuItem(
              value: PopUpItem.en,
              child: Text('En'),
            ),
          ],
          icon: const Icon(Icons.language),
          initialValue: item,
          onSelected: (value) {
            item = value;
            if (item == PopUpItem.ru) {
              context.read<NewsBloc>().add(NewsLoadEvent());
            }else if (item ==PopUpItem.oz){
              context.read<NewsBloc>().add(NewsLoadOzEvent());
            }else{
               context.read<NewsBloc>().add(NewsLoadEnEvent());
            }
          },
        ),
        title: const Text(
          'Stydy App New',
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
      ),
      body: const NewsBody(),
    );
  }
}

class NewsBody extends StatelessWidget {
  const NewsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewsBloc, NewsState>(
      builder: (context, state) {
        if (state is NewsLoadingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is NewsErrorState) {
          return const Center(
            child: Text('No data received'),
          );
        }
        if (state is NewsLoadedState) {
          final item = state.newsFeed?.items;
          return Column(
            children: [
              SizedBox(
                height: 250,
                child: CarouselSlider.builder(
                    itemCount: item?.length,
                    itemBuilder: (context, index, i) {
                      return CachedNetworkImage(
                          imageUrl: '${item?[index].enclosure?.url}');
                    },
                    options: CarouselOptions(
                      enlargeCenterPage: true,
                      autoPlay: true,
                    )),
              ),
              Expanded(
                child: ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemBuilder: (context, i) {
                      return GestureDetector(
                        onTap: ()async{
                          final url = Uri.parse('${item?[i].link}');
                          try {
                           await launchUrl(url); 
                          } catch (e) {
                            throw'$e';
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.grey[400],
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  bottomLeft: Radius.circular(20),
                                ),
                                child: CachedNetworkImage(
                                  imageUrl: '${item?[i].enclosure?.url}',
                                  width: 120,
                                  //height: 120,
                                ),
                              ),
                              const SizedBox(width: 10),
                              ConstrainedBox(
                                constraints: const BoxConstraints(maxWidth: 190),
                                child: Text('${item?[i].title}',),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, i) => const SizedBox(
                          height: 8,
                        ),
                    itemCount: item?.length ?? 0),
              ),
            ],
          );
        }
        return const SizedBox();
      },
    );
  }
}
