import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_testing_tutorial/article.dart';
import 'package:flutter_testing_tutorial/news_change_notifier.dart';
import 'package:flutter_testing_tutorial/news_service.dart';
import 'package:mocktail/mocktail.dart';

class MockNewsService extends Mock implements NewsService {}

void main() {
  late NewsChangeNotifier sut; // system under test
  late MockNewsService mockNewsService;
  setUp(() {
    mockNewsService = MockNewsService();
    sut = NewsChangeNotifier(mockNewsService);
  });

  test("check initial value are correct", () {
    expect(sut.articles, []);
    expect(sut.isLoading, false);
  });

  group('getArticles', () {
    final articleFromServices = [
      Article(title: 'article 1', content: 'article 1 content'),
      Article(title: 'article 2', content: 'article 2 content'),
      Article(title: 'article 3', content: 'article 3 content')
    ];
    void arrangeNewsServiceReturns3Articles() {
      when(() => mockNewsService.getArticles()).thenAnswer((_) async => articleFromServices);
    }

    test(
      "gets article using the NewsService",
      () async {
        // arrange
        // implement get articles
        arrangeNewsServiceReturns3Articles();

        // act
        await sut.getArticles();
        // verify that the NewsService.getArticles was called one time

        // assert (check for something)
        verify(() => mockNewsService.getArticles()).called(1);
      },
    );

    test(
      """get articles indicate loading of data,
      sets articles to the ones from the service,
      indicate that data is not loeaded anymore
      """,
      () async {
        arrangeNewsServiceReturns3Articles();
        final future = sut.getArticles();
        expect(sut.isLoading, true);
        await future;
        expect(sut.articles, articleFromServices);
        expect(sut.isLoading, false);
      },
    );
  });
}
