import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:resume_app/model/job_career.dart';
import 'package:resume_app/model/person.dart';

import '../model/technical_os.dart';
import '../model/technical_skill.dart';

final userProvider = StateProvider((ref) => 'tani');

final personProvider = StateProvider((ref) => Person(
    id: 2,
    name: "谷内　伸輔神",
    ruby: "たにうち　しんすけ",
    initial: "S.T",
    sex: 3,
    age: 34,
    contractType: 1,
    description:
        "＜身についた知識・スキル＞\n・業務用基幹システム構築業務で身につけたプロジェクト全体をマネジメントするスキル\n・社内関係部署の要望を把握し、協力会社との調整・折衝を経験したことから得た課題を把握する力、解決策を提示し遂行する力\n・システム全般に関する包括的な知識・スキル",
    station: "JRおおさか東線　高井田中央",
    favoriteSkill: ['COBOL', 'Vue', 'Python'],
    image:
        "https://static.rtrp.jp/article/131658/images/131658a327d71f-736a-4fb7-8352-29be1f6da1e9_m.jpg",
    experience: 8,
    lastUpdateDate: new DateTime(2021, 11, 12, 17, 30),
    technicalSkillList: [
      TechnicalSkill(skillId: 'react', monthOfSkill: 25),
      TechnicalSkill(skillId: 'vue', monthOfSkill: 24),
      TechnicalSkill(skillId: 'java', monthOfSkill: 24),
      TechnicalSkill(skillId: 'php', monthOfSkill: 12),
      TechnicalSkill(skillId: 'flutter', monthOfSkill: 24),
      TechnicalSkill(skillId: 'vba', monthOfSkill: 36),
      TechnicalSkill(skillId: 'python', monthOfSkill: 36)
    ],
    jobCareerList: [
      JobCareer(
          careerId: 1,
          careerPeriodFrom: DateTime(2019, 11, 01),
          careerPeriodTo: DateTime(2019, 12, 31),
          content: "高速道路に表示する電光掲示の遠隔操作システム",
          phaseInCharge: "フロントエンド",
          role: 4,
          usedTechnicalSkillList: [
            const TechnicalSkill(skillId: 'vue', monthOfSkill: 2),
          ]),
      JobCareer(
          careerId: 2,
          careerPeriodFrom: DateTime(2020, 01, 01),
          careerPeriodTo: DateTime(2021, 08, 31),
          content: "空調機器設置遠隔操作システム",
          phaseInCharge: "フロントエンド\n要件定義～テスト",
          role: 4,
          usedTechnicalOSList: [
            const TechnicalOS(osId: 'mac', monthOfOS: 8),
          ],
          usedTechnicalSkillList: [
            const TechnicalSkill(skillId: 'react', monthOfSkill: 8),
            const TechnicalSkill(skillId: 'type_script', monthOfSkill: 7),
          ]),
      JobCareer(
          careerId: 3,
          careerPeriodFrom: DateTime(2020, 01, 01),
          careerPeriodTo: DateTime(2021, 08, 31),
          content: "空調機器設置遠隔操作システム",
          phaseInCharge: "フロントエンド\n要件定義～テスト",
          role: 4,
          usedTechnicalOSList: [
            const TechnicalOS(osId: 'mac', monthOfOS: 8),
          ],
          usedTechnicalSkillList: [
            const TechnicalSkill(skillId: 'react', monthOfSkill: 8),
            const TechnicalSkill(skillId: 'type_script', monthOfSkill: 7),
          ]),
      JobCareer(
          careerId: 4,
          careerPeriodFrom: DateTime(2020, 01, 01),
          careerPeriodTo: DateTime(2021, 08, 31),
          content: "空調機器設置遠隔操作システム",
          phaseInCharge: "フロントエンド\n要件定義～テスト",
          role: 4,
          usedTechnicalOSList: [
            const TechnicalOS(osId: 'mac', monthOfOS: 8),
          ],
          usedTechnicalSkillList: [
            const TechnicalSkill(skillId: 'react', monthOfSkill: 8),
            const TechnicalSkill(skillId: 'type_script', monthOfSkill: 7),
          ]),
      JobCareer(
          careerId: 5,
          careerPeriodFrom: DateTime(2020, 01, 01),
          careerPeriodTo: DateTime(2021, 08, 31),
          content: "空調機器設置遠隔操作システム",
          phaseInCharge: "フロントエンド\n要件定義～テスト",
          role: 4,
          usedTechnicalOSList: [
            const TechnicalOS(osId: 'mac', monthOfOS: 8),
          ],
          usedTechnicalSkillList: [
            const TechnicalSkill(skillId: 'react', monthOfSkill: 8),
            const TechnicalSkill(skillId: 'type_script', monthOfSkill: 7),
          ]),
      JobCareer(
          careerId: 6,
          careerPeriodFrom: DateTime(2020, 01, 01),
          careerPeriodTo: DateTime(2021, 08, 31),
          content: "空調機器設置遠隔操作システム",
          phaseInCharge: "フロントエンド\n要件定義～テスト",
          role: 4,
          usedTechnicalOSList: [
            const TechnicalOS(osId: 'mac', monthOfOS: 8),
          ],
          usedTechnicalSkillList: [
            const TechnicalSkill(skillId: 'react', monthOfSkill: 8),
            const TechnicalSkill(skillId: 'type_script', monthOfSkill: 7),
          ]),
      JobCareer(
          careerId: 7,
          careerPeriodFrom: DateTime(2020, 01, 01),
          careerPeriodTo: DateTime(2021, 08, 31),
          content: "空調機器設置遠隔操作システム",
          phaseInCharge: "フロントエンド\n要件定義～テスト",
          role: 4,
          usedTechnicalOSList: [
            const TechnicalOS(osId: 'mac', monthOfOS: 8),
          ],
          usedTechnicalSkillList: [
            const TechnicalSkill(skillId: 'react', monthOfSkill: 8),
            const TechnicalSkill(skillId: 'type_script', monthOfSkill: 7),
          ]),
    ]));
