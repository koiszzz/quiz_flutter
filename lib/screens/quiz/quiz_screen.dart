import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:quiz_flutter/l10n/app_localizations.dart';
import 'package:quiz_flutter/models/models.dart';
import 'package:quiz_flutter/providers/bank_list_provider.dart';
import 'package:quiz_flutter/services/database_helper.dart';

class QuizScreen extends ConsumerStatefulWidget {
  const QuizScreen({super.key});

  @override
  ConsumerState<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends ConsumerState<QuizScreen> {
  bool _isPracticeExpanded = true;
  bool _isExamExpanded = false;

  final _practiceFormKey = GlobalKey<FormState>();
  final _examFormKey = GlobalKey<FormState>();

  // Practice Mode State
  int? _practiceSelectedBankId;
  final _practiceSingleController = TextEditingController(text: '0');
  final _practiceMultipleController = TextEditingController(text: '0');
  final _practiceTrueFalseController = TextEditingController(text: '0');
  final _practiceDurationController = TextEditingController(text: '0');
  bool _practiceShuffleQuestions = false;
  bool _practiceShuffleOptions = false;
  bool _practiceWithoutTaken = true;

  // Exam Mode State
  int? _examSelectedBankId;
  final _examSingleController = TextEditingController(text: '0');
  final _examMultipleController = TextEditingController(text: '0');
  final _examTrueFalseController = TextEditingController(text: '0');
  final _examDurationController = TextEditingController(text: '0');
  bool _examShuffleQuestions = true;
  bool _examShuffleOptions = true;

  final Map<int, int> _singleCount = {};
  final Map<int, int> _multipleCount = {};
  final Map<int, int> _trueFalseCount = {};

  @override
  void dispose() {
    _practiceSingleController.dispose();
    _practiceMultipleController.dispose();
    _practiceTrueFalseController.dispose();
    _practiceDurationController.dispose();
    _examSingleController.dispose();
    _examMultipleController.dispose();
    _examTrueFalseController.dispose();
    _examDurationController.dispose();
    super.dispose();
  }

  void _updateDuration(String mode) {
    int single =
        int.tryParse(
          mode == 'practice'
              ? _practiceSingleController.text
              : _examSingleController.text,
        ) ??
        0;
    int multiple =
        int.tryParse(
          mode == 'practice'
              ? _practiceMultipleController.text
              : _examMultipleController.text,
        ) ??
        0;
    int trueFalse =
        int.tryParse(
          mode == 'practice'
              ? _practiceTrueFalseController.text
              : _examTrueFalseController.text,
        ) ??
        0;
    final total = single + multiple + trueFalse;
    if (mode == 'practice') {
      _practiceDurationController.text = total.toString();
    } else {
      _examDurationController.text = total.toString();
    }
  }

  Future<void> _onBankSelected(int? bankId, String mode) async {
    if (bankId == null) return;

    final questions = await DatabaseHelper.instance.getQuestionCountsByBank(
      bankId,
    );
    _singleCount[bankId] = questions['single'] ?? 0;
    _multipleCount[bankId] = questions['multiple'] ?? 0;
    _trueFalseCount[bankId] = questions['judge'] ?? 0;

    setState(() {
      if (mode == 'practice') {
        _practiceSelectedBankId = bankId;
        _practiceSingleController.text =
            ((_singleCount[bankId] ?? 0) > 5 ? 5 : _singleCount[bankId])
                .toString();
        _practiceMultipleController.text =
            ((_multipleCount[bankId] ?? 0) > 2 ? 2 : _multipleCount[bankId])
                .toString();
        _practiceTrueFalseController.text =
            ((_trueFalseCount[bankId] ?? 0) > 3 ? 3 : _trueFalseCount[bankId])
                .toString();
      } else {
        _examSelectedBankId = bankId;
        _examSingleController.text = (_singleCount[bankId] ?? 0).toString();
        _examMultipleController.text = (_multipleCount[bankId] ?? 0).toString();
        _examTrueFalseController.text = (_trueFalseCount[bankId] ?? 0)
            .toString();
      }
      _updateDuration(mode);
    });
  }

  void _startQuiz(String mode) {
    final formKey = mode == 'practice' ? _practiceFormKey : _examFormKey;
    if (formKey.currentState!.validate()) {
      final bankId = mode == 'practice'
          ? _practiceSelectedBankId
          : _examSelectedBankId;
      final single = mode == 'practice'
          ? _practiceSingleController.text
          : _examSingleController.text;
      final multiple = mode == 'practice'
          ? _practiceMultipleController.text
          : _examMultipleController.text;
      final trueFalse = mode == 'practice'
          ? _practiceTrueFalseController.text
          : _examTrueFalseController.text;
      final duration = mode == 'practice'
          ? _practiceDurationController.text
          : _examDurationController.text;
      final shuffleQuestions = mode == 'practice'
          ? _practiceShuffleQuestions
          : _examShuffleQuestions;
      final shuffleOptions = mode == 'practice'
          ? _practiceShuffleOptions
          : _examShuffleOptions;

      context.go(
        '/quiz/taking/$mode/$bankId?single=$single&multiple=$multiple&trueFalse=$trueFalse&duration=$duration&shuffleQuestions=$shuffleQuestions&shuffleOptions=$shuffleOptions${mode == 'practice' ? '&withoutTaken=$_practiceWithoutTaken' : ''}',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final bankListAsync = ref.watch(bankListProvider);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/'),
        ),
        title: Text(AppLocalizations.of(context)!.mode),
      ),
      body: bankListAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) =>
            Center(child: Text(AppLocalizations.of(context)!.loadFailMsg)),
        data: (banks) {
          if (banks.isEmpty) {
            return Center(
              child: Text(AppLocalizations.of(context)!.noBankForQuizMsg),
            );
          }
          return ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              ExpansionPanelList(
                expansionCallback: (int index, bool isExpanded) {
                  setState(() {
                    if (index == 0) {
                      _isPracticeExpanded = !_isPracticeExpanded;
                    } else {
                      _isExamExpanded = !_isExamExpanded;
                    }
                  });
                },
                children: [
                  _buildPanel(
                    'practice',
                    AppLocalizations.of(context)!.modePratice,
                    AppLocalizations.of(context)!.modePraticeInfo,
                    Icons.psychology_alt,
                    _isPracticeExpanded,
                    banks,
                  ),
                  _buildPanel(
                    'exam',
                    AppLocalizations.of(context)!.modeExam,
                    AppLocalizations.of(context)!.modeExamInfo,
                    Icons.assignment,
                    _isExamExpanded,
                    banks,
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }

  ExpansionPanel _buildPanel(
    String mode,
    String title,
    String subtitle,
    IconData icon,
    bool isExpanded,
    List<QuestionBank> banks,
  ) {
    return ExpansionPanel(
      headerBuilder: (BuildContext context, bool isExpanded) {
        return ListTile(
          leading: Icon(
            icon,
            size: 40,
            color: Theme.of(context).iconTheme.color,
          ),
          title: Text(title, style: Theme.of(context).textTheme.titleLarge),
          subtitle: Text(subtitle),
        );
      },
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: mode == 'practice' ? _practiceFormKey : _examFormKey,
          child: Column(
            children: [
              DropdownButtonFormField<int>(
                value: mode == 'practice'
                    ? _practiceSelectedBankId
                    : _examSelectedBankId,
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.selectBank,
                  border: const OutlineInputBorder(),
                ),
                items: banks.map((bank) {
                  return DropdownMenuItem<int>(
                    value: bank.id,
                    child: Text(bank.name),
                  );
                }).toList(),
                onChanged: (value) => _onBankSelected(value, mode),
                validator: (value) => value == null
                    ? AppLocalizations.of(context)!.selectBank
                    : null,
              ),
              const SizedBox(height: 16),
              _buildNumberInput(
                mode,
                '${AppLocalizations.of(context)!.modeSingle} ${AppLocalizations.of(context)!.count}',
                mode == 'practice'
                    ? _practiceSingleController
                    : _examSingleController,
                _singleCount[mode == 'practice'
                        ? _practiceSelectedBankId
                        : _examSelectedBankId] ??
                    0,
              ),
              const SizedBox(height: 16),
              _buildNumberInput(
                mode,
                '${AppLocalizations.of(context)!.modeMultiple} ${AppLocalizations.of(context)!.count}',
                mode == 'practice'
                    ? _practiceMultipleController
                    : _examMultipleController,
                _multipleCount[mode == 'practice'
                        ? _practiceSelectedBankId
                        : _examSelectedBankId] ??
                    0,
              ),
              const SizedBox(height: 16),
              _buildNumberInput(
                mode,
                '${AppLocalizations.of(context)!.modeJudge} ${AppLocalizations.of(context)!.count}',
                mode == 'practice'
                    ? _practiceTrueFalseController
                    : _examTrueFalseController,
                _trueFalseCount[mode == 'practice'
                        ? _practiceSelectedBankId
                        : _examSelectedBankId] ??
                    0,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: mode == 'practice'
                    ? _practiceDurationController
                    : _examDurationController,
                decoration: InputDecoration(
                  labelText:
                      '${AppLocalizations.of(context)!.duration} (${AppLocalizations.of(context)!.minutes})',
                  border: const OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter duration';
                  }
                  if (int.tryParse(value) == 0) {
                    return 'Duration cannot be 0';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              SwitchListTile(
                title: Text(AppLocalizations.of(context)!.shuffleQuestions),
                value: mode == 'practice'
                    ? _practiceShuffleQuestions
                    : _examShuffleQuestions,
                onChanged: (value) {
                  setState(() {
                    if (mode == 'practice') {
                      _practiceShuffleQuestions = value;
                    } else {
                      _examShuffleQuestions = value;
                    }
                  });
                },
              ),
              SwitchListTile(
                title: Text(AppLocalizations.of(context)!.shuffleOptions),
                value: mode == 'practice'
                    ? _practiceShuffleOptions
                    : _examShuffleOptions,
                onChanged: (value) {
                  setState(() {
                    if (mode == 'practice') {
                      _practiceShuffleOptions = value;
                    } else {
                      _examShuffleOptions = value;
                    }
                  });
                },
              ),
              if (mode == 'practice')
                SwitchListTile(
                  title: Text(AppLocalizations.of(context)!.noRepeat),
                  value: _practiceWithoutTaken,
                  onChanged: (value) {
                    setState(() {
                      _practiceWithoutTaken = value;
                    });
                  },
                ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => _startQuiz(mode),
                child: Text(AppLocalizations.of(context)!.start),
              ),
            ],
          ),
        ),
      ),
      isExpanded: isExpanded,
    );
  }

  Widget _buildNumberInput(
    String mode,
    String label,
    TextEditingController controller,
    int max,
  ) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: '$label (${AppLocalizations.of(context)!.max}): $max)',
        border: const OutlineInputBorder(),
      ),
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter a number';
        }
        final n = int.tryParse(value);
        if (n == null) {
          return 'Please enter a valid number';
        }
        if (n > max) {
          return 'Cannot exceed the total number of questions in the bank ($max)';
        }
        return null;
      },
      onChanged: (_) => _updateDuration(mode),
    );
  }
}
