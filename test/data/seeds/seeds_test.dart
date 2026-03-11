import 'package:flutter_test/flutter_test.dart';
import 'package:chrugm12/data/seeds/faq_seeds.dart';
import 'package:chrugm12/data/seeds/notification_seeds.dart';
import 'package:chrugm12/data/seeds/ai_response_seeds.dart';

void main() {
  group('FAQs', () {
    test('has at least 5 FAQ entries', () {
      final faqs = getFaqs();
      expect(faqs.length, greaterThanOrEqualTo(5));
    });

    test('each FAQ has non-empty question and answer', () {
      for (final faq in getFaqs()) {
        expect(faq.question.isNotEmpty, true);
        expect(faq.answer.isNotEmpty, true);
      }
    });
  });

  group('Notifications', () {
    test('has at least 5 notifications', () {
      final notifs = getNotifications();
      expect(notifs.length, greaterThanOrEqualTo(5));
    });

    test('mix of read and unread notifications', () {
      final notifs = getNotifications();
      expect(notifs.any((n) => n.isRead), true);
      expect(notifs.any((n) => !n.isRead), true);
    });
  });

  group('AI Responses', () {
    test('has at least 5 response categories', () {
      final responses = getAiResponses();
      expect(responses.length, greaterThanOrEqualTo(5));
    });

    test('fallback response is not empty', () {
      expect(aiFallbackResponse.isNotEmpty, true);
    });
  });
}
