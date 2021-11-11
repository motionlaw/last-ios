import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import 'style/theme.dart' as Theme;
import 'ui/common/loading.dart';
import 'ui/modules/cases_detailed.dart';
import 'ui/modules/chat.dart';
import 'ui/modules/communications.dart';
import 'ui/modules/home.dart';
import 'ui/modules/Auth/login/login.dart';
import 'ui/modules/Auth/login/register.dart';
import 'ui/modules/payment.dart';
import 'ui/modules/refer.dart';
import 'ui/modules/reviews.dart';
import 'ui/modules/settings.dart';
import 'ui/modules/support.dart';
import 'ui/modules/blog.dart';
import 'ui/modules/blog_id.dart';
import 'ui/modules/consultation.dart';
import '/generated/l10n.dart';

/* Services. */
import 'services/PushNotificationService.dart';
import 'services/SlackNotificationService.dart';

LoginScreen appAuth = new LoginScreen();
Widget defaultHome = new LoginScreen();

void main(context) async {
  WidgetsFlutterBinding.ensureInitialized();
  final dir = await getApplicationDocumentsDirectory();
  Hive.init(dir.path);

  await PushNotificationService.initializeApp();

  bool _result = await appAuth.checkStatus();
  if (_result == true) {
    defaultHome = new HomePage();
  }

  FlutterError.onError = (FlutterErrorDetails details) {
    SlackNotificationService.sendSlackMessage(details.toString());
  };

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Motion Law.',
        theme: new ThemeData(
            primaryColor: Theme.Colors.motionTmBlue,
        ),
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          Translate.delegate,
        ],
        supportedLocales: Translate.delegate.supportedLocales,
        home: defaultHome,
        routes: {
          '/freeConsultation': (context) => ConsultationPage(),
          '/home': (context) => HomePage(),
          '/login': (context) => LoginScreen(),
          '/register': (context) => RegisterScreen(),
          '/loading': (context) => LoadingPage(),
          '/communication': (context) => CommunicationPage(),
          '/casesDetailed': (context) => CasesDetailed(),
          '/chat': (context) => ChatPage(),
          '/payment': (context) => PaymentPage(),
          '/settings': (context) => SettingsPage(),
          '/support': (context) => SupportPage(),
          '/refer': (context) => ReferPage(),
          '/reviews': (context) => ReviewsPage(),
          '/blog': (context) => BlogPage(),
          '/blog-id': (context) => BlogIdPage()
        });
  }
}