import 'package:resume_app/model/job_career.dart';
import 'package:resume_app/model/person.dart';
import 'package:resume_app/model/technical_db.dart';
import 'package:resume_app/model/technical_os.dart';
import 'package:resume_app/model/technical_skill.dart';

List<Person> exampleList = [
  Person(
    id: 1,
    name: "渡部　悠貴",
    ruby: "わたなべ　ゆうき",
    initial: "Y.W",
    sex: 1,
    age: 29,
    contractType: 1,
    station: "地下鉄御堂筋線　江坂",
    favoriteSkill: ['React', 'Vue', 'java'],
    description:
        "××年間にわたり、情報システム部において社内ネットワークの構築・運用業務を担当。\n業務用基幹システムの要件定義から導入後の保守運用まで一連の業務を遂行しました。",
    image:
        "https://static.rtrp.jp/article/131658/images/131658a327d71f-736a-4fb7-8352-29be1f6da1e9_m.jpg",
    experience: 8,
    lastUpdateDate: DateTime(2022, 11, 11, 17, 30),
    technicalSkillList: [
      const TechnicalSkill(skillId: 'react', yearsOfSkill: 38),
      const TechnicalSkill(skillId: 'vue', yearsOfSkill: 38),
      const TechnicalSkill(skillId: 'java', yearsOfSkill: 65),
      const TechnicalSkill(skillId: 'php', yearsOfSkill: 12),
      const TechnicalSkill(skillId: 'flutter', yearsOfSkill: 12),
      const TechnicalSkill(skillId: 'vba', yearsOfSkill: 12)
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
            const TechnicalSkill(skillId: 'vue', yearsOfSkill: 2),
          ]),
      JobCareer(
          careerId: 2,
          careerPeriodFrom: DateTime(2020, 01, 01),
          careerPeriodTo: DateTime(2021, 08, 31),
          content: "空調機器設置遠隔操作システム",
          phaseInCharge: "フロントエンド\n　要件定義～テスト",
          role: 4,
          usedTechnicalOSList: [
            const TechnicalOS(osId: 'mac', yearsOfOS: 8),
          ],
          usedTechnicalSkillList: [
            const TechnicalSkill(skillId: 'react', yearsOfSkill: 8),
            const TechnicalSkill(skillId: 'type_script', yearsOfSkill: 7),
          ])
    ],
  ),
  Person(
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
        TechnicalSkill(skillId: 'react', yearsOfSkill: 25),
        TechnicalSkill(skillId: 'vue', yearsOfSkill: 24),
        TechnicalSkill(skillId: 'java', yearsOfSkill: 24),
        TechnicalSkill(skillId: 'php', yearsOfSkill: 12),
        TechnicalSkill(skillId: 'flutter', yearsOfSkill: 24),
        TechnicalSkill(skillId: 'vba', yearsOfSkill: 36),
        TechnicalSkill(skillId: 'python', yearsOfSkill: 36)
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
              const TechnicalSkill(skillId: 'vue', yearsOfSkill: 2),
            ]),
        JobCareer(
            careerId: 2,
            careerPeriodFrom: DateTime(2020, 01, 01),
            careerPeriodTo: DateTime(2021, 08, 31),
            content: "空調機器設置遠隔操作システム",
            phaseInCharge: "フロントエンド\n要件定義～テスト",
            role: 4,
            usedTechnicalOSList: [
              const TechnicalOS(osId: 'mac', yearsOfOS: 8),
            ],
            usedTechnicalSkillList: [
              const TechnicalSkill(skillId: 'react', yearsOfSkill: 8),
              const TechnicalSkill(skillId: 'type_script', yearsOfSkill: 7),
            ]),
        JobCareer(
            careerId: 3,
            careerPeriodFrom: DateTime(2020, 01, 01),
            careerPeriodTo: DateTime(2021, 08, 31),
            content: "空調機器設置遠隔操作システム",
            phaseInCharge: "フロントエンド\n要件定義～テスト",
            role: 4,
            usedTechnicalOSList: [
              const TechnicalOS(osId: 'mac', yearsOfOS: 8),
            ],
            usedTechnicalSkillList: [
              const TechnicalSkill(skillId: 'react', yearsOfSkill: 8),
              const TechnicalSkill(skillId: 'type_script', yearsOfSkill: 7),
            ]),
        JobCareer(
            careerId: 4,
            careerPeriodFrom: DateTime(2020, 01, 01),
            careerPeriodTo: DateTime(2021, 08, 31),
            content: "空調機器設置遠隔操作システム",
            phaseInCharge: "フロントエンド\n要件定義～テスト",
            role: 4,
            usedTechnicalOSList: [
              const TechnicalOS(osId: 'mac', yearsOfOS: 8),
            ],
            usedTechnicalSkillList: [
              const TechnicalSkill(skillId: 'react', yearsOfSkill: 8),
              const TechnicalSkill(skillId: 'type_script', yearsOfSkill: 7),
            ]),
        JobCareer(
            careerId: 5,
            careerPeriodFrom: DateTime(2020, 01, 01),
            careerPeriodTo: DateTime(2021, 08, 31),
            content: "空調機器設置遠隔操作システム",
            phaseInCharge: "フロントエンド\n要件定義～テスト",
            role: 4,
            usedTechnicalOSList: [
              const TechnicalOS(osId: 'mac', yearsOfOS: 8),
            ],
            usedTechnicalSkillList: [
              const TechnicalSkill(skillId: 'react', yearsOfSkill: 8),
              const TechnicalSkill(skillId: 'type_script', yearsOfSkill: 7),
            ]),
        JobCareer(
            careerId: 6,
            careerPeriodFrom: DateTime(2020, 01, 01),
            careerPeriodTo: DateTime(2021, 08, 31),
            content: "空調機器設置遠隔操作システム",
            phaseInCharge: "フロントエンド\n要件定義～テスト",
            role: 4,
            usedTechnicalOSList: [
              const TechnicalOS(osId: 'mac', yearsOfOS: 8),
            ],
            usedTechnicalSkillList: [
              const TechnicalSkill(skillId: 'react', yearsOfSkill: 8),
              const TechnicalSkill(skillId: 'type_script', yearsOfSkill: 7),
            ]),
        JobCareer(
            careerId: 7,
            careerPeriodFrom: DateTime(2020, 01, 01),
            careerPeriodTo: DateTime(2021, 08, 31),
            content: "空調機器設置遠隔操作システム",
            phaseInCharge: "フロントエンド\n要件定義～テスト",
            role: 4,
            usedTechnicalOSList: [
              const TechnicalOS(osId: 'mac', yearsOfOS: 8),
            ],
            usedTechnicalSkillList: [
              const TechnicalSkill(skillId: 'react', yearsOfSkill: 8),
              const TechnicalSkill(skillId: 'type_script', yearsOfSkill: 7),
            ]),
      ]),
  Person(
    id: 3,
    name: "シュヴァシイシュ ポル シャゴルシュヴァシイシュ ポル シャゴル",
    ruby: "シュヴァシイシュ ポル シャゴルシュヴァシイシュ ポル シャゴル",
    initial: "S.S",
    sex: 1,
    age: 35,
    contractType: 1,
    description:
        "●●業界向けのWEBアプリケーション開発を約●年経験しております。\n要件定義〜テスト、導入までの上流工程から下流工程まで幅広い経験があります。また、現在はリーダー職を務めております。",
    station: "JRおおさか東線　鴫野",
    favoriteSkill: [
      'C#',
      'COBOL',
      'Vue',
      'Python',
      'php',
      'java',
      'Rust',
    ],
    image:
        "https://static.rtrp.jp/article/131658/images/131658a327d71f-736a-4fb7-8352-29be1f6da1e9_m.jpg",
    experience: 4,
    lastUpdateDate: new DateTime(2022, 3, 9, 1, 30),
    technicalSkillList: [
      TechnicalSkill(skillId: 'java', yearsOfSkill: 24),
    ],
  ),
  Person(
      id: 4,
      name: "山尾　貴之",
      ruby: "やまお　たかゆき",
      initial: "T.Y",
      sex: 1,
      age: 34,
      contractType: 1,
      description:
          "××年間にわたり、情報システム部において社内ネットワークの構築・運用業務を担当。\n業務用基幹システムの要件定義から導入後の保守運用まで一連の業務を遂行しました。",
      station: "JR奈良　坊城",
      favoriteSkill: ['php', 'Vue', 'java'],
      image:
          "https://static.rtrp.jp/article/131658/images/131658a327d71f-736a-4fb7-8352-29be1f6da1e9_m.jpg",
      experience: 8,
      lastUpdateDate: new DateTime(2020, 5, 1, 1, 01),
      technicalSkillList: [
        TechnicalSkill(skillId: 'react', yearsOfSkill: 6),
        TechnicalSkill(skillId: 'vue', yearsOfSkill: 12),
        TechnicalSkill(skillId: 'java', yearsOfSkill: 60),
        TechnicalSkill(skillId: 'php', yearsOfSkill: 120),
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
              const TechnicalSkill(skillId: 'vue', yearsOfSkill: 2),
            ]),
        JobCareer(
            careerId: 2,
            careerPeriodFrom: DateTime(2020, 01, 01),
            careerPeriodTo: DateTime(2021, 08, 31),
            content: "空調機器設置遠隔操作システム",
            phaseInCharge: "フロントエンド\n要件定義～テスト",
            role: 4,
            usedTechnicalOSList: [
              const TechnicalOS(osId: 'mac', yearsOfOS: 8),
            ],
            usedTechnicalSkillList: [
              const TechnicalSkill(skillId: 'react', yearsOfSkill: 8),
              const TechnicalSkill(skillId: 'type_script', yearsOfSkill: 7),
            ]),
      ]),
  Person(
      id: 5,
      name: "平　凌侑",
      ruby: "たいら　りょうすけ",
      initial: "R.T",
      sex: 1,
      age: 29,
      contractType: 1,
      description:
          "●●業界向けのWEBアプリケーション開発を約●年経験しております。\n要件定義〜テスト、導入までの上流工程から下流工程まで幅広い経験があります。また、現在はリーダー職を務めております。",
      station: "地下鉄御堂筋線　東三国",
      favoriteSkill: ['vba'],
      image:
          "https://static.rtrp.jp/article/131658/images/131658a327d71f-736a-4fb7-8352-29be1f6da1e9_m.jpg",
      experience: 6,
      lastUpdateDate: new DateTime(2022, 2, 2, 2, 2),
      technicalOSList: [
        const TechnicalOS(osId: 'linux', yearsOfOS: 7),
        const TechnicalOS(osId: 'unix', yearsOfOS: 10),
        const TechnicalOS(osId: 'windows', yearsOfOS: 12),
      ],
      technicalDBList: [
        const TechnicalDB(dbId: 'snowfleak', yearsOfDB: 7),
        const TechnicalDB(dbId: 'oracle', yearsOfDB: 12),
        const TechnicalDB(dbId: 'mysql', yearsOfDB: 9),
      ],
      jobCareerList: [
        JobCareer(
          careerId: 1,
          careerPeriodFrom: DateTime(2020, 06, 01),
          careerPeriodTo: DateTime(2019, 12, 31),
          content: "システム監視",
          phaseInCharge: "インフラ",
          role: 4,
          usedTechnicalOSList: [
            const TechnicalOS(osId: 'linux', yearsOfOS: 7),
            const TechnicalOS(osId: 'unix', yearsOfOS: 3),
          ],
          usedTechnicalDBList: [
            const TechnicalDB(dbId: 'snowfleak', yearsOfDB: 7),
          ],
        ),
        JobCareer(
          careerId: 1,
          careerPeriodFrom: DateTime(2021, 01, 01),
          careerPeriodTo: DateTime(2011, 12, 31),
          content: "システム監視",
          phaseInCharge: "インフラ",
          role: 4,
          usedTechnicalOSList: [
            const TechnicalOS(osId: 'windows', yearsOfOS: 12),
            const TechnicalOS(osId: 'unix', yearsOfOS: 7),
          ],
          usedTechnicalDBList: [
            const TechnicalDB(dbId: 'oracle', yearsOfDB: 12),
            const TechnicalDB(dbId: 'mysql', yearsOfDB: 9),
          ],
        ),
      ]),
  Person(
      id: 6,
      name: "渡部　悠貴",
      ruby: "わたなべ　ゆうき",
      initial: "Y.W",
      sex: 1,
      age: 29,
      contractType: 1,
      description:
          "●●業界向けのWEBアプリケーション開発を約●年経験しております。\n要件定義〜テスト、導入までの上流工程から下流工程まで幅広い経験があります。また、現在はリーダー職を務めております。",
      station: "地下鉄御堂筋線　江坂",
      favoriteSkill: ['React', 'Vue', 'java'],
      image:
          "https://static.rtrp.jp/article/131658/images/131658a327d71f-736a-4fb7-8352-29be1f6da1e9_m.jpg",
      experience: 8,
      lastUpdateDate: new DateTime(2022, 11, 11, 17, 30),
      technicalSkillList: [
        TechnicalSkill(skillId: 'react', yearsOfSkill: 36),
        TechnicalSkill(skillId: 'vue', yearsOfSkill: 36),
        TechnicalSkill(skillId: 'java', yearsOfSkill: 60),
        TechnicalSkill(skillId: 'php', yearsOfSkill: 12),
        TechnicalSkill(skillId: 'flutter', yearsOfSkill: 12),
        TechnicalSkill(skillId: 'vba', yearsOfSkill: 12)
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
              const TechnicalSkill(skillId: 'vue', yearsOfSkill: 2),
            ]),
        JobCareer(
            careerId: 2,
            careerPeriodFrom: DateTime(2020, 01, 01),
            careerPeriodTo: DateTime(2021, 08, 31),
            content: "空調機器設置遠隔操作システム",
            phaseInCharge: "フロントエンド\n要件定義～テスト",
            role: 4,
            usedTechnicalOSList: [
              const TechnicalOS(osId: 'mac', yearsOfOS: 8),
            ],
            usedTechnicalSkillList: [
              const TechnicalSkill(skillId: 'react', yearsOfSkill: 8),
              const TechnicalSkill(skillId: 'type_script', yearsOfSkill: 7),
            ]),
      ]),
  Person(
      id: 7,
      name: "谷内　伸輔",
      ruby: "たにうち　しんすけ",
      initial: "S.T",
      sex: 1,
      age: 34,
      contractType: 1,
      description:
          "××年間にわたり、情報システム部において社内ネットワークの構築・運用業務を担当。\n業務用基幹システムの要件定義から導入後の保守運用まで一連の業務を遂行しました。",
      station: "JRおおさか東線　高井田中央",
      favoriteSkill: ['COBOL', 'Vue', 'Python'],
      image:
          "https://static.rtrp.jp/article/131658/images/131658a327d71f-736a-4fb7-8352-29be1f6da1e9_m.jpg",
      experience: 8,
      lastUpdateDate: new DateTime(2022, 11, 11, 17, 30),
      technicalSkillList: [
        TechnicalSkill(skillId: 'react', yearsOfSkill: 25),
        TechnicalSkill(skillId: 'vue', yearsOfSkill: 24),
        TechnicalSkill(skillId: 'java', yearsOfSkill: 24),
        TechnicalSkill(skillId: 'php', yearsOfSkill: 12),
        TechnicalSkill(skillId: 'flutter', yearsOfSkill: 24),
        TechnicalSkill(skillId: 'vba', yearsOfSkill: 36),
        TechnicalSkill(skillId: 'python', yearsOfSkill: 36)
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
              const TechnicalSkill(skillId: 'vue', yearsOfSkill: 2),
            ]),
        JobCareer(
            careerId: 2,
            careerPeriodFrom: DateTime(2020, 01, 01),
            careerPeriodTo: DateTime(2021, 08, 31),
            content: "空調機器設置遠隔操作システム",
            phaseInCharge: "フロントエンド\n要件定義～テスト",
            role: 4,
            usedTechnicalOSList: [
              const TechnicalOS(osId: 'mac', yearsOfOS: 8),
            ],
            usedTechnicalSkillList: [
              const TechnicalSkill(skillId: 'react', yearsOfSkill: 8),
              const TechnicalSkill(skillId: 'type_script', yearsOfSkill: 7),
            ]),
      ]),
  Person(
    id: 8,
    name: "保木本　大貴",
    ruby: "ほきもと　ひろき",
    initial: "H.H",
    sex: 1,
    age: 35,
    contractType: 2,
    description:
        "＜身についた知識・スキル＞\n・業務用基幹システム構築業務で身につけたプロジェクト全体をマネジメントするスキル\n・社内関係部署の要望を把握し、協力会社との調整・折衝を\n　経験したことから得た課題を把握する力、解決策を提示し遂行する力\n・システム全般に関する包括的な知識・スキル",
    station: "JRおおさか東線　鴫野",
    favoriteSkill: ['パッション'],
    image:
        "https://static.rtrp.jp/article/131658/images/131658a327d71f-736a-4fb7-8352-29be1f6da1e9_m.jpg",
    experience: 8,
    lastUpdateDate: new DateTime(2022, 2, 2, 2, 2),
    technicalSkillList: [
      TechnicalSkill(skillId: 'パッション', yearsOfSkill: 14),
      TechnicalSkill(skillId: '人の話を聞かない', yearsOfSkill: 432),
    ],
  ),
  Person(
      id: 9,
      name: "山尾　貴之",
      ruby: "やまお　たかゆき",
      initial: "T.Y",
      sex: 1,
      age: 34,
      contractType: 1,
      description:
          "＜身についた知識・スキル＞\n・業務用基幹システム構築業務で身につけたプロジェクト全体をマネジメントするスキル\n・社内関係部署の要望を把握し、協力会社との調整・折衝を\n　経験したことから得た課題を把握する力、解決策を提示し遂行する力\n・システム全般に関する包括的な知識・スキル",
      station: "JR奈良　坊城",
      favoriteSkill: ['php', 'Vue', 'java'],
      image:
          "https://static.rtrp.jp/article/131658/images/131658a327d71f-736a-4fb7-8352-29be1f6da1e9_m.jpg",
      experience: 8,
      lastUpdateDate: new DateTime(2022, 2, 2, 2, 2),
      technicalSkillList: [
        TechnicalSkill(skillId: 'react', yearsOfSkill: 6),
        TechnicalSkill(skillId: 'vue', yearsOfSkill: 12),
        TechnicalSkill(skillId: 'java', yearsOfSkill: 60),
        TechnicalSkill(skillId: 'php', yearsOfSkill: 120),
      ],
      jobCareerList: [
        JobCareer(
            careerId: 1,
            careerPeriodFrom: DateTime(2019, 11, 01),
            careerPeriodTo: DateTime(2019, 12, 31),
            content: "高速道路に表示する電光掲示の遠隔操作システム",
            phaseInCharge: "フロントエンド",
            role: 5,
            usedTechnicalSkillList: [
              const TechnicalSkill(skillId: 'vue', yearsOfSkill: 2),
            ]),
        JobCareer(
            careerId: 2,
            careerPeriodFrom: DateTime(2020, 01, 01),
            careerPeriodTo: DateTime(2021, 08, 31),
            content: "空調機器設置遠隔操作システム",
            phaseInCharge: "フロントエンド\n要件定義～テスト",
            role: 4,
            usedTechnicalOSList: [
              const TechnicalOS(osId: 'mac', yearsOfOS: 8),
            ],
            usedTechnicalSkillList: [
              const TechnicalSkill(skillId: 'react', yearsOfSkill: 8),
              const TechnicalSkill(skillId: 'type_script', yearsOfSkill: 7),
            ]),
      ]),
  Person(
      id: 1,
      name: "平　凌侑",
      ruby: "たいら　りょうすけ",
      initial: "R.T",
      sex: 1,
      age: 29,
      contractType: 1,
      description:
          "××年間にわたり、情報システム部において社内ネットワークの構築・運用業務を担当。\n業務用基幹システムの要件定義から導入後の保守運用まで一連の業務を遂行しました。",
      station: "地下鉄御堂筋線　東三国",
      favoriteSkill: ['vba'],
      image:
          "https://static.rtrp.jp/article/131658/images/131658a327d71f-736a-4fb7-8352-29be1f6da1e9_m.jpg",
      experience: 6,
      lastUpdateDate: DateTime.now(),
      technicalOSList: [
        const TechnicalOS(osId: 'linux', yearsOfOS: 7),
        const TechnicalOS(osId: 'unix', yearsOfOS: 10),
        const TechnicalOS(osId: 'windows', yearsOfOS: 12),
      ],
      technicalDBList: [
        const TechnicalDB(dbId: 'snowfleak', yearsOfDB: 7),
        const TechnicalDB(dbId: 'oracle', yearsOfDB: 12),
        const TechnicalDB(dbId: 'mysql', yearsOfDB: 9),
      ],
      jobCareerList: [
        JobCareer(
          careerId: 1,
          careerPeriodFrom: DateTime(2020, 06, 01),
          careerPeriodTo: DateTime(2019, 12, 31),
          content: "システム監視",
          phaseInCharge: "インフラ",
          role: 5,
          usedTechnicalOSList: [
            const TechnicalOS(osId: 'linux', yearsOfOS: 7),
            const TechnicalOS(osId: 'unix', yearsOfOS: 3),
          ],
          usedTechnicalDBList: [
            const TechnicalDB(dbId: 'snowfleak', yearsOfDB: 7),
          ],
        ),
        JobCareer(
          careerId: 1,
          careerPeriodFrom: DateTime(2021, 01, 01),
          careerPeriodTo: DateTime(2011, 12, 31),
          content: "システム監視",
          phaseInCharge: "インフラ",
          role: 4,
          usedTechnicalOSList: [
            const TechnicalOS(osId: 'windows', yearsOfOS: 12),
            const TechnicalOS(osId: 'unix', yearsOfOS: 7),
          ],
          usedTechnicalDBList: [
            const TechnicalDB(dbId: 'oracle', yearsOfDB: 12),
            const TechnicalDB(dbId: 'mysql', yearsOfDB: 9),
          ],
        ),
      ]),
  Person(
      id: 1,
      name: "渡部　悠貴",
      ruby: "わたなべ　ゆうき",
      initial: "Y.W",
      sex: 1,
      age: 29,
      contractType: 1,
      description:
          "＜身についた知識・スキル＞\n・業務用基幹システム構築業務で身につけたプロジェクト全体をマネジメントするスキル\n・社内関係部署の要望を把握し、協力会社との調整・折衝を\n　経験したことから得た課題を把握する力、解決策を提示し遂行する力\n・システム全般に関する包括的な知識・スキル",
      station: "地下鉄御堂筋線　江坂",
      favoriteSkill: ['React', 'Vue', 'java'],
      image:
          "https://static.rtrp.jp/article/131658/images/131658a327d71f-736a-4fb7-8352-29be1f6da1e9_m.jpg",
      experience: 8,
      lastUpdateDate: new DateTime(2021, 11, 12, 17, 30),
      technicalSkillList: [
        TechnicalSkill(skillId: 'react', yearsOfSkill: 36),
        TechnicalSkill(skillId: 'vue', yearsOfSkill: 36),
        TechnicalSkill(skillId: 'java', yearsOfSkill: 60),
        TechnicalSkill(skillId: 'php', yearsOfSkill: 12),
        TechnicalSkill(skillId: 'flutter', yearsOfSkill: 12),
        TechnicalSkill(skillId: 'vba', yearsOfSkill: 12)
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
              const TechnicalSkill(skillId: 'vue', yearsOfSkill: 2),
            ]),
        JobCareer(
            careerId: 2,
            careerPeriodFrom: DateTime(2020, 01, 01),
            careerPeriodTo: DateTime(2021, 08, 31),
            content: "空調機器設置遠隔操作システム",
            phaseInCharge: "フロントエンド\n要件定義～テスト",
            role: 4,
            usedTechnicalOSList: [
              const TechnicalOS(osId: 'mac', yearsOfOS: 8),
            ],
            usedTechnicalSkillList: [
              const TechnicalSkill(skillId: 'react', yearsOfSkill: 8),
              const TechnicalSkill(skillId: 'type_script', yearsOfSkill: 7),
            ]),
      ]),
  Person(
      id: 1,
      name: "谷内　伸輔",
      ruby: "たにうち　しんすけ",
      initial: "S.T",
      sex: 1,
      age: 34,
      contractType: 1,
      description:
          "●●業界向けのWEBアプリケーション開発を約●年経験しております。\n要件定義〜テスト、導入までの上流工程から下流工程まで幅広い経験があります。また、現在はリーダー職を務めております。",
      station: "JRおおさか東線　高井田中央",
      favoriteSkill: ['COBOL', 'Vue', 'Python'],
      image:
          "https://static.rtrp.jp/article/131658/images/131658a327d71f-736a-4fb7-8352-29be1f6da1e9_m.jpg",
      experience: 8,
      lastUpdateDate: new DateTime(2021, 11, 12, 17, 30),
      technicalSkillList: [
        TechnicalSkill(skillId: 'react', yearsOfSkill: 4),
        TechnicalSkill(skillId: 'vue', yearsOfSkill: 25),
        TechnicalSkill(skillId: 'java', yearsOfSkill: 24),
        TechnicalSkill(skillId: 'php', yearsOfSkill: 12),
        TechnicalSkill(skillId: 'flutter', yearsOfSkill: 24),
        TechnicalSkill(skillId: 'vba', yearsOfSkill: 36),
        TechnicalSkill(skillId: 'python', yearsOfSkill: 36)
      ],
      jobCareerList: [
        JobCareer(
            careerId: 1,
            careerPeriodFrom: DateTime(2019, 11, 01),
            careerPeriodTo: DateTime(2019, 12, 31),
            content: "高速道路に表示する電光掲示の遠隔操作システム",
            phaseInCharge: "フロントエンド",
            role: 2,
            usedTechnicalSkillList: [
              const TechnicalSkill(skillId: 'vue', yearsOfSkill: 2),
            ]),
        JobCareer(
            careerId: 2,
            careerPeriodFrom: DateTime(2020, 01, 01),
            careerPeriodTo: DateTime(2021, 08, 31),
            content: "空調機器設置遠隔操作システム",
            phaseInCharge: "フロントエンド\n要件定義～テスト",
            role: 4,
            usedTechnicalOSList: [
              const TechnicalOS(osId: 'mac', yearsOfOS: 8),
            ],
            usedTechnicalSkillList: [
              const TechnicalSkill(skillId: 'react', yearsOfSkill: 8),
              const TechnicalSkill(skillId: 'type_script', yearsOfSkill: 7),
            ]),
      ]),
  Person(
    id: 1,
    name: "保木本　大貴",
    ruby: "ほきもと　ひろき",
    initial: "H.H",
    sex: 1,
    age: 35,
    contractType: 2,
    description:
        "●●業界向けのWEBアプリケーション開発を約●年経験しております。\n要件定義〜テスト、導入までの上流工程から下流工程まで幅広い経験があります。また、現在はリーダー職を務めております。",
    station: "JRおおさか東線　鴫野",
    favoriteSkill: ['ノリ'],
    image:
        "https://static.rtrp.jp/article/131658/images/131658a327d71f-736a-4fb7-8352-29be1f6da1e9_m.jpg",
    experience: 8,
    lastUpdateDate: new DateTime(2021, 11, 12, 17, 30),
    technicalSkillList: [
      TechnicalSkill(skillId: 'パッション', yearsOfSkill: 432),
      TechnicalSkill(skillId: '人の話を聞かない', yearsOfSkill: 432),
    ],
  ),
  Person(
      id: 1,
      name: "山尾　貴之",
      ruby: "やまお　たかゆき",
      initial: "T.Y",
      sex: 1,
      age: 34,
      contractType: 1,
      description:
          "××年間にわたり、情報システム部において社内ネットワークの構築・運用業務を担当。\n業務用基幹システムの要件定義から導入後の保守運用まで一連の業務を遂行しました。",
      station: "JR奈良　坊城",
      favoriteSkill: ['php', 'Vue', 'java'],
      image:
          "https://static.rtrp.jp/article/131658/images/131658a327d71f-736a-4fb7-8352-29be1f6da1e9_m.jpg",
      experience: 8,
      lastUpdateDate: DateTime.now(),
      technicalSkillList: [
        TechnicalSkill(skillId: 'react', yearsOfSkill: 6),
        TechnicalSkill(skillId: 'vue', yearsOfSkill: 12),
        TechnicalSkill(skillId: 'java', yearsOfSkill: 60),
        TechnicalSkill(skillId: 'php', yearsOfSkill: 120),
      ],
      jobCareerList: [
        JobCareer(
            careerId: 1,
            careerPeriodFrom: DateTime(2019, 11, 01),
            careerPeriodTo: DateTime(2019, 12, 31),
            content: "高速道路に表示する電光掲示の遠隔操作システム",
            phaseInCharge: "フロントエンド",
            role: 1,
            usedTechnicalSkillList: [
              const TechnicalSkill(skillId: 'vue', yearsOfSkill: 2),
            ]),
        JobCareer(
            careerId: 2,
            careerPeriodFrom: DateTime(2020, 01, 01),
            careerPeriodTo: DateTime(2021, 08, 31),
            content: "空調機器設置遠隔操作システム",
            phaseInCharge: "フロントエンド\n要件定義～テスト",
            role: 2,
            usedTechnicalOSList: [
              const TechnicalOS(osId: 'mac', yearsOfOS: 8),
            ],
            usedTechnicalSkillList: [
              const TechnicalSkill(skillId: 'react', yearsOfSkill: 8),
              const TechnicalSkill(skillId: 'type_script', yearsOfSkill: 7),
            ]),
      ]),
  Person(
      id: 1,
      name: "平　凌侑",
      ruby: "たいら　りょうすけ",
      initial: "R.T",
      sex: 1,
      age: 29,
      contractType: 1,
      description:
          "＜身についた知識・スキル＞\n・業務用基幹システム構築業務で身につけたプロジェクト全体をマネジメントするスキル\n・社内関係部署の要望を把握し、協力会社との調整・折衝を\n　経験したことから得た課題を把握する力、解決策を提示し遂行する力\n・システム全般に関する包括的な知識・スキル",
      station: "地下鉄御堂筋線　東三国",
      favoriteSkill: ['vba'],
      image:
          "https://static.rtrp.jp/article/131658/images/131658a327d71f-736a-4fb7-8352-29be1f6da1e9_m.jpg",
      experience: 6,
      lastUpdateDate: new DateTime(2022, 2, 2, 2, 2),
      technicalOSList: [
        const TechnicalOS(osId: 'linux', yearsOfOS: 7),
        const TechnicalOS(osId: 'unix', yearsOfOS: 10),
        const TechnicalOS(osId: 'windows', yearsOfOS: 12),
        const TechnicalOS(osId: 'mac', yearsOfOS: 4),
      ],
      technicalDBList: [
        const TechnicalDB(dbId: 'snowfleak', yearsOfDB: 7),
        const TechnicalDB(dbId: 'oracle', yearsOfDB: 12),
        const TechnicalDB(dbId: 'mysql', yearsOfDB: 9),
      ],
      jobCareerList: [
        JobCareer(
          careerId: 1,
          careerPeriodFrom: DateTime(2020, 06, 01),
          careerPeriodTo: DateTime(2019, 12, 31),
          content: "システム監視",
          phaseInCharge: "インフラ",
          role: 2,
          usedTechnicalOSList: [
            const TechnicalOS(osId: 'linux', yearsOfOS: 7),
            const TechnicalOS(osId: 'unix', yearsOfOS: 3),
          ],
          usedTechnicalDBList: [
            const TechnicalDB(dbId: 'snowfleak', yearsOfDB: 7),
          ],
        ),
        JobCareer(
          careerId: 1,
          careerPeriodFrom: DateTime(2021, 01, 01),
          careerPeriodTo: DateTime(2011, 12, 31),
          content: "システム監視",
          phaseInCharge: "インフラ",
          role: 4,
          usedTechnicalOSList: [
            const TechnicalOS(osId: 'windows', yearsOfOS: 12),
            const TechnicalOS(osId: 'unix', yearsOfOS: 7),
          ],
          usedTechnicalDBList: [
            const TechnicalDB(dbId: 'oracle', yearsOfDB: 12),
            const TechnicalDB(dbId: 'mysql', yearsOfDB: 9),
          ],
        ),
      ]),
  Person(
      id: 1,
      name: "大和　弥生",
      ruby: "やまと　やよい",
      initial: "Y.Y",
      sex: 0,
      age: 31,
      contractType: 1,
      description:
          "××年間にわたり、情報システム部において社内ネットワークの構築・運用業務を担当。\n業務用基幹システムの要件定義から導入後の保守運用まで一連の業務を遂行しました。",
      station: "JR神戸線　姫路",
      favoriteSkill: ['php', 'javascript'],
      image:
          "https://static.rtrp.jp/article/131658/images/131658a327d71f-736a-4fb7-8352-29be1f6da1e9_m.jpg",
      experience: 8,
      lastUpdateDate: new DateTime(2022, 2, 2, 2, 2),
      technicalSkillList: [
        TechnicalSkill(skillId: 'javascript', yearsOfSkill: 60),
        TechnicalSkill(skillId: 'php', yearsOfSkill: 60),
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
              const TechnicalSkill(skillId: 'vue', yearsOfSkill: 2),
            ]),
        JobCareer(
            careerId: 2,
            careerPeriodFrom: DateTime(2020, 01, 01),
            careerPeriodTo: DateTime(2021, 08, 31),
            content: "空調機器設置遠隔操作システム",
            phaseInCharge: "フロントエンド\n要件定義～テスト",
            role: 3,
            usedTechnicalOSList: [
              const TechnicalOS(osId: 'mac', yearsOfOS: 8),
            ],
            usedTechnicalSkillList: [
              const TechnicalSkill(skillId: 'react', yearsOfSkill: 8),
              const TechnicalSkill(skillId: 'type_script', yearsOfSkill: 7),
            ]),
      ]),
];
