class RandomController < ApplicationController
  def show
    @kigurumi = Kigurumi.offset(rand(Kigurumi.count)).first
    render 'show'
  end

  def edit
    retry_ = 0
    while retry_ <= 30
      @num = (1..12).to_a.sample
      retry_ += 1
      case @num
        when 1
          @msg = "以下の着ぐるみさんのキャラクターの名前は分かりますか？"
          @kigurumi = Kigurumi.joins(:kigurumi_images).where.not('kigurumi_images.id': nil).where(character: nil).sample
          break if @kigurumi.present?
        when 2
          @msg = '以下の着ぐるみさんの画像はありますか？'
          @kigurumi = Kigurumi.left_joins(:kigurumi_images).where('kigurumi_images.id': nil).where.not(character: nil).sample
          break if @kigurumi.present?
        when 3
          @msg = '以下の着ぐるみさんの髪の色、髪の長さ、口開きか口閉じかは分かりますか？'
          @kigurumi = Kigurumi.where('hair_color IS NULL OR hair_length IS NULL OR mouth_open IS NULL').left_joins(:kigurumi_images).where.not('kigurumi_images.id': nil).sample
          break if @kigurumi.present?
        when 4
          @msg = '以下の着ぐるみさんの工房は分かりますか？'
          @kigurumi = Kigurumi.where(factory: nil).sample
          break if @kigurumi.present?
        when 5, 6, 7, 8
          @msg = '以下の人は他に着ぐるみを持っていますか？'
          @person = Person.all.sample
          @add = true
          break if @person.present?
        when 9
          @msg = '以下の人の年齢（誕生日）は分かりますか？'
          @person = Person.where(birth_year: nil).or(Person.where(birth_is_reliable: false)).sample
          break if @person.present?
        when 10
          @msg = '以下の人の居住都道府県は分かりますか？'
          @person = Person.where(prefecture: nil).sample
          break if @person.present?
        when 11
          @msg = '以下の作品の読み方は分かりますか？　ひらがなのみで入力してください。'
          @work = Work.where(yomigana: nil).sample
          break if @work.present?
        when 12
          @msg = '以下のキャラクターの読み方は分かりますか？　ひらがなのみで入力してください。'
          @character = Character.where(yomigana: nil).sample
          break if @character.present?
      end
    end
    render 'edit'
  end
end
