import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';
import 'package:vortasks/models/enums/difficulty.dart';
import 'package:vortasks/screens/tasks/widgets/task_button.dart';
import 'package:vortasks/screens/tasks/widgets/task_form.dart';
import 'package:vortasks/screens/tasks/widgets/switch_field.dart';
import 'package:vortasks/stores/tasks/task_form_store.dart';
import 'package:vortasks/stores/user_data/skill/skill_store.dart';
import 'package:vortasks/stores/tasks/task_store.dart';

class MockTaskStore extends Mock implements TaskStore {}

class MockSkillStore extends Mock implements SkillStore {}

void main() {
  late TaskFormStore addTaskStore;
  late MockTaskStore mockTaskStore;
  late MockSkillStore mockSkillStore;

  setUp(() {
    addTaskStore = TaskFormStore();
    mockTaskStore = MockTaskStore();
    mockSkillStore = MockSkillStore();

    GetIt.I.registerSingleton<TaskStore>(mockTaskStore);
    GetIt.I.registerSingleton<SkillStore>(mockSkillStore);
  });

  tearDown(() {
    GetIt.I.reset();
  });

  group('AddTaskForm', () {
    testWidgets('Renderização e Estados Iniciais', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TaskForm(
              addTaskStore: addTaskStore,
              addTaskButton: TaskButton(
                selectedType: addTaskStore.selectedType,
                onPressed: () {},
                addTaskStore: addTaskStore,
                label: 'Adicionar Tarefa',
              ),
            ),
          ),
        ),
      );

      // Verificar se os campos principais são renderizados
      expect(find.byType(TextField), findsNWidgets(2)); // Título e Descrição
      expect(find.text('Dificuldade'), findsOneWidget);
      expect(find.text('Tema da Tarefa:'), findsOneWidget);
      expect(find.text('Dia Inteiro'), findsOneWidget);
      expect(find.text('Data de Termino:'), findsOneWidget);
      expect(find.text('Repetição'), findsOneWidget);
      expect(find.text('Lembrete'), findsOneWidget);
      expect(find.byType(ElevatedButton), findsOneWidget);

      // Verificar estados iniciais
      expect(addTaskStore.title, isNull);
      expect(addTaskStore.description, isNull);
      expect(addTaskStore.selectedDifficulty, Difficulty.MEDIUM);
      expect(addTaskStore.selectedTaskTheme, isNull);
      expect(addTaskStore.allDayEnabled, true);
      expect(addTaskStore.startDateEnabled, false);
      expect(addTaskStore.repetitionEnabled, false);
      expect(addTaskStore.reminderEnabled, false);
    });

    testWidgets('Switch - Dia Inteiro', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
            body: TaskForm(
          addTaskStore: addTaskStore,
          addTaskButton: TaskButton(
            selectedType: addTaskStore.selectedType,
            onPressed: () {},
            addTaskStore: addTaskStore,
            label: 'Adicionar Tarefa',
          ),
        )),
      ));

      // Verificar se a Hora do Término está inicialmente oculta
      // Encontrar o SwitchField que contém o texto "Dia Inteiro"
      final diaInteiroSwitchField =
          find.widgetWithText(SwitchField, 'Dia Inteiro');

      // Encontrar o Switch dentro do SwitchField
      final diaInteiroSwitch = find.descendant(
        of: diaInteiroSwitchField,
        matching: find.byType(Switch),
      );

      // Verificar se a Hora do Término está inicialmente oculta
      expect(find.text('Hora do Término'), findsNothing);

      // Simular a desativação do 'Dia Inteiro'
      await tester.tap(diaInteiroSwitch); // Toca no Switch encontrado
      await tester.pumpAndSettle();

      // Verificar se a Hora do Término é exibida
      expect(find.text('Hora do Término'), findsOneWidget);

      // Simular a ativação do 'Dia Inteiro'
      await tester.tap(diaInteiroSwitch); // Toca no Switch encontrado
      await tester.pumpAndSettle();

      // Verificar se a Hora do Término é ocultada novamente
      expect(find.text('Hora do Término'), findsNothing);
    });

    testWidgets(
        'Preenchimento de Campos e Seleção de Opções - Título e Descrição',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TaskForm(
              addTaskStore: addTaskStore,
              addTaskButton: TaskButton(
                selectedType: addTaskStore.selectedType,
                onPressed: () {},
                addTaskStore: addTaskStore,
                label: 'Adicionar Tarefa',
              ),
            ),
          ),
        ),
      );

      // Preencher o campo Título
      final titleField = find.byType(TextField).first;
      await tester.enterText(titleField, 'Título da Tarefa');
      expect(addTaskStore.title, 'Título da Tarefa');

      // Preencher o campo Descrição
      final descriptionField = find.byType(TextField).at(1);
      await tester.enterText(descriptionField, 'Descrição da Tarefa');
      expect(addTaskStore.description, 'Descrição da Tarefa');
    });

    testWidgets('Seleção de Opções - Dificuldade', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TaskForm(
              addTaskStore: addTaskStore,
              addTaskButton: TaskButton(
                selectedType: addTaskStore.selectedType,
                onPressed: () {},
                addTaskStore: addTaskStore,
                label: 'Adicionar Tarefa',
              ),
            ),
          ),
        ),
      );

      // Selecionar 'Difícil'
      await tester.tap(find.text('Difícil'));
      await tester.pumpAndSettle();
      expect(addTaskStore.selectedDifficulty, Difficulty.HARD);

      // Selecionar 'Fácil'
      await tester.tap(find.text('Fácil'));
      await tester.pumpAndSettle();
      expect(addTaskStore.selectedDifficulty, Difficulty.EASY);
    });
  });
}
