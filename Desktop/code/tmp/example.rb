# frozen_string_literal: true

# クラスとメソッドの定義
# Playerクラスは、ゲームのユーザー
# このクラスは、カードを引くメソッドを持つ
class Player
  def initialize
    @player = []
  end

  def player_draw(data)
    random_suit = data.keys.sample
    random_card = data[random_suit].sample

    data[random_suit].delete(random_card)

    @player << [random_suit, random_card]

    puts "あなたの引いたカードは#{random_suit}の#{random_card}です。"
  end

  attr_reader :player
end

# Dealerクラスは、コンピュータが自動実行
# このクラスも、カードを引く機能を持つ
class Dealer
  def initialize
    @dealer = []
  end

  def dealer_draw(data)
    random_suit = data.keys.sample
    random_card = data[random_suit].sample

    data[random_suit].delete(random_card)

    @dealer << [random_suit, random_card]
  end

  attr_reader :dealer
end

# ブラックジャックゲームが、開始される
you = Player.new
me = Dealer.new

puts 'ブラックジャックゲームを開始します。'

deck = {
  'クラブ' => ['A', 2, 3, 4, 5, 6, 7, 8, 9, 10, 'J', 'Q', 'K'],
  'ダイヤ' => ['A', 2, 3, 4, 5, 6, 7, 8, 9, 10, 'J', 'Q', 'K'],
  'ハート' => ['A', 2, 3, 4, 5, 6, 7, 8, 9, 10, 'J', 'Q', 'K'],
  'スペード' => ['A', 2, 3, 4, 5, 6, 7, 8, 9, 10, 'J', 'Q', 'K']
}

# 2枚ずつ配られる
2.times do
  you.player_draw(deck)
end

2.times do
  me.dealer_draw(deck)
end

# プレーヤーデッキ内のカードを合計する
p_v = you.player.map { |sub_array| sub_array[1] }
ptotal = 0
p_v.each do |element|
  if element.is_a?(Numeric) || (element.is_a?(String) && element.to_i.to_s == element)
    ptotal += element
  else
    if element == 'A'
      ptotal += 11
    elsif %w[J Q K].include?(element)
      ptotal += 10
    end
  end
end


# ディーラーデッキ内のカードを合計する
d_v = me.dealer.map { |sub_array| sub_array[1] }

dtotal = 0
d_v.each do |element|
  if element.is_a?(Numeric) || (element.is_a?(String) && element.to_i.to_s == element)
    dtotal += element
  else
    if element == 'A'
      dtotal += 11
    elsif %w[J Q K].include?(element)
      dtotal += 10
    end
  end
end

# もし合計が、21を超えていたら、Aを1にする
c = 0
count = 0
while dtotal > 21
  d_v.each do |element|
    if element == 'A'
      dtotal -= 10
    end
    count += 1
    c += 1
  end
  if dtotal <= 21
    break
  end
  if c >= d_v.length
    break # 配列の最後までループが実行されたら while ループを抜ける
  end
end

puts "ディーラーの引いたカードは#{me.dealer[0][0]}の#{me.dealer[0][1]}です。"

puts 'ディーラーの引いた2枚目のカードはわかりません。'

# プレーヤーのターン
# もし合計が、21を超えていたら、Aを1にする
c = 0
count = 0
while ptotal > 21
  p_v.each do |element|
    if element == 'A'
      ptotal -= 10
    end
    count += 1
    c += 1
  end
  if ptotal <= 21
    break
  end
  if c >= p_v.length
    break # 配列の最後までループが実行されたら while ループを抜ける
  end
end

puts "あなたの現在の得点は#{ptotal}です。カードを引きますか？（Y/N）"
hantei = gets.chomp

# もし、Yなら
counts = 1
while hantei == 'Y'
  you.player_draw(deck)
  p_v = you.player.map { |sub_array| sub_array[1] }
  ptotal = 0
  p_v.each do |element|
    if element.is_a?(Numeric) || (element.is_a?(String) && element.to_i.to_s == element)
      ptotal += element
    else
      if element == 'A'
        ptotal += 11
      elsif %w[J Q K].include?(element)
        ptotal += 10
      end
    end
  end

  # もし合計が、21を超えていたら、Aを1にする
  c = 0
  count = 0
  while ptotal > 21
    p_v.each do |element|
      if element == 'A'
        ptotal -= 10
      end
      count += 1
      c += 1
    end
    if ptotal <= 21
      break
    end
    if c >= p_v.length
      break # 配列の最後までループが実行されたら while ループを抜ける
    end
  end

  # もし、プレーヤーの合計点数が21点を超えたら、
  if ptotal > 21
    puts "あなたの得点は#{ptotal}です"
    puts "ディーラーの得点は#{dtotal}です"
    puts 'あなたの負けです！'
    puts 'ブラックジャックを終了します。'
    exit
  end
  puts "あなたの現在の得点は#{ptotal}です。カードを引きますか？（Y/N）"
  hantei = gets.chomp
end


# もし、Nなら
DCOUNTS = 2
# ディーラーのターン
if hantei == 'N'
  puts "ディーラーの引いた2枚目のカードは#{me.dealer[1][0]}の#{me.dealer[1][1]}でした."
  puts "ディーラーの現在の得点は#{dtotal}です."
  while dsum < 17
    me.dealer_draw(deck)
    puts "ディーラーの引いたカードは#{me.dealer[DCOUNTS][0]}の#{me.dealer[DCOUNTS][1]}でした."
    DCOUNTS += 1
    d_v = me.dealer.map { |sub_array| sub_array[1] }
    dtotal = 0
    d_v.each do |element|
      if element.is_a?(Numeric) || (element.is_a?(String) && element.to_i.to_s == element)
        dtotal += element
      else
        if element == 'A'
          dtotal += 11
        elsif %w[J Q K].include?(element)
          dtotal += 10
        end
      end
    end
    c = 0
    count = 0
    while dtotal > 21
      d_v.each do |element|
        if element == 'A'
          dtotal -= 10
        end
        count += 1
        c += 1
      end
      if dtotal <= 21
        break
      end
      if c >= d_v.length
        break # 配列の最後までループが実行されたら while ループを抜ける
      end
    end

    if dtotal > 21
      puts "あなたの得点は#{ptotal}です."
      puts "ディーラーの得点は#{dtotal}です."
      puts 'あなたの勝ちです!'
      puts 'ブラックジャックを終了します.'
      exit
    end
  end
end


# もし、ディーラーのターンが終わったら、勝負
puts '勝負します！'
if ptotal > dtotal
  puts 'あなたの勝ちです！'
elsif ptotal < dtotal
  puts 'あなたの負けです！'
else
  puts '引き分けです。'
end
