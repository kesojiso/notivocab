import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../constants.dart';
import '../../../model/setting_word_section.dart';

class WordSectionSettingPage extends ConsumerWidget {
  const WordSectionSettingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final checkedList = ref.watch(scopeSelectedProvider).scopeSelected;
    if (checkedList.isEmpty) {
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
                child: ListView.builder(
                  padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                  itemCount: examScope.length,
                  itemBuilder: (context, index) {
                    return Card(
                      color: checkedList[index] ? buttonColor : nonActiveColor,
                      child: CheckboxListTile(
                        value: checkedList[index],
                        title: SizedBox(
                          height: 80,
                          child: Center(
                            child: Text(
                              examScope[index],
                              style: buttonTextStyle,
                            ),
                          ),
                        ),
                        onChanged: (bool? checkedValue) {
                          checkedList[index] = checkedValue!;
                          ref
                              .read(scopeSelectedProvider.notifier)
                              .updateList(checkedList);
                        },
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
              backgroundColor: buttonColor,
              onPressed: () {
                ref.read(scopeSelectedProvider.notifier).setScopeSelected();
                ref.invalidate(scopeSelectedProvider);
                context.pop();
              },
              child: const Icon(Icons.save, color: primaryColor, size: 40)),
        ),
      );
    }
  }
}
