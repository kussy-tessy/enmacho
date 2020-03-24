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
goshiki = nuko.bases.create!(name: '5式')
pshiki = nuko.bases.create!(name: 'P式')

# 着ぐるみ
kussy.kigurumis.create!([
    {character: karuta, factory: nuko, base: goshiki, customizer: kussy},
    {character: miku, factory: kigurumiya}
])
shallen.kigurumis.create!([
    {character: tenshi, factory: nuko, base: goshiki, customizer: shallen},
    {character: kaguya, factory: nuko, base: goshiki, customizer: shallen},
    {character: shana, factory: nuko, base: goshiki, customizer: shallen}
])
mutufusa.kigurumis.create!([
    {character: yuika, factory: nuko, base: goshiki, customizer: mutufusa},
    {character: shoko, factory: nuko, base: pshiki, customizer: mutufusa}
])