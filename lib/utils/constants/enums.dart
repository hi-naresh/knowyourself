enum LifeAspects { all, mental, physical, emotional, spiritual }


enum HumanState {mentally, physically, emotionally, spiritually}
enum HappenedAt { home, work, personal, social }

enum CourseType{ video,guide, magazine, centers, eBooks, auroSociety }

enum Period { daily, weekly, monthly }

enum Gender {male,female, other}

extension ReminderPeriodExtension on Period {
  String toJson() => toString().split('.').last;

  static Period fromJson(String json) {
    return Period.values.firstWhere((e) => e.toString() == 'ReminderPeriod.$json');
  }
}

enum StoryType { current, desired, }
// 1. **Individual Consumer**
// 2. **SAILC Member**
// 3. **Sri Aurobindo Society Member**
// 4. **Student**
// 5. **Academic Professional**
// 6. **Business Professional**
// Other: Kindly Specify your Role Here {Textbox to specify role}”
enum UserType { individualConsumer, sailcMember, sriAurobindoSocietyMember, academicProfessional, businessProfessional, other }


extension StoryTypeExtension on StoryType {
  String toJson() {
    return toString().split('.').last;
  }

  static StoryType fromJson(String json) {
    return StoryType.values.firstWhere((e) => e.toJson() == json);
  }
}

