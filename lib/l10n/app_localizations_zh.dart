// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get appName => '答题软件';

  @override
  String get bank => '题库';

  @override
  String get bankManage => '题库管理';

  @override
  String get addBank => '添加新题库';

  @override
  String get addBankName => '题库名称';

  @override
  String get addBankDesc => '题库描述';

  @override
  String get addBtn => '添加';

  @override
  String get cancelBtn => '取消';

  @override
  String get question => '题目';

  @override
  String get addQuestionTitle => '题干';

  @override
  String get addQuestionType => '题目类型';

  @override
  String get addQuestionOptionLabel => '选项和答案';

  @override
  String get addQuestionOption => '选项';

  @override
  String get addQuestionAnswer => '答案';

  @override
  String get addQuestionAnalysis => '解析';

  @override
  String get addQuestionTag => '标签';

  @override
  String get mode => '答题模式';

  @override
  String get modePratice => '练习';

  @override
  String get modePraticeInfo => '按顺序或随机练习';

  @override
  String get modeExam => '考试';

  @override
  String get modeExamInfo => '考试模式有时间限制';

  @override
  String get modeBank => '选择题库';

  @override
  String get modeSingle => '单选';

  @override
  String get modeMultiple => '多选';

  @override
  String get modeJudge => '判断';

  @override
  String get modeQuestionShuffle => '题目乱序';

  @override
  String get modeOptionShuffle => '选项乱序';

  @override
  String get modeWithoutTaken => '不考已做的题';

  @override
  String get modeStartBtn => '开始';

  @override
  String get study => '学习辅助';

  @override
  String get stats => '数据统计';

  @override
  String get settings => '设置';

  @override
  String get bankEmptyMsg => '还没有题库，快添加一个吧！';

  @override
  String get bankRemoveMsg => '题库已删除';

  @override
  String get questionRemovedMsg => '题目已删除';

  @override
  String get bankBatchImport => '批量导入';

  @override
  String get importWaitingMsg => '正在批量导入，请稍候';

  @override
  String get excelEmptyMsg => 'Excel文件为空';

  @override
  String get trueStr => '正确';

  @override
  String get falseStr => '错误';

  @override
  String get importSuccessMsg => '导入成功';

  @override
  String get addOptionBtn => '添加选项';

  @override
  String get setAnswerMsg => '请设置答案';

  @override
  String get unexpectedErrorMsg => '糟糕，发生了意外错误';

  @override
  String get excelFormatErrorMsg => 'Excel格式错误，必须包含 “试题题干（必填）”、“试题类型”、“答案（必填）”';

  @override
  String get questionBankTitle => '题库';

  @override
  String get noQuestionMsg => '没有可用的题目。';

  @override
  String get pageNotFoundTitle => '页面未找到';

  @override
  String get backBtn => '返回';

  @override
  String get quizReviewTitle => '错题回顾';

  @override
  String get reviewWrongQuestions => '回顾所有答错的题目';

  @override
  String get allCorrectMsg => '恭喜你，全部回答正确！';

  @override
  String get noBankForQuizMsg => '没有可用的题库，请先创建题库。';

  @override
  String get noQuestionForQuizMsg => '当前考试没有题目，请选择模式或题库。';

  @override
  String get loadFailMsg => '加载失败';

  @override
  String get showAnswerLabel => '显示答案';

  @override
  String get prevQuestionBtn => '上一题';

  @override
  String get unsupportedQuestionType => '不支持的题目类型';

  @override
  String get correctAnswerLabel => '正确答案：';

  @override
  String get analysisLabel => '解析：';

  @override
  String get quizCompleteMsg => '答题完成！';

  @override
  String get viewWrongQuestionBtn => '查看错题';

  @override
  String get backToHomeBtn => '返回主页';

  @override
  String get promptTitle => '提示';

  @override
  String get confirmBtn => '确定';

  @override
  String get themeModeLabel => '主题模式';

  @override
  String get themeModeSystem => '跟随系统';

  @override
  String get themeModeLight => '亮色模式';

  @override
  String get themeModeDark => '暗色模式';

  @override
  String get showAnswerInPracticeLabel => '练习模式是否显示答案';

  @override
  String get importTemplateLabel => '导入模板链接';

  @override
  String get authorLabel => '作者';

  @override
  String get authorName => 'koiszzz';

  @override
  String get projectAddressLabel => '项目地址';

  @override
  String get quizDetailsTitle => '答题详情';

  @override
  String get noQuestionFoundMsg => '没有找到题目';

  @override
  String get noQuizRecordMsg => '还没有答题记录。';

  @override
  String get questionBank => '题库';

  @override
  String get addQuestion => '添加题目';

  @override
  String get editQuestion => '编辑题目';

  @override
  String get okBtn => '好的';

  @override
  String get questionTitleLabel => '题干';

  @override
  String get questionTypeLabel => '类型';

  @override
  String get questionAnswerLabel => '答案';

  @override
  String get questionAnalysisLabel => '解析';

  @override
  String get questionTagLabel => '标签';

  @override
  String get questionOptionsLabel => '选项';

  @override
  String get deleteBtn => '删除';

  @override
  String get deleteConfirmMsg => '你确定要删除吗？';

  @override
  String get saveBtn => '保存';

  @override
  String get addChoiceOption => '添加选项';

  @override
  String get answerLabel => '答案';

  @override
  String get optionLabel => '选项';

  @override
  String get quizConfig => '答题设置';

  @override
  String get selectBank => '选择题库';

  @override
  String get questionType => '题目类型';

  @override
  String get shuffleQuestions => '题目乱序';

  @override
  String get shuffleOptions => '选项乱序';

  @override
  String get noRepeatCorrect => '不重做答对的题';

  @override
  String get start => '开始';

  @override
  String get submit => '提交';

  @override
  String get next => '下一题';

  @override
  String get finish => '完成';

  @override
  String get correct => '正确';

  @override
  String get wrong => '错误';

  @override
  String get noAnswer => '未作答';

  @override
  String get viewAnalysis => '查看解析';

  @override
  String get hideAnalysis => '隐藏解析';

  @override
  String get quizReport => '答题报告';

  @override
  String get totalQuestions => '总题数';

  @override
  String get correctCount => '答对';

  @override
  String get wrongCount => '答错';

  @override
  String get accuracy => '正确率';

  @override
  String get review => '回顾';

  @override
  String get retry => '重试';

  @override
  String get home => '主页';

  @override
  String get language => '语言';

  @override
  String get english => '英语';

  @override
  String get chinese => '中文';

  @override
  String get feedback => '反馈';

  @override
  String get about => '关于';

  @override
  String get version => '版本';

  @override
  String get checkUpdate => '检查更新';

  @override
  String get noRecords => '暂无记录';

  @override
  String get quizTime => '时间';

  @override
  String get score => '分数';

  @override
  String get details => '详情';

  @override
  String get noMistakes => '没有错题';

  @override
  String get favorite => '收藏';

  @override
  String get favoriteReviewMsg => '回顾所有收藏的题目';

  @override
  String get date => '日期';

  @override
  String get commaInfo => '以逗号分隔';

  @override
  String get count => '数量';

  @override
  String get max => '最多';

  @override
  String get duration => '时长';

  @override
  String get minutes => '分钟';

  @override
  String modeTranslate(String mode) {
    String _temp0 = intl.Intl.selectLogic(mode, {
      'practice': '练习',
      'exam': '考试',
      'wrong': '错题',
      'favorite': '收藏',
      'other': '未知',
    });
    return '$_temp0模式';
  }

  @override
  String typeLabel(String type) {
    String _temp0 = intl.Intl.selectLogic(type, {
      'single': '单选',
      'multiple': '多选',
      'judge': '判断',
      'other': '未知',
    });
    return '$_temp0';
  }

  @override
  String get scoreInfo => '你的成绩';

  @override
  String get examDetail => '答题详情';
}
