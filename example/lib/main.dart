import 'package:easy_localization/easy_localization.dart';
import 'package:easy_localization_loader/easy_localization_loader.dart';
import 'package:flutter/material.dart';

import 'lang_view.dart';
import 'utils/multi-languages/locale_keys.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
      supportedLocales: LocaleKeys.supportedLocales,
      path: 'resources/langs/langs.csv',
      // fallbackLocale: Locale('en', 'US'),
      // startLocale: Locale('de', 'DE'),
      // saveLocale: false,
      // useOnlyLangCode: true,

      // optional assetLoader default used is RootBundleAssetLoader which uses flutter's assetloader
      // install easy_localization_loader for enable custom loaders
      // assetLoader: RootBundleAssetLoader()
      // assetLoader: HttpAssetLoader()
      // assetLoader: FileAssetLoader()
      assetLoader: CsvAssetLoader(),
      child: MyApp(),
      // assetLoader: YamlAssetLoader() //multiple files
      // assetLoader: YamlSingleAssetLoader() //single file
      // assetLoader: XmlAssetLoader() //multiple files
      // assetLoader: XmlSingleAssetLoader() //single file
      // assetLoader: CodegenLoader()
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const MyHomePage(title: 'Easy localization'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int counter = 0;
  bool _gender = true;

  void incrementCounter() {
    setState(() {
      counter++;
    });
  }

  void switchGender(bool val) {
    setState(() {
      _gender = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(LocaleKeys.title).tr(),
        //Text(AppLocalizations.of(context).tr('title')),
        actions: <Widget>[
          ElevatedButton(
            child: const Icon(Icons.language),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => LanguageView(), fullscreenDialog: true));
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Spacer(flex: 1),
            Text(
              "",
              style: TextStyle(color: Colors.grey.shade600, fontSize: 19, fontWeight: FontWeight.bold),
            ),
            const Spacer(flex: 1),
            Text(
              "LocaleKeys.gender",
              style: TextStyle(color: Colors.grey.shade600, fontSize: 19, fontWeight: FontWeight.bold),
            ).tr(args: ['aissat'], gender: _gender ? 'female' : 'male'),
            Text(
              LocaleKeys.title.tr(),
              style: TextStyle(color: Colors.grey.shade600, fontSize: 15, fontWeight: FontWeight.bold),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Icon(Icons.male),
                Switch(value: _gender, onChanged: switchGender),
                const Icon(Icons.female),
              ],
            ),
            const Spacer(flex: 1),
            const Text(LocaleKeys.msg).tr(args: ['aissat', 'Flutter']),
            const Text(LocaleKeys.msgNamed).tr(namedArgs: {'lang': 'Dart'}, args: ['Easy localization']),
            const Text(""),
            ElevatedButton(
              onPressed: () {
                context.setLocale(const Locale('vi'));
              },
              child: const Text(LocaleKeys.clickMe).tr(),
            ),
            const SizedBox(height: 15),
            Text(
              "",
              style: TextStyle(color: Colors.grey.shade900, fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                context.deleteSaveLocale();
              },
              child: const Text(""),
            ),
            const Spacer(flex: 1),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: incrementCounter, child: const Text('+1')),
    );
  }
}