enum CoreValues{
  sincerity,
  humility,
  gratitude,
  perseverance,
  aspiration,
  receptivity,
  progress,
  courage,
  goodness,
  generosity,
  equanimity,
  peace,
}
// Keywords associated with each core value
final Map<CoreValues, List<String>> coreValueKeywords = {
  CoreValues.progress: ['advance', 'growth', 'improvement', 'evolution', 'enhancement', 'success', 'innovation', 'betterment', 'forward', 'achievement', 'milestone', 'prosperity', 'headway', 'upgrade', 'breakthrough', 'leap', 'progression', 'ascension', 'advancement', 'maturation', 'amplification', 'expansion', 'boost', 'refinement', 'development', 'unfolding', 'maturity', 'movement', 'movement', 'upswing', 'rise', 'enrichment', 'augmentation', 'momentum', 'succession', 'unveiling', 'enhancement', 'upturn', 'perfection', 'thrive', 'uplift', 'growth', 'progressive', 'advancing', 'elevate', 'escalate', 'moving', 'progressive', 'unfurl', 'proliferation'],
  CoreValues.receptivity: ['open-mindedness', 'acceptance', 'willingness', 'attentiveness', 'responsiveness', 'receptive', 'acknowledgment', 'assent', 'heedfulness', 'openness', 'receptiveness', 'inclusivity', 'welcome', 'perception', 'acceptance', 'sympathy', 'consideration', 'listening', 'comprehension', 'recognition', 'sensitivity', 'grasp', 'attentiveness', 'perceptiveness', 'understanding', 'appreciation', 'approachability', 'broad-mindedness', 'receptivity', 'impression', 'tolerance', 'perceptivity', 'permissiveness', 'insightfulness', 'grasping', 'attentivity', 'responsive', 'accessibility', 'inclusiveness', 'receptiveness', 'receptivity', 'acceptability', 'receptive', 'insight', 'alertness', 'awareness', 'receptive', 'responsive', 'accepting'],
  CoreValues.aspiration: ['ambition', 'goal', 'desire', 'dream', 'purpose', 'vision', 'mission', 'objective', 'aim', 'longing', 'aspiration', 'quest', 'endeavor', 'hope', 'yearning', 'drive', 'craving', 'passion', 'pursuit', 'intention', 'dream', 'ideal', 'hunger', 'thirst', 'urge', 'wish', 'longing', 'target', 'mission', 'objective', 'calling', 'destiny', 'vocation', 'intent', 'purpose', 'end', 'motivation', 'aspiring', 'striving', 'yearning', 'aspirational', 'target', 'purposeful', 'aiming', 'endeavoring', 'direction', 'mission'],
  CoreValues.perseverance: ['persistence', 'determination', 'tenacity', 'endurance', 'grit', 'resilience', 'steadfastness', 'fortitude', 'perseverance', 'resolution', 'dedication', 'commitment', 'patience', 'stamina', 'doggedness', 'resoluteness', 'steadiness', 'unwavering', 'vigilance', 'persevering', 'indefatigable', 'resistance', 'steadfast', 'endurance', 'relentless', 'tenaciousness', 'persistence', 'determined', 'unyielding', 'steadfast', 'grit', 'perseverant', 'toughness', 'perseverance', 'unrelenting', 'diligence', 'resolve', 'strength', 'steadiness', 'patience', 'unshakeable', 'steadfast', 'perseverance', 'insistence', 'perseverance', 'firmness', 'perseverance', 'enduring', 'persistence'],
  CoreValues.gratitude: ['thankfulness', 'appreciation', 'acknowledgment', 'gratefulness', 'recognition', 'gratitude', 'thanksgiving', 'grace', 'thanks', 'reciprocity', 'blessing', 'appreciative', 'acknowledgement', 'thankful', 'grateful', 'appreciating', 'graceful', 'thank', 'recognition', 'gratitude', 'gratitude', 'blessings', 'gratitude', 'grateful', 'appreciate', 'acknowledging', 'gratefully', 'appreciative', 'gratefulness', 'thank', 'thanks', 'blessing', 'recognition', 'appreciated', 'grateful', 'gratitude', 'thankfulness', 'grace', 'grateful', 'appreciative', 'thankful', 'acknowledgement', 'thankful', 'blessed', 'appreciating', 'gratitude', 'gratefulness', 'appreciation'],
  CoreValues.humility: ['modesty', 'humbleness', 'meekness', 'submissiveness', 'humility', 'modesty', 'unpretentiousness', 'humble', 'humility', 'meekness', 'simplicity', 'unassumingness', 'lowliness', 'meek', 'humble', 'unassuming', 'down-to-earth', 'gentleness', 'submissiveness', 'deference', 'unpretentious', 'modest', 'self-effacement', 'shyness', 'reserve', 'humility', 'bashfulness', 'reticence', 'timidity', 'restraint', 'humbleness', 'humility', 'diffidence', 'servility', 'unostentatiousness', 'self-abasement', 'shyness', 'quietness', 'reserve', 'humility', 'humbleness', 'self-effacing', 'subduedness', 'demureness', 'humility', 'unassuming', 'bashful', 'timid', 'quiet'],
  CoreValues.sincerity: ['honesty', 'genuineness', 'truthfulness', 'authenticity', 'sincerity', 'authenticity', 'integrity', 'honesty', 'sincerity', 'truthfulness', 'trustworthiness', 'genuineness', 'candor', 'uprightness', 'veracity', 'faithfulness', 'forthrightness', 'openness', 'candidness', 'frankness', 'sincerity', 'honest', 'genuine', 'truthful', 'authentic', 'transparent', 'honesty', 'sincerity', 'truthfulness', 'genuineness', 'trustworthiness', 'integrity', 'authenticity', 'sincerity', 'genuineness', 'honest', 'transparent', 'forthright', 'candid', 'truthful', 'open', 'sincere', 'authentic', 'truth', 'sincerity', 'honesty', 'integrity'],
  CoreValues.peace: ['tranquility', 'harmony', 'serenity', 'calmness', 'peace', 'peacefulness', 'serenity', 'calm', 'tranquility', 'quiet', 'relaxation', 'stillness', 'quietude', 'contentment', 'repose', 'quietness', 'serenity', 'harmony', 'placidity', 'peacefulness', 'peaceful', 'quietness', 'calmness', 'serenity', 'tranquility', 'peacefulness', 'restfulness', 'harmony', 'stillness', 'quietude', 'contentment', 'serenity', 'calmness', 'peacefulness', 'placidity', 'tranquility', 'quietness', 'serenity', 'harmony', 'peacefulness', 'peaceful', 'quietness', 'calmness', 'serenity', 'tranquility', 'peacefulness', 'repose', 'contentment'],
  CoreValues.equanimity: ['composure', 'balance', 'poise', 'stability', 'equanimity', 'calmness', 'serenity', 'composure', 'balance', 'poise', 'serenity', 'tranquility', 'equanimity', 'calm', 'steadiness', 'serenity', 'composure', 'poise', 'tranquility', 'balance', 'serenity', 'equanimity', 'calmness', 'self-possession', 'serenity', 'composure', 'tranquility', 'balance', 'equanimity', 'calmness', 'poise', 'serenity', 'steadiness', 'composure', 'tranquility', 'equanimity', 'calm', 'self-control', 'poise', 'serenity', 'balance', 'calmness', 'tranquility', 'equanimity', 'serenity', 'composure', 'balance', 'poise'],
  CoreValues.generosity: ['kindness', 'benevolence', 'charity', 'altruism', 'generosity', 'kindness', 'benevolence', 'charity', 'altruism', 'magnanimity', 'liberality', 'philanthropy', 'beneficence', 'munificence', 'open-handedness', 'compassion', 'bounty', 'largess', 'goodwill', 'charitableness', 'giving', 'beneficence', 'kindheartedness', 'big-heartedness', 'openness', 'sympathy', 'humanity', 'empathy', 'caring', 'compassion', 'generosity', 'kindness', 'benevolence', 'charity', 'altruism', 'magnanimity', 'liberality', 'philanthropy', 'beneficence', 'munificence', 'open-handedness', 'compassion', 'bounty', 'largess', 'goodwill', 'charitableness', 'giving', 'beneficence'],
  CoreValues.goodness: ['virtue', 'morality', 'righteousness', 'decency', 'goodness', 'virtue', 'morality', 'righteousness', 'decency', 'integrity', 'goodness', 'excellence', 'uprightness', 'honor', 'nobility', 'purity', 'righteousness', 'propriety', 'rectitude', 'ethicality', 'moral', 'wholesomeness', 'worthiness', 'exemplary', 'admirable', 'ethical', 'honorable', 'noble', 'pure', 'righteous', 'decent', 'upright', 'honest', 'good', 'virtuous', 'moral', 'ethical', 'righteous', 'principled', 'noble', 'upstanding', 'honest', 'decent', 'moral', 'exemplary', 'virtue', 'morality'],
  CoreValues.courage: ['bravery', 'fearlessness', 'valor', 'boldness', 'courage', 'bravery', 'fearlessness', 'valor', 'boldness', 'daring', 'heroism', 'fortitude', 'gallantry', 'intrepidity', 'audacity', 'nerve', 'pluck', 'valor', 'guts', 'determination', 'courageousness', 'resolution', 'fearlessness', 'braveness', 'spiritedness', 'courageous', 'boldness', 'daring', 'valiant', 'fearless', 'intrepid', 'brave', 'dauntless', 'undaunted', 'gallant', 'heroic', 'bold', 'valorous', 'fearless', 'intrepid', 'courageous', 'daring', 'bravery', 'fearlessness', 'valor', 'boldness', 'courage', 'bravery']
};
