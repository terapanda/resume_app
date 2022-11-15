import 'package:resume_app/model/person.dart';
import 'package:resume_app/model/technical_skill.dart';

List<Person> exampleList = [
  const Person(
    id: "1",
    name: "渡部　悠貴",
    ruby: "わたなべ　ゆうき",
    initial: "Y.W",
    sex: "1",
    age: "29",
    station: "地下鉄御堂筋線　江坂",
    excelsAt: ['React', 'Vue', 'java'],
    image:
        "https://static.rtrp.jp/article/131658/images/131658a327d71f-736a-4fb7-8352-29be1f6da1e9_m.jpg",
    experience: 8,
    technicalSkill: [
      TechnicalSkill(skillId: 'react', skillName: 'React', skillExperience: 38),
      TechnicalSkill(skillId: 'vue', skillName: 'Vue', skillExperience: 38),
      TechnicalSkill(skillId: 'java', skillName: 'java', skillExperience: 65),
      TechnicalSkill(skillId: 'php', skillName: 'php', skillExperience: 12),
      TechnicalSkill(
          skillId: 'flutter', skillName: 'flutter', skillExperience: 12),
      TechnicalSkill(skillId: 'vba', skillName: 'VBA', skillExperience: 12)
    ],
  ),
  const Person(
    id: "2",
    name: "谷内　伸輔",
    ruby: "たにうち　しんすけ",
    initial: "S.T",
    sex: "1",
    age: "34",
    station: "JRおおさか東線　高井田中央",
    excelsAt: ['COBOL', 'Vue', 'Python'],
    image:
        "https://static.rtrp.jp/article/131658/images/131658a327d71f-736a-4fb7-8352-29be1f6da1e9_m.jpg",
    experience: 8,
    technicalSkill: [
      TechnicalSkill(skillId: 'react', skillName: 'React', skillExperience: 24),
      TechnicalSkill(skillId: 'vue', skillName: 'Vue', skillExperience: 24),
      TechnicalSkill(skillId: 'java', skillName: 'java', skillExperience: 24),
      TechnicalSkill(skillId: 'php', skillName: 'php', skillExperience: 12),
      TechnicalSkill(
          skillId: 'flutter', skillName: 'flutter', skillExperience: 24),
      TechnicalSkill(skillId: 'vba', skillName: 'VBA', skillExperience: 36),
      TechnicalSkill(
          skillId: 'python', skillName: 'Python', skillExperience: 36)
    ],
  ),
  const Person(
    id: "3",
    name: "シュヴァシイシュ ポル シャゴルシュヴァシイシュ ポル シャゴル",
    initial: "S.S",
    sex: "1",
    age: "35",
    station: "JRおおさか東線　鴫野",
    excelsAt: [
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
    technicalSkill: [
      TechnicalSkill(skillId: 'java', skillName: 'java', skillExperience: 24),
    ],
  ),
  const Person(
    id: "4",
    name: "山尾　貴之",
    ruby: "やまお　たかゆき",
    initial: "T.Y",
    sex: "1",
    age: "34",
    station: "JR奈良　坊城",
    excelsAt: ['php', 'Vue', 'java'],
    image:
        "https://static.rtrp.jp/article/131658/images/131658a327d71f-736a-4fb7-8352-29be1f6da1e9_m.jpg",
    experience: 8,
    technicalSkill: [
      TechnicalSkill(skillId: 'react', skillName: 'React', skillExperience: 6),
      TechnicalSkill(skillId: 'vue', skillName: 'Vue', skillExperience: 12),
      TechnicalSkill(skillId: 'java', skillName: 'java', skillExperience: 60),
      TechnicalSkill(skillId: 'php', skillName: 'php', skillExperience: 120),
    ],
  ),
  const Person(
    id: "5",
    name: "平　凌侑",
    initial: "R.T",
    sex: "1",
    age: "29",
    station: "地下鉄御堂筋線　東三国",
    excelsAt: ['vba'],
    image:
        "https://static.rtrp.jp/article/131658/images/131658a327d71f-736a-4fb7-8352-29be1f6da1e9_m.jpg",
    experience: 6,
    technicalSkill: [
      TechnicalSkill(
          skillId: 'javascript', skillName: 'javascript', skillExperience: 6),
      TechnicalSkill(skillId: 'aws', skillName: 'aws', skillExperience: 12),
    ],
  ),
  const Person(
    id: "6",
    name: "渡部　悠貴",
    ruby: "わたなべ　ゆうき",
    initial: "Y.W",
    sex: "1",
    age: "29",
    station: "地下鉄御堂筋線　江坂",
    excelsAt: ['React', 'Vue', 'java'],
    image:
        "https://static.rtrp.jp/article/131658/images/131658a327d71f-736a-4fb7-8352-29be1f6da1e9_m.jpg",
    experience: 8,
    technicalSkill: [
      TechnicalSkill(skillId: 'react', skillName: 'React', skillExperience: 36),
      TechnicalSkill(skillId: 'vue', skillName: 'Vue', skillExperience: 36),
      TechnicalSkill(skillId: 'java', skillName: 'java', skillExperience: 60),
      TechnicalSkill(skillId: 'php', skillName: 'php', skillExperience: 12),
      TechnicalSkill(
          skillId: 'flutter', skillName: 'flutter', skillExperience: 12),
      TechnicalSkill(skillId: 'vba', skillName: 'VBA', skillExperience: 12)
    ],
  ),
  const Person(
    id: "7",
    name: "谷内　伸輔",
    ruby: "たにうち　しんすけ",
    initial: "S.T",
    sex: "1",
    age: "34",
    station: "JRおおさか東線　高井田中央",
    excelsAt: ['COBOL', 'Vue', 'Python'],
    image:
        "https://static.rtrp.jp/article/131658/images/131658a327d71f-736a-4fb7-8352-29be1f6da1e9_m.jpg",
    experience: 8,
    technicalSkill: [
      TechnicalSkill(skillId: 'react', skillName: 'React', skillExperience: 24),
      TechnicalSkill(skillId: 'vue', skillName: 'Vue', skillExperience: 24),
      TechnicalSkill(skillId: 'java', skillName: 'java', skillExperience: 24),
      TechnicalSkill(skillId: 'php', skillName: 'php', skillExperience: 12),
      TechnicalSkill(
          skillId: 'flutter', skillName: 'flutter', skillExperience: 24),
      TechnicalSkill(skillId: 'vba', skillName: 'VBA', skillExperience: 36),
      TechnicalSkill(
          skillId: 'python', skillName: 'Python', skillExperience: 36)
    ],
  ),
  const Person(
    id: "8",
    name: "保木本　大貴",
    ruby: "ほきもと　ひろき",
    initial: "H.H",
    sex: "1",
    age: "35",
    station: "JRおおさか東線　鴫野",
    excelsAt: ['パッション'],
    image:
        "https://static.rtrp.jp/article/131658/images/131658a327d71f-736a-4fb7-8352-29be1f6da1e9_m.jpg",
    experience: 8,
    technicalSkill: [
      TechnicalSkill(skillId: 'パッション', skillName: 'パッション', skillExperience: 14),
      TechnicalSkill(
          skillId: '人の話を聞かない', skillName: '人の話を聞かない', skillExperience: 432),
    ],
  ),
  const Person(
    id: "9",
    name: "山尾　貴之",
    ruby: "やまお　たかゆき",
    initial: "T.Y",
    sex: "1",
    age: "34",
    station: "JR奈良　坊城",
    excelsAt: ['php', 'Vue', 'java'],
    image:
        "https://static.rtrp.jp/article/131658/images/131658a327d71f-736a-4fb7-8352-29be1f6da1e9_m.jpg",
    experience: 8,
    technicalSkill: [
      TechnicalSkill(skillId: 'react', skillName: 'React', skillExperience: 6),
      TechnicalSkill(skillId: 'vue', skillName: 'Vue', skillExperience: 12),
      TechnicalSkill(skillId: 'java', skillName: 'java', skillExperience: 60),
      TechnicalSkill(skillId: 'php', skillName: 'php', skillExperience: 120),
    ],
  ),
  const Person(
    id: "10",
    name: "平　凌侑",
    initial: "R.T",
    sex: "1",
    age: "29",
    station: "地下鉄御堂筋線　東三国",
    excelsAt: ['vba'],
    image:
        "https://static.rtrp.jp/article/131658/images/131658a327d71f-736a-4fb7-8352-29be1f6da1e9_m.jpg",
    experience: 6,
    technicalSkill: [
      TechnicalSkill(
          skillId: 'javascript', skillName: 'javascript', skillExperience: 6),
      TechnicalSkill(skillId: 'aws', skillName: 'aws', skillExperience: 12),
    ],
  ),
  const Person(
    id: "11",
    name: "渡部　悠貴",
    ruby: "わたなべ　ゆうき",
    initial: "Y.W",
    sex: "1",
    age: "29",
    station: "地下鉄御堂筋線　江坂",
    excelsAt: ['React', 'Vue', 'java'],
    image:
        "https://static.rtrp.jp/article/131658/images/131658a327d71f-736a-4fb7-8352-29be1f6da1e9_m.jpg",
    experience: 8,
    technicalSkill: [
      TechnicalSkill(skillId: 'react', skillName: 'React', skillExperience: 36),
      TechnicalSkill(skillId: 'vue', skillName: 'Vue', skillExperience: 36),
      TechnicalSkill(skillId: 'java', skillName: 'java', skillExperience: 60),
      TechnicalSkill(skillId: 'php', skillName: 'php', skillExperience: 12),
      TechnicalSkill(
          skillId: 'flutter', skillName: 'flutter', skillExperience: 12),
      TechnicalSkill(skillId: 'vba', skillName: 'VBA', skillExperience: 12)
    ],
  ),
  const Person(
    id: "12",
    name: "谷内　伸輔",
    ruby: "たにうち　しんすけ",
    initial: "S.T",
    sex: "1",
    age: "34",
    station: "JRおおさか東線　高井田中央",
    excelsAt: ['COBOL', 'Vue', 'Python'],
    image:
        "https://static.rtrp.jp/article/131658/images/131658a327d71f-736a-4fb7-8352-29be1f6da1e9_m.jpg",
    experience: 8,
    technicalSkill: [
      TechnicalSkill(skillId: 'react', skillName: 'React', skillExperience: 4),
      TechnicalSkill(skillId: 'vue', skillName: 'Vue', skillExperience: 24),
      TechnicalSkill(skillId: 'java', skillName: 'java', skillExperience: 24),
      TechnicalSkill(skillId: 'php', skillName: 'php', skillExperience: 12),
      TechnicalSkill(
          skillId: 'flutter', skillName: 'flutter', skillExperience: 24),
      TechnicalSkill(skillId: 'vba', skillName: 'VBA', skillExperience: 36),
      TechnicalSkill(
          skillId: 'python', skillName: 'Python', skillExperience: 36)
    ],
  ),
  const Person(
    id: "13",
    name: "保木本　大貴",
    ruby: "ほきもと　ひろき",
    initial: "H.H",
    sex: "1",
    age: "35",
    station: "JRおおさか東線　鴫野",
    excelsAt: ['ノリ'],
    image:
        "https://static.rtrp.jp/article/131658/images/131658a327d71f-736a-4fb7-8352-29be1f6da1e9_m.jpg",
    experience: 8,
    technicalSkill: [
      TechnicalSkill(
          skillId: 'パッション', skillName: 'パッション', skillExperience: 432),
      TechnicalSkill(
          skillId: '人の話を聞かない', skillName: '人の話を聞かない', skillExperience: 432),
    ],
  ),
  const Person(
    id: "14",
    name: "山尾　貴之",
    ruby: "やまお　たかゆき",
    initial: "T.Y",
    sex: "1",
    age: "34",
    station: "JR奈良　坊城",
    excelsAt: ['php', 'Vue', 'java'],
    image:
        "https://static.rtrp.jp/article/131658/images/131658a327d71f-736a-4fb7-8352-29be1f6da1e9_m.jpg",
    experience: 8,
    technicalSkill: [
      TechnicalSkill(skillId: 'react', skillName: 'React', skillExperience: 6),
      TechnicalSkill(skillId: 'vue', skillName: 'Vue', skillExperience: 12),
      TechnicalSkill(skillId: 'java', skillName: 'java', skillExperience: 60),
      TechnicalSkill(skillId: 'php', skillName: 'php', skillExperience: 120),
    ],
  ),
  const Person(
    id: "15",
    name: "平　凌侑",
    initial: "R.T",
    sex: "1",
    age: "29",
    station: "地下鉄御堂筋線　東三国",
    excelsAt: ['vba'],
    image:
        "https://static.rtrp.jp/article/131658/images/131658a327d71f-736a-4fb7-8352-29be1f6da1e9_m.jpg",
    experience: 6,
    technicalSkill: [
      TechnicalSkill(
          skillId: 'javascript', skillName: 'javascript', skillExperience: 6),
      TechnicalSkill(skillId: 'aws', skillName: 'aws', skillExperience: 12),
    ],
  ),
  const Person(
    id: "16",
    name: "大和　弥生",
    initial: "Y.Y",
    sex: "0",
    age: "31",
    station: "JR神戸線　姫路",
    excelsAt: ['php', 'javascript'],
    image:
        "https://static.rtrp.jp/article/131658/images/131658a327d71f-736a-4fb7-8352-29be1f6da1e9_m.jpg",
    experience: 8,
    technicalSkill: [
      TechnicalSkill(
          skillId: 'javascript', skillName: 'javascript', skillExperience: 60),
      TechnicalSkill(skillId: 'php', skillName: 'php', skillExperience: 60),
    ],
  ),
];
