import 'package:news_app/model/news.dart';
import 'package:rss_dart/domain/rss_feed.dart';
import 'package:http/http.dart' as http;

class Api {
  static List<News> newsList = [];
  static RssFeed? rssFeed;
  
  static Future<RssFeed?> getDataRss({String? lang}) async{
    final url = Uri.parse('https://uzreport.news/feed/rss/$lang');
    final response = await http.get(url);
    rssFeed = RssFeed.parse(response.body);
    
    if (response.statusCode == 200) {
      
      for (var item in rssFeed!.items) {
        newsList.add(News(
          title: item.title ?? '404', 
          description: item.description ?? '404', 
          link: item.link ?? '404', 
          date: item.pubDate ?? '', 
          imageUrl: item.enclosure?.url ?? 'https://www.google.com/url?sa=i&url=https%3A%2F%2Fvitas1917.livejournal.com%2F2105776.html&psig=AOvVaw0EGwfJRDrz2E4mNxJnsvFe&ust=1706102403648000&source=images&cd=vfe&opi=89978449&ved=0CBAQjRxqFwoTCKiSy_TM84MDFQAAAAAdAAAAABAD',
            ),
          );
      }
      
      
    }else{
      throw Exception('Error ${response.statusCode}');
    }
    
    return rssFeed;
    
 }
}