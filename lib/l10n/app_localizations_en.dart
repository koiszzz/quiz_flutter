// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'QUIZ';

  @override
  String get bank => 'BANK';

  @override
  String get bankManage => 'BANK MANAGE';

  @override
  String get addBank => 'ADD NEW BANK';

  @override
  String get addBankName => 'bank name';

  @override
  String get addBankDesc => 'bank description';

  @override
  String get addBtn => 'ADD';

  @override
  String get cancelBtn => 'CANCEL';

  @override
  String get question => 'QUESTION';

  @override
  String get addQuestionTitle => 'title';

  @override
  String get addQuestionType => 'type';

  @override
  String get addQuestionOptionLabel => 'Options & Answer';

  @override
  String get addQuestionOption => 'option';

  @override
  String get addQuestionAnswer => 'answer';

  @override
  String get addQuestionAnalysis => 'analysis';

  @override
  String get addQuestionTag => 'tag';

  @override
  String get mode => 'MODE';

  @override
  String get modePratice => 'PRACTICE';

  @override
  String get modePraticeInfo => 'Practice by order or randomly';

  @override
  String get modeExam => 'EXAM';

  @override
  String get modeExamInfo => 'Time limit';

  @override
  String get modeBank => 'choose bank';

  @override
  String get modeSingle => 'single choise';

  @override
  String get modeMultiple => 'multiple choise';

  @override
  String get modeJudge => 'true or false';

  @override
  String get modeQuestionShuffle => 'question shuffle';

  @override
  String get modeOptionShuffle => 'option shuffle';

  @override
  String get modeWithoutTaken => 'without taken';

  @override
  String get modeStartBtn => 'start';

  @override
  String get study => 'STUDY';

  @override
  String get stats => 'STATS';

  @override
  String get settings => 'SETTINGS';

  @override
  String get bankEmptyMsg => 'bank is empty, please add one';

  @override
  String get bankRemoveMsg => 'bank removed';

  @override
  String get questionRemovedMsg => 'question removed';

  @override
  String get bankBatchImport => 'batch import';

  @override
  String get importWaitingMsg => 'batch importing, please wait';

  @override
  String get excelEmptyMsg => 'excel is empty';

  @override
  String get trueStr => 'true';

  @override
  String get falseStr => 'false';

  @override
  String get importSuccessMsg => 'importing success';

  @override
  String get addOptionBtn => 'add option';

  @override
  String get setAnswerMsg => 'please set answer';

  @override
  String get unexpectedErrorMsg => 'Oops, something unexpected happened';

  @override
  String get excelFormatErrorMsg =>
      'Excel format error, must include \"title (required)\", \"type\", \"answer (required)\"';

  @override
  String get questionBankTitle => 'Question Bank';

  @override
  String get noQuestionMsg => 'No questions available.';

  @override
  String get pageNotFoundTitle => 'Page Not Found';

  @override
  String get backBtn => 'BACK';

  @override
  String get quizReviewTitle => 'Review Wrong Questions';

  @override
  String get reviewWrongQuestions => 'Review all wrong questions';

  @override
  String get allCorrectMsg => 'Congratulations, all correct!';

  @override
  String get noBankForQuizMsg =>
      'No question bank available, please create one first.';

  @override
  String get noQuestionForQuizMsg =>
      'No questions in current quiz, please select a mode or bank.';

  @override
  String get loadFailMsg => 'Load failed';

  @override
  String get showAnswerLabel => 'Show Answer';

  @override
  String get prevQuestionBtn => 'Prev';

  @override
  String get unsupportedQuestionType => 'Unsupported question type';

  @override
  String get correctAnswerLabel => 'Correct Answer: ';

  @override
  String get analysisLabel => 'Analysis: ';

  @override
  String get quizCompleteMsg => 'Quiz Complete!';

  @override
  String get viewWrongQuestionBtn => 'Review Wrong';

  @override
  String get backToHomeBtn => 'Back to Home';

  @override
  String get promptTitle => 'Prompt';

  @override
  String get confirmBtn => 'OK';

  @override
  String get themeModeLabel => 'Theme Mode';

  @override
  String get themeModeSystem => 'System';

  @override
  String get themeModeLight => 'Light';

  @override
  String get themeModeDark => 'Dark';

  @override
  String get showAnswerInPracticeLabel => 'Show answer in practice mode';

  @override
  String get importTemplateLabel => 'Import template link';

  @override
  String get authorLabel => 'Author';

  @override
  String get authorName => 'koiszzz';

  @override
  String get projectAddressLabel => 'Project Address';

  @override
  String get quizDetailsTitle => 'Quiz Details';

  @override
  String get noQuestionFoundMsg => 'No questions found';

  @override
  String get noQuizRecordMsg => 'No quiz records yet.';

  @override
  String get questionBank => 'Question Bank';

  @override
  String get addQuestion => 'Add Question';

  @override
  String get editQuestion => 'Edit Question';

  @override
  String get okBtn => 'OK';

  @override
  String get questionTitleLabel => 'title';

  @override
  String get questionTypeLabel => 'type';

  @override
  String get questionAnswerLabel => 'answer';

  @override
  String get questionAnalysisLabel => 'analysis';

  @override
  String get questionTagLabel => 'tag';

  @override
  String get questionOptionsLabel => 'options';

  @override
  String get deleteBtn => 'Delete';

  @override
  String get deleteConfirmMsg => 'Are you sure to delete?';

  @override
  String get saveBtn => 'Save';

  @override
  String get addChoiceOption => 'Add Option';

  @override
  String get answerLabel => 'Answer';

  @override
  String get optionLabel => 'Option';

  @override
  String get quizConfig => 'Quiz Config';

  @override
  String get selectBank => 'Select Bank';

  @override
  String get questionType => 'Question Type';

  @override
  String get shuffleQuestions => 'Shuffle Questions';

  @override
  String get shuffleOptions => 'Shuffle Options';

  @override
  String get noRepeatCorrect => 'No Repeat Correct';

  @override
  String get start => 'Start';

  @override
  String get submit => 'Submit';

  @override
  String get next => 'Next';

  @override
  String get finish => 'Finish';

  @override
  String get correct => 'Correct';

  @override
  String get wrong => 'Wrong';

  @override
  String get noAnswer => 'No Answer';

  @override
  String get viewAnalysis => 'View Analysis';

  @override
  String get hideAnalysis => 'Hide Analysis';

  @override
  String get quizReport => 'Quiz Report';

  @override
  String get totalQuestions => 'Total';

  @override
  String get correctCount => 'Correct';

  @override
  String get wrongCount => 'Wrong';

  @override
  String get accuracy => 'Accuracy';

  @override
  String get review => 'Review';

  @override
  String get retry => 'Retry';

  @override
  String get home => 'Home';

  @override
  String get language => 'Language';

  @override
  String get english => 'English';

  @override
  String get chinese => 'Chinese';

  @override
  String get feedback => 'Feedback';

  @override
  String get about => 'About';

  @override
  String get version => 'Version';

  @override
  String get checkUpdate => 'Check Update';

  @override
  String get noRecords => 'No Records';

  @override
  String get quizTime => 'Time';

  @override
  String get score => 'Score';

  @override
  String get details => 'Details';

  @override
  String get noMistakes => 'No Mistakes';

  @override
  String get favorite => 'Favorite';

  @override
  String get favoriteReviewMsg => 'Review all favorite questions';

  @override
  String get date => 'Date';

  @override
  String get commaInfo => 'comma separated';

  @override
  String get count => 'Count';

  @override
  String get max => 'Max';

  @override
  String get duration => 'Duration';

  @override
  String get minutes => 'Minutes';

  @override
  String modeTranslate(String mode) {
    String _temp0 = intl.Intl.selectLogic(mode, {
      'practice': 'PRACTICE',
      'exam': 'EXAM',
      'wrong': 'WRONG',
      'favorite': 'FAVORITE',
      'other': 'UNKNOWN',
    });
    return '$_temp0 MODE';
  }

  @override
  String typeLabel(String type) {
    String _temp0 = intl.Intl.selectLogic(type, {
      'single': 'single choice',
      'multiple': 'multiple choice',
      'judge': 'true/false',
      'other': 'unknown',
    });
    return '$_temp0';
  }

  @override
  String get scoreInfo => 'Your Score';

  @override
  String get examDetail => 'Exam Detail';
}
