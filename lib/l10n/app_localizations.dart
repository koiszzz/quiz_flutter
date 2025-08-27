import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('zh'),
  ];

  /// The name of the application.
  ///
  /// In en, this message translates to:
  /// **'QUIZ'**
  String get appName;

  /// Label for the 'Bank' or 'Question Bank' feature.
  ///
  /// In en, this message translates to:
  /// **'BANK'**
  String get bank;

  /// Title for the bank management screen.
  ///
  /// In en, this message translates to:
  /// **'BANK MANAGE'**
  String get bankManage;

  /// Button text for adding a new question bank.
  ///
  /// In en, this message translates to:
  /// **'ADD NEW BANK'**
  String get addBank;

  /// Placeholder or label for the bank name input field.
  ///
  /// In en, this message translates to:
  /// **'bank name'**
  String get addBankName;

  /// Placeholder or label for the bank description input field.
  ///
  /// In en, this message translates to:
  /// **'bank description'**
  String get addBankDesc;

  /// Generic 'Add' button text.
  ///
  /// In en, this message translates to:
  /// **'ADD'**
  String get addBtn;

  /// Generic 'Cancel' button text.
  ///
  /// In en, this message translates to:
  /// **'CANCEL'**
  String get cancelBtn;

  /// Label for the 'Question' feature.
  ///
  /// In en, this message translates to:
  /// **'QUESTION'**
  String get question;

  /// Label for the question title/text input field.
  ///
  /// In en, this message translates to:
  /// **'title'**
  String get addQuestionTitle;

  /// Label for the question type selection (e.g., single choice, multiple choice).
  ///
  /// In en, this message translates to:
  /// **'type'**
  String get addQuestionType;

  /// Label for the section where options and answers are defined for a question.
  ///
  /// In en, this message translates to:
  /// **'Options & Answer'**
  String get addQuestionOptionLabel;

  /// Placeholder or label for a single choice/option input field.
  ///
  /// In en, this message translates to:
  /// **'option'**
  String get addQuestionOption;

  /// Label or placeholder for the correct answer input field.
  ///
  /// In en, this message translates to:
  /// **'answer'**
  String get addQuestionAnswer;

  /// Label or placeholder for the question's explanation or analysis.
  ///
  /// In en, this message translates to:
  /// **'analysis'**
  String get addQuestionAnalysis;

  /// Label or placeholder for tags associated with a question.
  ///
  /// In en, this message translates to:
  /// **'tag'**
  String get addQuestionTag;

  /// Label for the 'Mode' or 'Quiz Mode' feature.
  ///
  /// In en, this message translates to:
  /// **'MODE'**
  String get mode;

  /// Text for the 'Practice' mode.
  ///
  /// In en, this message translates to:
  /// **'PRACTICE'**
  String get modePratice;

  /// Description for the 'Practice' mode.
  ///
  /// In en, this message translates to:
  /// **'Practice by order or randomly'**
  String get modePraticeInfo;

  /// Text for the 'Exam' mode.
  ///
  /// In en, this message translates to:
  /// **'EXAM'**
  String get modeExam;

  /// Description for the 'Exam' mode.
  ///
  /// In en, this message translates to:
  /// **'Time limit'**
  String get modeExamInfo;

  /// Label for the bank selection in quiz mode settings.
  ///
  /// In en, this message translates to:
  /// **'choose bank'**
  String get modeBank;

  /// Text for 'single choice' question type.
  ///
  /// In en, this message translates to:
  /// **'single choise'**
  String get modeSingle;

  /// Text for 'multiple choice' question type.
  ///
  /// In en, this message translates to:
  /// **'multiple choise'**
  String get modeMultiple;

  /// Text for 'true or false' question type.
  ///
  /// In en, this message translates to:
  /// **'true or false'**
  String get modeJudge;

  /// Label for the 'shuffle questions' option.
  ///
  /// In en, this message translates to:
  /// **'question shuffle'**
  String get modeQuestionShuffle;

  /// Label for the 'shuffle options' option.
  ///
  /// In en, this message translates to:
  /// **'option shuffle'**
  String get modeOptionShuffle;

  /// Label for the option to exclude already answered questions.
  ///
  /// In en, this message translates to:
  /// **'without taken'**
  String get modeWithoutTaken;

  /// Button text to start a quiz from the mode selection screen.
  ///
  /// In en, this message translates to:
  /// **'start'**
  String get modeStartBtn;

  /// Navigation tab label for 'Study'.
  ///
  /// In en, this message translates to:
  /// **'STUDY'**
  String get study;

  /// Navigation tab label for 'Statistics'.
  ///
  /// In en, this message translates to:
  /// **'STATS'**
  String get stats;

  /// Navigation tab label for 'Settings'.
  ///
  /// In en, this message translates to:
  /// **'SETTINGS'**
  String get settings;

  /// Message shown when the question bank list is empty.
  ///
  /// In en, this message translates to:
  /// **'bank is empty, please add one'**
  String get bankEmptyMsg;

  /// Confirmation message (e.g., in a snackbar) shown after a bank is successfully removed.
  ///
  /// In en, this message translates to:
  /// **'bank removed'**
  String get bankRemoveMsg;

  /// Confirmation message shown after a question is successfully removed.
  ///
  /// In en, this message translates to:
  /// **'question removed'**
  String get questionRemovedMsg;

  /// Button or label for the batch import feature.
  ///
  /// In en, this message translates to:
  /// **'batch import'**
  String get bankBatchImport;

  /// Message shown while a batch import is in progress.
  ///
  /// In en, this message translates to:
  /// **'batch importing, please wait'**
  String get importWaitingMsg;

  /// Error message shown when the imported Excel file is empty.
  ///
  /// In en, this message translates to:
  /// **'excel is empty'**
  String get excelEmptyMsg;

  /// The string representing the boolean value 'true'.
  ///
  /// In en, this message translates to:
  /// **'true'**
  String get trueStr;

  /// The string representing the boolean value 'false'.
  ///
  /// In en, this message translates to:
  /// **'false'**
  String get falseStr;

  /// Message shown after a successful import.
  ///
  /// In en, this message translates to:
  /// **'importing success'**
  String get importSuccessMsg;

  /// Button text to add a new option to a question.
  ///
  /// In en, this message translates to:
  /// **'add option'**
  String get addOptionBtn;

  /// Error or prompt message telling the user to set an answer for a question.
  ///
  /// In en, this message translates to:
  /// **'please set answer'**
  String get setAnswerMsg;

  /// A generic error message for unexpected issues.
  ///
  /// In en, this message translates to:
  /// **'Oops, something unexpected happened'**
  String get unexpectedErrorMsg;

  /// Error message detailing the required format for an Excel import file.
  ///
  /// In en, this message translates to:
  /// **'Excel format error, must include \"title (required)\", \"type\", \"answer (required)\"'**
  String get excelFormatErrorMsg;

  /// Title for the Question Bank screen.
  ///
  /// In en, this message translates to:
  /// **'Question Bank'**
  String get questionBankTitle;

  /// Message displayed when there are no questions in a selected bank.
  ///
  /// In en, this message translates to:
  /// **'No questions available.'**
  String get noQuestionMsg;

  /// Title for the 404 or page not found screen.
  ///
  /// In en, this message translates to:
  /// **'Page Not Found'**
  String get pageNotFoundTitle;

  /// Generic 'Back' button text.
  ///
  /// In en, this message translates to:
  /// **'BACK'**
  String get backBtn;

  /// Title for the screen where users review their wrong answers.
  ///
  /// In en, this message translates to:
  /// **'Review Wrong Questions'**
  String get quizReviewTitle;

  /// Button or label to start reviewing all wrong questions from a quiz.
  ///
  /// In en, this message translates to:
  /// **'Review all wrong questions'**
  String get reviewWrongQuestions;

  /// Message shown when the user answers all questions correctly in a quiz or review session.
  ///
  /// In en, this message translates to:
  /// **'Congratulations, all correct!'**
  String get allCorrectMsg;

  /// Message shown when a user tries to start a quiz but has no question banks created.
  ///
  /// In en, this message translates to:
  /// **'No question bank available, please create one first.'**
  String get noBankForQuizMsg;

  /// Message shown when the selected bank/mode for a quiz has no questions.
  ///
  /// In en, this message translates to:
  /// **'No questions in current quiz, please select a mode or bank.'**
  String get noQuestionForQuizMsg;

  /// Generic message indicating a failed loading attempt.
  ///
  /// In en, this message translates to:
  /// **'Load failed'**
  String get loadFailMsg;

  /// Label for a button, checkbox, or switch to show the correct answer.
  ///
  /// In en, this message translates to:
  /// **'Show Answer'**
  String get showAnswerLabel;

  /// Button text to go to the previous question.
  ///
  /// In en, this message translates to:
  /// **'Prev'**
  String get prevQuestionBtn;

  /// Error message for an unsupported or unknown question type.
  ///
  /// In en, this message translates to:
  /// **'Unsupported question type'**
  String get unsupportedQuestionType;

  /// Label preceding the display of the correct answer.
  ///
  /// In en, this message translates to:
  /// **'Correct Answer: '**
  String get correctAnswerLabel;

  /// Label preceding the display of the question's analysis/explanation.
  ///
  /// In en, this message translates to:
  /// **'Analysis: '**
  String get analysisLabel;

  /// Message shown on the report screen when a quiz is completed.
  ///
  /// In en, this message translates to:
  /// **'Quiz Complete!'**
  String get quizCompleteMsg;

  /// Button to view/review wrong questions after a quiz is complete.
  ///
  /// In en, this message translates to:
  /// **'Review Wrong'**
  String get viewWrongQuestionBtn;

  /// Button to navigate back to the main home screen.
  ///
  /// In en, this message translates to:
  /// **'Back to Home'**
  String get backToHomeBtn;

  /// Default title for a generic dialog or prompt.
  ///
  /// In en, this message translates to:
  /// **'Prompt'**
  String get promptTitle;

  /// Generic 'OK' or 'Confirm' button text, often used in dialogs.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get confirmBtn;

  /// Label for the theme mode setting (System, Light, Dark).
  ///
  /// In en, this message translates to:
  /// **'Theme Mode'**
  String get themeModeLabel;

  /// Option for 'System' theme mode, which follows the OS setting.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get themeModeSystem;

  /// Option for 'Light' theme mode.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get themeModeLight;

  /// Option for 'Dark' theme mode.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get themeModeDark;

  /// Label for the setting to automatically show answers during practice mode.
  ///
  /// In en, this message translates to:
  /// **'Show answer in practice mode'**
  String get showAnswerInPracticeLabel;

  /// Label for the link to download the import template file.
  ///
  /// In en, this message translates to:
  /// **'Import template link'**
  String get importTemplateLabel;

  /// Label for 'Author' in the 'About' section.
  ///
  /// In en, this message translates to:
  /// **'Author'**
  String get authorLabel;

  /// The name of the application author.
  ///
  /// In en, this message translates to:
  /// **'koiszzz'**
  String get authorName;

  /// Label for 'Project Address' (e.g., GitHub link) in the 'About' section.
  ///
  /// In en, this message translates to:
  /// **'Project Address'**
  String get projectAddressLabel;

  /// Title for the screen showing details of a past quiz record.
  ///
  /// In en, this message translates to:
  /// **'Quiz Details'**
  String get quizDetailsTitle;

  /// Message when a search or filter yields no questions.
  ///
  /// In en, this message translates to:
  /// **'No questions found'**
  String get noQuestionFoundMsg;

  /// Message displayed on the stats/history screen when there are no past quiz records.
  ///
  /// In en, this message translates to:
  /// **'No quiz records yet.'**
  String get noQuizRecordMsg;

  /// A common label or title for 'Question Bank'.
  ///
  /// In en, this message translates to:
  /// **'Question Bank'**
  String get questionBank;

  /// Button or title for the 'Add Question' screen.
  ///
  /// In en, this message translates to:
  /// **'Add Question'**
  String get addQuestion;

  /// Button or title for the 'Edit Question' screen.
  ///
  /// In en, this message translates to:
  /// **'Edit Question'**
  String get editQuestion;

  /// Generic 'OK' button text.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get okBtn;

  /// Label for the question title field in a form.
  ///
  /// In en, this message translates to:
  /// **'title'**
  String get questionTitleLabel;

  /// Label for the question type field in a form.
  ///
  /// In en, this message translates to:
  /// **'type'**
  String get questionTypeLabel;

  /// Label for the question answer field in a form.
  ///
  /// In en, this message translates to:
  /// **'answer'**
  String get questionAnswerLabel;

  /// Label for the question analysis/explanation field in a form.
  ///
  /// In en, this message translates to:
  /// **'analysis'**
  String get questionAnalysisLabel;

  /// Label for the question tag field in a form.
  ///
  /// In en, this message translates to:
  /// **'tag'**
  String get questionTagLabel;

  /// Label for the question options section in a form.
  ///
  /// In en, this message translates to:
  /// **'options'**
  String get questionOptionsLabel;

  /// Generic 'Delete' button text.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get deleteBtn;

  /// Confirmation message shown in a dialog before deleting an item.
  ///
  /// In en, this message translates to:
  /// **'Are you sure to delete?'**
  String get deleteConfirmMsg;

  /// Generic 'Save' button text.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get saveBtn;

  /// Button text to add a new choice option when creating/editing a question.
  ///
  /// In en, this message translates to:
  /// **'Add Option'**
  String get addChoiceOption;

  /// Generic label for 'Answer'.
  ///
  /// In en, this message translates to:
  /// **'Answer'**
  String get answerLabel;

  /// Generic label for 'Option'.
  ///
  /// In en, this message translates to:
  /// **'Option'**
  String get optionLabel;

  /// Title for the quiz configuration/settings screen.
  ///
  /// In en, this message translates to:
  /// **'Quiz Config'**
  String get quizConfig;

  /// Label prompting the user to select a question bank.
  ///
  /// In en, this message translates to:
  /// **'Select Bank'**
  String get selectBank;

  /// Label for 'Question Type'.
  ///
  /// In en, this message translates to:
  /// **'Question Type'**
  String get questionType;

  /// Label for the 'Shuffle Questions' option in quiz settings.
  ///
  /// In en, this message translates to:
  /// **'Shuffle Questions'**
  String get shuffleQuestions;

  /// Label for the 'Shuffle Options' option in quiz settings.
  ///
  /// In en, this message translates to:
  /// **'Shuffle Options'**
  String get shuffleOptions;

  /// Label for an option to not repeat correctly answered questions.
  ///
  /// In en, this message translates to:
  /// **'No Repeat Correct'**
  String get noRepeatCorrect;

  /// Generic 'Start' button text.
  ///
  /// In en, this message translates to:
  /// **'Start'**
  String get start;

  /// Button text to submit an answer during a quiz.
  ///
  /// In en, this message translates to:
  /// **'Submit'**
  String get submit;

  /// Button text to go to the next question.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// Button text to finish the quiz.
  ///
  /// In en, this message translates to:
  /// **'Finish'**
  String get finish;

  /// Text indicating a correct answer.
  ///
  /// In en, this message translates to:
  /// **'Correct'**
  String get correct;

  /// Text indicating a wrong answer.
  ///
  /// In en, this message translates to:
  /// **'Wrong'**
  String get wrong;

  /// Text indicating that no answer was given for a question.
  ///
  /// In en, this message translates to:
  /// **'No Answer'**
  String get noAnswer;

  /// Button or link text to view the explanation for a question.
  ///
  /// In en, this message translates to:
  /// **'View Analysis'**
  String get viewAnalysis;

  /// Button or link text to hide the explanation for a question.
  ///
  /// In en, this message translates to:
  /// **'Hide Analysis'**
  String get hideAnalysis;

  /// Title for the quiz report/summary screen.
  ///
  /// In en, this message translates to:
  /// **'Quiz Report'**
  String get quizReport;

  /// Label for the total number of questions in a quiz report.
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get totalQuestions;

  /// Label for the count of correctly answered questions in a quiz report.
  ///
  /// In en, this message translates to:
  /// **'Correct'**
  String get correctCount;

  /// Label for the count of incorrectly answered questions in a quiz report.
  ///
  /// In en, this message translates to:
  /// **'Wrong'**
  String get wrongCount;

  /// Label for the accuracy percentage in a quiz report.
  ///
  /// In en, this message translates to:
  /// **'Accuracy'**
  String get accuracy;

  /// Button or label for 'Review' action.
  ///
  /// In en, this message translates to:
  /// **'Review'**
  String get review;

  /// Button or label to 'Retry' a quiz.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// Navigation label for the 'Home' screen.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// Label for the language setting.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// The name of the English language.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// The name of the Chinese language.
  ///
  /// In en, this message translates to:
  /// **'Chinese'**
  String get chinese;

  /// Label for 'Feedback' option or screen in settings.
  ///
  /// In en, this message translates to:
  /// **'Feedback'**
  String get feedback;

  /// Label for 'About' option or screen in settings.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get about;

  /// Label for the application version number.
  ///
  /// In en, this message translates to:
  /// **'Version'**
  String get version;

  /// Button or label to check for application updates.
  ///
  /// In en, this message translates to:
  /// **'Check Update'**
  String get checkUpdate;

  /// Generic message shown when a list of records (e.g., history) is empty.
  ///
  /// In en, this message translates to:
  /// **'No Records'**
  String get noRecords;

  /// Label for the time taken to complete a quiz.
  ///
  /// In en, this message translates to:
  /// **'Time'**
  String get quizTime;

  /// Label for the score.
  ///
  /// In en, this message translates to:
  /// **'Score'**
  String get score;

  /// Label for 'Details' button or link.
  ///
  /// In en, this message translates to:
  /// **'Details'**
  String get details;

  /// Message shown on a review screen when there are no incorrect answers to show.
  ///
  /// In en, this message translates to:
  /// **'No Mistakes'**
  String get noMistakes;

  /// Label for the 'Favorite' feature or button to mark a question as a favorite.
  ///
  /// In en, this message translates to:
  /// **'Favorite'**
  String get favorite;

  /// Description for the action of reviewing all favorite questions.
  ///
  /// In en, this message translates to:
  /// **'Review all favorite questions'**
  String get favoriteReviewMsg;

  /// Label for 'Date'.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get date;

  /// Instruction indicating that multiple items should be separated by commas.
  ///
  /// In en, this message translates to:
  /// **'comma separated'**
  String get commaInfo;

  /// count
  ///
  /// In en, this message translates to:
  /// **'Count'**
  String get count;

  /// Label for 'Max'.
  ///
  /// In en, this message translates to:
  /// **'Max'**
  String get max;

  /// Label for 'Duration'.
  ///
  /// In en, this message translates to:
  /// **'Duration'**
  String get duration;

  /// Label for 'Minutes'.
  ///
  /// In en, this message translates to:
  /// **'Minutes'**
  String get minutes;

  /// Translation for different quiz modes.
  ///
  /// In en, this message translates to:
  /// **'{mode, select, practice {PRACTICE} exam {EXAM} wrong {WRONG} favorite {FAVORITE} other {UNKNOWN}} MODE'**
  String modeTranslate(String mode);

  /// Translation for different question types.
  ///
  /// In en, this message translates to:
  /// **'{type, select, single {single choice} multiple {multiple choice} judge {true/false} other {unknown}}'**
  String typeLabel(String type);

  /// Label for displaying the user's score.
  ///
  /// In en, this message translates to:
  /// **'Your Score'**
  String get scoreInfo;

  /// Label for the exam detail screen.
  ///
  /// In en, this message translates to:
  /// **'Exam Detail'**
  String get examDetail;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'zh'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'zh':
      return AppLocalizationsZh();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
