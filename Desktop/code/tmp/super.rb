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

  # プレーヤーデッキの合計を計算する関数
  def card_sum
    sum = @player.map { |sub_array| sub_array[1] }
    total = 0
    sum.each do |element|
      if element.is_a?(Numeric) || (element.is_a?(String) && element.to_i.to_s == element)
        total += element.to_i
      else
        if element == 'A'
          total += 11
        elsif %w[J Q K].include?(element)
          total += 10
        end
      end
    end
    c = 0
    count = 0
    while total > 21
      sum.each do |element|
        if element == 'A'
          total -= 10
        end
        count += 1
        c += 1
      end
      if total <= 21
        break
      end
      if c >= sum.length
        break # 配列の最後までループが実行されたら while ループを抜ける
      end
    end
    return total
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

  # ディーラーデッキの合計を計算する関数
  def card_sum
    sum = @dealer.map { |sub_array| sub_array[1] }
    total = 0
    sum.each do |element|
      if element.is_a?(Numeric) || (element.is_a?(String) && element.to_i.to_s == element)
        total += element
      else
        if element == 'A'
          total += 11
        elsif %w[J Q K].include?(element)
          total += 10
        end
      end
    end
    c = 0
    count = 0
    while total > 21
      sum.each do |element|
        if element == 'A'
          total -= 10
        end
        count += 1
        c += 1
      end
      if total <= 21
        break
      end
      if c >= sum.length
        break # 配列の最後までループが実行されたら while ループを抜ける
      end
    end
    return total
  end

  attr_reader :dealer
end

# ブラックジャックゲームが、開始される
p1 = Player.new
p2 = Player.new
p3 = Player.new
p4 = Player.new
d = Dealer.new

puts 'ブラックジャックゲームを開始します。'

deck = {
  'クラブ' => ['A', 2, 3, 4, 5, 6, 7, 8, 9, 10, 'J', 'Q', 'K'],
  'ダイヤ' => ['A', 2, 3, 4, 5, 6, 7, 8, 9, 10, 'J', 'Q', 'K'],
  'ハート' => ['A', 2, 3, 4, 5, 6, 7, 8, 9, 10, 'J', 'Q', 'K'],
  'スペード' => ['A', 2, 3, 4, 5, 6, 7, 8, 9, 10, 'J', 'Q', 'K']
}

# 2枚ずつ配られる
2.times do
  p1.player_draw(deck)
end

2.times do
  p2.player_draw(deck)
end

2.times do
  p3.player_draw(deck)
end

2.times do
  p4.player_draw(deck)
end

2.times do
  d.dealer_draw(deck)
end

puts "ディーラーの引いたカードは#{d.dealer[0][0]}の#{d.dealer[0][1]}です。"

puts 'ディーラーの引いた2枚目のカードはわかりません。'

# プレーヤー1のターン
p1_total = p1.card_sum
puts "プレーヤー１の現在の得点は#{p1_total}です。カードを引きますか？（Y/N）"
p1_hantei = gets.chomp
while p1_hantei == 'Y'
  p1.player_draw(deck)
  total = p1.card_sum
  # もし、プレーヤーの合計点数が21点を超えたら、
  if total > 21
    puts "あなたの得点は#{total}です"
    puts 'あなたの負けです！'
    break
  else
    puts "プレーヤー１の現在の得点は#{total}です。カードを引きますか？（Y/N）"
    p1_hantei = gets.chomp
  end
end

# プレーヤー2のターン
p2_total = p2.card_sum
puts "プレーヤー２の現在の得点は#{p2_total}です。カードを引きますか？（Y/N）"
p2_hantei = gets.chomp
while p2_hantei == 'Y'
  p2.player_draw(deck)
  total = p2.card_sum
  # もし、プレーヤーの合計点数が21点を超えたら、
  if total > 21
    puts "あなたの得点は#{total}です"
    puts 'あなたの負けです！'
    break
  else
    puts "プレーヤー２の現在の得点は#{total}です。カードを引きますか？（Y/N）"
    p2_hantei = gets.chomp
  end
end

# プレーヤー3のターン
p3_total = p3.card_sum
puts "プレーヤー３の現在の得点は#{p3_total}です。カードを引きますか？（Y/N）"
p3_hantei = gets.chomp
while p3_hantei == 'Y'
  p3.player_draw(deck)
  total = p3.card_sum
  # もし、プレーヤーの合計点数が21点を超えたら、
  if total > 21
    puts "あなたの得点は#{total}です"
    puts 'あなたの負けです！'
    break
  else
    puts "プレーヤー３の現在の得点は#{total}です。カードを引きますか？（Y/N）"
    p3_hantei = gets.chomp
  end
end

# プレーヤー4のターン
p4_total = p4.card_sum
puts "プレーヤー４の現在の得点は#{p4_total}です。カードを引きますか？（Y/N）"
p4_hantei = gets.chomp
while p4_hantei == 'Y'
  p4.player_draw(deck)
  total = p4.card_sum
  # もし、プレーヤーの合計点数が21点を超えたら、
  if total > 21
    puts "あなたの得点は#{total}です"
    puts 'あなたの負けです！'
    break
  else
    puts "プレーヤー４の現在の得点は#{total}です。カードを引きますか？（Y/N）"
    p4_hantei = gets.chomp
  end
end

# ディーラーのターン
puts "ディーラーの引いた2枚目のカードは#{d.dealer[1][0]}の#{d.dealer[1][1]}でした."
d_total = d.card_sum
puts "ディーラーの現在の得点は#{d_total}です."

dcounts = 2
while d_total < 17
  d.dealer_draw(deck)
  puts "ディーラーの引いたカードは#{d.dealer[dcounts][0]}の#{d.dealer[dcounts][1]}でした."
  dcounts += 1
  d_total = d.card_sum

  if d_total > 21
    puts "ディーラーの得点は#{d_total}です."
    puts 'ディーラーの負けです!'
    puts 'ブラックジャックを終了します.'
    exit
  end
end

# もし、ディーラーのターンが終わったら、勝負
p1_result = p1.card_sum
p2_result = p2.card_sum
p3_result = p3.card_sum
p4_result = p4.card_sum
d_result = d.card_sum

puts "ディーラーの得点は#{d_result}です."

if p1_result > 21
  puts 'プレーヤー１は脱落しています。'
  p1_result = nil
end
if p2_result > 21
  puts 'プレーヤー２は脱落しています。'
  p2_result = nil
end
if p3_result > 21
  puts 'プレーヤー３は脱落しています。'
  p3_result = nil
end
if p4_result > 21
  puts 'プレーヤー４は脱落しています。'
  p4_result = nil
end
if d_result > 21
  puts 'ディーラーは脱落しています。'
  d_result = nil
end

non_nil_values = {}
non_nil_values[:p1_result] = p1_result if p1_result
non_nil_values[:p2_result] = p2_result if p2_result
non_nil_values[:p3_result] = p3_result if p3_result
non_nil_values[:p4_result] = p4_result if p4_result
non_nil_values[:d_result] = d_result if d_result

max_variable = non_nil_values.key(non_nil_values.values.max)
max_value = non_nil_values.values.max

case max_variable
when p1_result
  'プレーヤー１の勝ちです！'
when p2_result
  'プレーヤー２の勝ちです！'
when p3_result
  'プレーヤー３の勝ちです！'
when p4_result
  'プレーヤー４の勝ちです！'
when d_result
  'ディーラーの勝ちです！'
else
  puts '引き分けです。'
end
