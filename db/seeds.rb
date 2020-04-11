# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# 人関係
osaka = Prefecture.create!(name: '大阪府')
saitama = Prefecture.create!(name: '埼玉県')
shallen = Person.create!(name: 'しゃれんきゅん', prefecture: osaka, home_prefecture: saitama, twitter: 'shallen_p2')
kussy = Person.create!(name: 'くっしー', prefecture: osaka, home_prefecture: osaka, twitter: 'kussy_tessy')
mutufusa = Person.create!(name: 'むつふさ', prefecture: osaka, home_prefecture: osaka, twitter: 'mutsufusa')

# キャラクター関係
touhou = Work.create!(name: '東方Project', yomigana: 'とうほうぷろじぇくと')
shana_w  = Work.create!(name: '灼眼のシャナ', yomigana: 'しゃくがんのしゃな')
vocaloid = Work.create!(name: 'VOCALOID', yomigana: 'ぼーかろいど')
inuboku = Work.create!(name: '妖狐×僕SS', yomigana: 'いぬぼくしーくれっとさーびす')
jorm = Work.create!(name: 'ヨルムンガンド', yomigana: 'よるむんがんど')
orig = Work.create!(name: 'オリジナル', yomigana: 'おりじなる')

tenshi = touhou.characters.create!(name: '比那名居天子', yomigana: 'ひなないてんし')
kaguya = touhou.characters.create!(name: '蓬莱山輝夜', yomigana: 'ほうらいさんかぐや')
shana = shana_w.characters.create!(name: 'シャナ', yomigana: 'しゃな')
miku = vocaloid.characters.create!(name: '初音ミク', yomigana: 'はつねみく')
karuta = inuboku.characters.create!(name: '髏々宮カルタ', yomigana: 'ろろみやかるた')
shoko = jorm.characters.create!(name: 'ショコラーデ', yomigana: 'しょこらーで')
yuika = orig.characters.create!(name: '唯香', yomigana: 'ゆいか')

# 工房・素体
nuko = Factory.create!(name: 'ぬこパン')
kigurumiya = Factory.create!(name: 'キグルミ屋(阿見工房、岡山)')

# 着ぐるみ
kussy.kigurumis.create!([
    {character: karuta, factory: nuko, customizer: kussy},
    {character: miku, factory: kigurumiya}
])
shallen.kigurumis.create!([
    {character: tenshi, factory: nuko, customizer: shallen},
    {character: kaguya, factory: nuko, customizer: shallen},
    {character: shana, factory: nuko, customizer: shallen}
])
mutufusa.kigurumis.create!([
    {character: yuika, factory: nuko, customizer: mutufusa},
    {character: shoko, factory: nuko, customizer: mutufusa}
])

## ↑ここまではテストデータなので、環境構築やテストが済んだらデータは削除すること↑ ##

# 都道府県初期データ
[
    '北海道',
    '青森',
    '岩手',
    '宮城',
    '秋田',
    '山形',
    '福島',
    '茨城',
    '栃木',
    '群馬',
    '埼玉',
    '千葉',
    '東京',
    '神奈川',
    '新潟',
    '富山',
    '石川',
    '福井',
    '山梨',
    '長野',
    '岐阜',
    '静岡',
    '愛知',
    '三重',
    '滋賀',
    '京都',
    '大阪',
    '兵庫',
    '奈良',
    '和歌山',
    '鳥取',
    '島根',
    '岡山',
    '広島',
    '山口',
    '徳島',
    '香川',
    '愛媛',
    '高知',
    '福岡',
    '佐賀',
    '長崎',
    '熊本',
    '大分',
    '宮崎',
    '鹿児島',
    '沖縄',
    '中国',
    '韓国',
    '台湾',
    '香港',
    'その他海外アジア',
    'アメリカ',
    'その他海外'
].each do |p|
  Prefecture.create!(name: p)
end

# 工房関係初期データ
[
    '造形工房SIGMA',
    'イルカ工房',
    'ぬこ☆パン',
    'RINS FACTORY',
    'ズコカン',
    'もなか工房',
    'キグルミ屋(岡山)',
    '豪華王',
    'あやめ商店',
    'むにむに製作所',
    'Teitoku',
    '雷撃工房',
    'その他工房',
    '自作',
].each do |f|
  Factory.create!(name: f)
end