import 'package:resume_app/model/job_career.dart';
import 'package:resume_app/model/person.dart';
import 'package:resume_app/model/technical_db.dart';
import 'package:resume_app/model/technical_os.dart';
import 'package:resume_app/model/technical_skill.dart';

List<Person> exampleList = [
  Person(
    id: "ymorinaga",
    name: "渡部　悠貴",
    ruby: "わたなべ　ゆうき",
    initial: "Y.W",
    sex: 1,
    birthDay: DateTime(1992, 11, 19),
    contractType: 1,
    station: "地下鉄御堂筋線　江坂",
    favoriteSkill: ['React', 'Vue', 'java'],
    description:
        "××年間にわたり、情報システム部において社内ネットワークの構築・運用業務を担当。\n業務用基幹システムの要件定義から導入後の保守運用まで一連の業務を遂行しました。",
    image:
        "https://static.rtrp.jp/article/131658/images/131658a327d71f-736a-4fb7-8352-29be1f6da1e9_m.jpg",
    experience: 8,
    updateDate: DateTime(2022, 11, 11, 17, 30),
    technicalSkillList: [
      TechnicalSkill(skillId: 'react', month: 38),
      TechnicalSkill(skillId: 'vue', month: 38),
      TechnicalSkill(skillId: 'java', month: 65),
      TechnicalSkill(skillId: 'php', month: 12),
      TechnicalSkill(skillId: 'flutter', month: 12),
      TechnicalSkill(skillId: 'vba', month: 12)
    ],
    jobCareerList: [
      JobCareer(
          careerId: 1,
          careerPeriodFrom: DateTime(2019, 11, 01),
          careerPeriodTo: DateTime(2019, 12, 31),
          content: "高速道路に表示する電光掲示の遠隔操作システム",
          phase: [1, 2, 3, 4, 5],
          role: 4,
          usedTechnicalSkillList: [
            TechnicalSkill(skillId: 'vue', month: 2),
          ]),
      JobCareer(
          careerId: 2,
          careerPeriodFrom: DateTime(2020, 01, 01),
          careerPeriodTo: DateTime(2021, 08, 31),
          content: "空調機器設置遠隔操作システム",
          phase: [3, 4, 5],
          role: 4,
          usedTechnicalOSList: [
            TechnicalOS(osId: 'mac', month: 8),
          ],
          usedTechnicalSkillList: [
            TechnicalSkill(skillId: 'react', month: 8),
            TechnicalSkill(skillId: 'type_script', month: 7),
          ])
    ],
  ),
  Person(
      id: "staniuchi",
      name: "谷内　伸輔神",
      ruby: "たにうち　しんすけ",
      initial: "S.T",
      sex: 3,
      birthDay: DateTime(1988, 10, 18),
      contractType: 1,
      description:
          "＜身についた知識・スキル＞\n・業務用基幹システム構築業務で身につけたプロジェクト全体をマネジメントするスキル\n・社内関係部署の要望を把握し、協力会社との調整・折衝を経験したことから得た課題を把握する力、解決策を提示し遂行する力\n・システム全般に関する包括的な知識・スキル",
      station: "JRおおさか東線　高井田中央",
      favoriteSkill: ['COBOL', 'Vue', 'Python'],
      image:
          "https://static.rtrp.jp/article/131658/images/131658a327d71f-736a-4fb7-8352-29be1f6da1e9_m.jpg",
      experience: 8,
      updateDate: new DateTime(2021, 11, 12, 17, 30),
      technicalSkillList: [
        TechnicalSkill(skillId: 'react', month: 25),
        TechnicalSkill(skillId: 'vue', month: 24),
        TechnicalSkill(skillId: 'java', month: 24),
        TechnicalSkill(skillId: 'php', month: 12),
        TechnicalSkill(skillId: 'flutter', month: 24),
        TechnicalSkill(skillId: 'vba', month: 36),
        TechnicalSkill(skillId: 'python', month: 36)
      ],
      jobCareerList: [
        JobCareer(
            careerId: 1,
            careerPeriodFrom: DateTime(2019, 11, 01),
            careerPeriodTo: DateTime(2019, 12, 31),
            content: "高速道路に表示する電光掲示の遠隔操作システム",
            phase: [3, 4, 5],
            role: 4,
            usedTechnicalSkillList: [
              TechnicalSkill(skillId: 'vue', month: 2),
            ]),
        JobCareer(
            careerId: 2,
            careerPeriodFrom: DateTime(2020, 01, 01),
            careerPeriodTo: DateTime(2021, 08, 31),
            content: "空調機器設置遠隔操作システム",
            phase: [3, 4, 5, 6],
            role: 4,
            usedTechnicalOSList: [
              TechnicalOS(osId: 'mac', month: 8),
            ],
            usedTechnicalSkillList: [
              TechnicalSkill(skillId: 'react', month: 8),
              TechnicalSkill(skillId: 'type_script', month: 7),
            ]),
        JobCareer(
            careerId: 3,
            careerPeriodFrom: DateTime(2020, 01, 01),
            careerPeriodTo: DateTime(2021, 08, 31),
            content: "空調機器設置遠隔操作システム",
            phase: [3, 4, 5, 6],
            role: 4,
            usedTechnicalOSList: [
              TechnicalOS(osId: 'mac', month: 8),
            ],
            usedTechnicalSkillList: [
              TechnicalSkill(skillId: 'react', month: 8),
              TechnicalSkill(skillId: 'type_script', month: 7),
            ]),
        JobCareer(
            careerId: 4,
            careerPeriodFrom: DateTime(2020, 01, 01),
            careerPeriodTo: DateTime(2021, 08, 31),
            content: "空調機器設置遠隔操作システム",
            phase: [3, 4, 5, 6],
            role: 4,
            usedTechnicalOSList: [
              TechnicalOS(osId: 'mac', month: 8),
            ],
            usedTechnicalSkillList: [
              TechnicalSkill(skillId: 'react', month: 8),
              TechnicalSkill(skillId: 'type_script', month: 7),
            ]),
        JobCareer(
            careerId: 5,
            careerPeriodFrom: DateTime(2020, 01, 01),
            careerPeriodTo: DateTime(2021, 08, 31),
            content: "空調機器設置遠隔操作システム",
            phase: [3, 4, 5, 6],
            role: 4,
            usedTechnicalOSList: [
              TechnicalOS(osId: 'mac', month: 8),
            ],
            usedTechnicalSkillList: [
              TechnicalSkill(skillId: 'react', month: 8),
              TechnicalSkill(skillId: 'type_script', month: 7),
            ]),
        JobCareer(
            careerId: 6,
            careerPeriodFrom: DateTime(2020, 01, 01),
            careerPeriodTo: DateTime(2021, 08, 31),
            content: "空調機器設置遠隔操作システム",
            phase: [3, 4, 5, 6],
            role: 4,
            usedTechnicalOSList: [
              TechnicalOS(osId: 'mac', month: 8),
            ],
            usedTechnicalSkillList: [
              TechnicalSkill(skillId: 'react', month: 8),
              TechnicalSkill(skillId: 'type_script', month: 7),
            ]),
        JobCareer(
            careerId: 7,
            careerPeriodFrom: DateTime(2020, 01, 01),
            careerPeriodTo: DateTime(2021, 08, 31),
            content: "空調機器設置遠隔操作システム",
            phase: [3, 4, 5, 6],
            role: 4,
            usedTechnicalOSList: [
              TechnicalOS(osId: 'mac', month: 8),
            ],
            usedTechnicalSkillList: [
              TechnicalSkill(skillId: 'react', month: 8),
              TechnicalSkill(skillId: 'type_script', month: 7),
            ]),
      ]),
  Person(
      id: "rtaira",
      name: "平　凌侑",
      ruby: "たいら　りょうすけ",
      initial: "R.T",
      sex: 1,
      birthDay: DateTime(1992, 8, 5),
      contractType: 1,
      description:
          "●●業界向けのWEBアプリケーション開発を約●年経験しております。\n要件定義〜テスト、導入までの上流工程から下流工程まで幅広い経験があります。また、現在はリーダー職を務めております。",
      station: "地下鉄御堂筋線　東三国",
      favoriteSkill: ['vba'],
      image:
          "https://static.rtrp.jp/article/131658/images/131658a327d71f-736a-4fb7-8352-29be1f6da1e9_m.jpg",
      experience: 6,
      updateDate: new DateTime(2022, 2, 2, 2, 2),
      technicalOSList: [
        TechnicalOS(osId: 'linux', month: 7),
        TechnicalOS(osId: 'unix', month: 10),
        TechnicalOS(osId: 'windows', month: 12),
      ],
      technicalDBList: [
        TechnicalDB(dbId: 'snowfleak', month: 7),
        TechnicalDB(dbId: 'oracle', month: 12),
        TechnicalDB(dbId: 'mysql', month: 9),
      ],
      jobCareerList: [
        JobCareer(
          careerId: 1,
          careerPeriodFrom: DateTime(2020, 06, 01),
          careerPeriodTo: DateTime(2019, 12, 31),
          content: "システム監視",
          phase: [3, 4, 5, 6],
          role: 4,
          usedTechnicalOSList: [
            TechnicalOS(osId: 'linux', month: 7),
            TechnicalOS(osId: 'unix', month: 3),
          ],
          usedTechnicalDBList: [
            TechnicalDB(dbId: 'snowfleak', month: 7),
          ],
        ),
        JobCareer(
          careerId: 1,
          careerPeriodFrom: DateTime(2021, 01, 01),
          careerPeriodTo: DateTime(2011, 12, 31),
          content: "システム監視",
          phase: [3, 4, 5, 6],
          role: 4,
          usedTechnicalOSList: [
            TechnicalOS(osId: 'windows', month: 12),
            TechnicalOS(osId: 'unix', month: 7),
          ],
          usedTechnicalDBList: [
            TechnicalDB(dbId: 'oracle', month: 12),
            TechnicalDB(dbId: 'mysql', month: 9),
          ],
        ),
      ]),
];
