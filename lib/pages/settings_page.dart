import 'package:cardexam/database/locale_data.dart';
import 'package:cardexam/dio/internet_service.dart';
import 'package:cardexam/navigation/navigation_service.dart';
import 'package:cardexam/security/security.dart';
import 'package:cardexam/theme/theme_manager.dart';
import 'package:cardexam/widgets/login_page_widgets.dart';
import 'package:cardexam/widgets/my_list_tile.dart';
import 'package:cardexam/widgets/my_modal_bottom_sheet.dart';
import 'package:cardexam/widgets/my_row_tile.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late ScrollController _scrollController;
  late bool _darkMode;
  Widget? _questionsWidgets;

  @override
  void initState() {
    _scrollController = ScrollController();
    _darkMode = false;
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Column questionWithOutInternet() => Column(
        children: const [
          MyListTile(
            title: 'Почему моего учебного заведения нет в списке?',
            subtitle: 'Если вашего учебного заведения нет в списке, '
                'заполните гугл форму',
          ),
          MyListTile(
            title: 'Что даёт регистрация?',
            subtitle: 'Регистрация открывает доступ ко '
                'всем возможностям CardExam',
          ),
          MyListTile(
            title: 'Для чего указывать почту?',
            subtitle: 'Для получения уведомлений и восстановления пароля',
          ),
          MyListTile(
            title: 'Что такое CardExam?',
            subtitle: 'Приложение позволяющее готовиться к любому '
                'материалу в той или иной форме',
          ),
          MyListTile(
            title: 'Могу ли я добавить карточку с эказменом?',
            subtitle: 'Конечно, но для этого необходимо зарегестрироваться. '
                'Гостевой режим позволяет только '
                'смотреть и запускать карточки',
          ),
          SizedBox(
            height: 20,
          ),
        ],
      );

  Future<List<Widget>> _getListWidgetQuestions() async {
    final array = await InternetService.instance.getQuestionHelper();
    final List<Widget> widgetsQuest = <Widget>[];
    for (final quest in array) {
      if (quest.question.substring(0, 4) == 'uri:') {
        widgetsQuest.add(
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 15.0,
              vertical: 15,
            ),
            child: ElevatedButton(
              onPressed: () {
                debugPrint('Открыта ссылка ${quest.question.substring(4)}');
              },
              child: Text(quest.answer),
            ),
          ),
        );
      } else {
        widgetsQuest.add(
          MyListTile(
            title: quest.question,
            subtitle: quest.answer,
          ),
        );
      }
    }
    return widgetsQuest;
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar.large(
              centerTitle: true,
              actions: [
                MyModalBottomSheet(
                  context: context,
                  listWidget: [
                    _questionsWidgets ??
                        FutureBuilder<List<Widget>>(
                          future: _getListWidgetQuestions(),
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              return const Text(
                                'ERROR',
                                style: TextStyle(
                                  fontSize: 22,
                                ),
                              );
                            } else if (snapshot.hasData) {
                              if (snapshot.data!.isEmpty) {
                                _questionsWidgets = questionWithOutInternet();
                                return _questionsWidgets!;
                              } else {
                                _questionsWidgets = Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: List.generate(
                                    snapshot.data!.length,
                                    (index) => snapshot.data![index],
                                  ),
                                );
                                return _questionsWidgets!;
                              }
                            } else {
                              return const Text(
                                'Loading...',
                                style: TextStyle(fontSize: 50),
                              );
                            }
                          },
                        ),
                  ],
                  icon: Icon(
                    Icons.question_mark,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
              ],
              title: Text(
                'Настройки',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
            ),
            // Just some content big enough to have something to scroll.
            SliverToBoxAdapter(
              child: ListView(
                shrinkWrap: true,
                controller: _scrollController,
                children: [
                  Builder(
                    builder: (context) {
                      _darkMode = LocaleData.instance.getDarkTheme();
                      return SwitchListTile(
                        title: const Text('Темная тема'),
                        value: _darkMode,
                        onChanged: (value) async {
                          await ThemeManager.instance.toggleTheme(value);
                          setState(() {
                            _darkMode = value;
                          });
                        },
                      );
                    },
                  ),
                  MyRowTile(
                    title: 'Версия приложения',
                    subtitle: '1.${LocaleData.instance.dbVersion}',
                  ),
                  FutureBuilder(
                    future: SecurityStorage.instance.getSecret(SecretInfo.jwt),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return MyListTile(
                          title: 'JWT',
                          subtitle: snapshot.data.toString(),
                        );
                      } else {
                        return const Text('Загрузка');
                      }
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: BuildLoginBtn(
                      buttonText: 'Очистить кэш',
                      onPressed: () async {
                        await LocaleData.instance.userDeleteAll();
                        await NavigationService.instance
                            .pushNamedAndRemoveUntil(NavigationPaths.start);
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: BuildLoginBtn(
                      onPressed: () async {
                        SecurityStorage.instance.setSecret(
                          SecretInfo.password,
                          '',
                        );
                        SecurityStorage.instance.setSecret(
                          SecretInfo.jwt,
                          '',
                        );
                        await NavigationService.instance
                            .pushNamedAndRemoveUntil(
                          NavigationPaths.selectLogin,
                        );
                      },
                      buttonText: 'Выйти из приложения',
                    ),
                  )
                ],
              ),
              /*child: Card(
                child: SizedBox(
                  height: 1200,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(8, 100, 8, 100),
                    child: Text(
                      'Here be scrolling content...',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ),
                ),
              ),*/
            ),
          ],
        ),
      );
}
