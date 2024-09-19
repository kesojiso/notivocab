import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notivocab/src/controller/create_notification.dart';
import 'package:notivocab/src/model/schema/schema_quiz_scope.dart';
import 'package:notivocab/src/view/component/card.dart';
import '../../../constants.dart';
import '../../../controller/provider/setting_quiz_scope.dart';

class QuizScopeSettingPage extends ConsumerWidget {
  const QuizScopeSettingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final QuizScope quizScope = ref.watch(scopeSelectedProvider).quizScope;
    if (quizScope.entry == null ||
        quizScope.intermediate == null ||
        quizScope.advanced == null) {
      return const CircularProgressIndicator();
    } else {
      return PopScope(
        onPopInvoked: (bool result) {
          ref.invalidate(scopeSelectedProvider);
        },
        child: Scaffold(
          backgroundColor: primaryColor,
          appBar: AppBar(
            title: const Text('出題範囲'),
          ),
          body: SafeArea(
            child: Center(
              child: SizedBox(
                height: 500,
                child: Column(
                  children: [
                    quizScopeCard(
                      checked: quizScope.entry!,
                      title: '初級',
                      onChanged: (bool? checkedValue) {
                        quizScope.entry = checkedValue;
                        ref
                            .read(scopeSelectedProvider.notifier)
                            .updateVal(quizScope);
                      },
                    ),
                    quizScopeCard(
                      checked: quizScope.intermediate!,
                      title: '中級',
                      onChanged: (bool? checkedValue) {
                        quizScope.intermediate = checkedValue;
                        ref
                            .read(scopeSelectedProvider.notifier)
                            .updateVal(quizScope);
                      },
                    ),
                    quizScopeCard(
                      checked: quizScope.advanced!,
                      title: '上級',
                      onChanged: (bool? checkedValue) {
                        quizScope.advanced = checkedValue;
                        ref
                            .read(scopeSelectedProvider.notifier)
                            .updateVal(quizScope);
                      },
                    ),
                    quizScopeCard(
                      checked: quizScope.myWordList!,
                      title: 'My単語帳',
                      onChanged: (bool? checkedValue) {
                        quizScope.myWordList = checkedValue;
                        ref
                            .read(scopeSelectedProvider.notifier)
                            .updateVal(quizScope);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
              backgroundColor: buttonColor,
              onPressed: () {
                ref.read(scopeSelectedProvider.notifier).setScopeSelected();
                ref.invalidate(scopeSelectedProvider);
                setNotificationList();
                context.pop();
              },
              child: const Icon(Icons.save, color: primaryColor, size: 40)),
        ),
      );
    }
  }
}
