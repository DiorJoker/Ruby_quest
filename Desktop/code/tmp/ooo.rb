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

# ２枚カードをデッキからひく関数
def draw2(who, data, whois)
  count = 0
  2.times do
    who.player_draw(data)
    random_suit = who.player[count][0]
    random_card = who.player[count][1]
    puts "#{whois}の引いたカードは#{random_suit}の#{random_card}です。"
    count += 1
  end
end

# プレーヤーデッキの合計を計算する関数
def card_sum(who)
  total = 0
  a_count = 0

  who.player.each do |sub_array|
    element = sub_array[1]

    if element.is_a?(Numeric)
      total += element
    elsif element.to_i.to_s == element
      total += element.to_i
    else
      if element == 'A'
        total += 11
        a_count += 1
      elsif %w[J Q K].include?(element)
        total += 10
      end
    end
  end

  while total > 21 && a_count > 0
    total -= 10
    a_count -= 1
  end

  total  # カード合計を返す
end



# ディーラーデッキの合計を計算する関数
def card_sum_d(who)
  sum = who.dealer.map { |sub_array| sub_array[1] }
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

def playset(who,data,whois,count)
  who.player_draw(data)
  random_suit = who.player[count][0]
  random_card = who.player[count][1]
  puts "#{whois}の引いたカードは#{random_suit}の#{random_card}です。"
  total = card_sum(who)
  return total
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
draw2(p1,deck,'プレーヤー１')
draw2(p2,deck,'プレーヤー２')
draw2(p3,deck,'プレーヤー３')
draw2(p4,deck,'プレーヤー４')
2.times do
  d.dealer_draw(deck)
end

puts "ディーラーの引いたカードは#{d.dealer[0][0]}の#{d.dealer[0][1]}です。"

puts 'ディーラーの引いた2枚目のカードはわかりません。'

# プレーヤー1のターン
p1_total = card_sum(p1)
puts "プレーヤー１の現在の得点は#{p1_total}です。カードを引きますか？（Y/N）"
p1_hantei = gets.chomp
ccc1 = 0
while p1_hantei == 'Y'
  total = playset(p1,deck,'プレーヤー１',ccc1)
  # もし、プレーヤーの合計点数が21点を超えたら、
  if total > 21
    puts "あなたの得点は#{total}です"
    puts 'あなたの負けです！'
    break
  else
    puts "プレーヤー１の現在の得点は#{total}です。カードを引きますか？（Y/N）"
    p1_hantei = gets.chomp
  end
  ccc1 += 1
end

# プレーヤー2のターン
p2_total = card_sum(p2)
puts "プレーヤー２の現在の得点は#{p2_total}です。カードを引きますか？（Y/N）"
p2_hantei = gets.chomp
ccc2 = 0
while p2_hantei == 'Y'
  total = playset(p2,deck,'プレーヤー２',ccc2)
  # もし、プレーヤーの合計点数が21点を超えたら、
  if total > 21
    puts "あなたの得点は#{total}です"
    puts 'あなたの負けです！'
    break
  else
    puts "プレーヤー２の現在の得点は#{total}です。カードを引きますか？（Y/N）"
    p2_hantei = gets.chomp
  end
  ccc2 += 1
end

# プレーヤー3のターン
p3_total = card_sum(p3)
puts "プレーヤー３の現在の得点は#{p3_total}です。カードを引きますか？（Y/N）"
p3_hantei = gets.chomp
ccc3 = 0
while p3_hantei == 'Y'
  total = playset(p3,deck,'プレーヤー３',ccc3)
  # もし、プレーヤーの合計点数が21点を超えたら、
  if total > 21
    puts "あなたの得点は#{total}です"
    puts 'あなたの負けです！'
    break
  else
    puts "プレーヤー３の現在の得点は#{total}です。カードを引きますか？（Y/N）"
    p3_hantei = gets.chomp
  end
  ccc3 += 1
end

# プレーヤー4のターン
p4_total = card_sum(p4)
puts "プレーヤー４の現在の得点は#{p4_total}です。カードを引きますか？（Y/N）"
p4_hantei = gets.chomp
ccc4 = 0
while p4_hantei == 'Y'
  total = playset(p4,deck,'プレーヤー４',ccc4)
  # もし、プレーヤーの合計点数が21点を超えたら、
  if total > 21
    puts "あなたの得点は#{total}です"
    puts 'あなたの負けです！'
    break
  else
    puts "プレーヤー４の現在の得点は#{total}です。カードを引きますか？（Y/N）"
    p4_hantei = gets.chomp
  end
  ccc4 += 1
end

# ディーラーのターン
puts "ディーラーの引いた2枚目のカードは#{d.dealer[1][0]}の#{d.dealer[1][1]}でした."
d_total = card_sum_d(d)
puts "ディーラーの現在の得点は#{d_total}です."

dcounts = 2
while d_total < 17
  d.dealer_draw(deck)
  puts "ディーラーの引いたカードは#{d.dealer[dcounts][0]}の#{d.dealer[dcounts][1]}でした."
  dcounts += 1
  d_total = card_sum_d(d)

  if d_total > 21
    puts "ディーラーの得点は#{d_total}です."
    puts 'ディーラーの負けです!'
    puts 'ブラックジャックを終了します.'
    exit
  end
end

# もし、ディーラーのターンが終わったら、勝負
p1_result = card_sum(p1)
p2_result = card_sum(p2)
p3_result = card_sum(p3)
p4_result = card_sum(p4)
d_result = card_sum_d(d)

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

non_nil_values = {}
non_nil_values[:p1_result] = p1_result if p1_result
non_nil_values[:p2_result] = p2_result if p2_result
non_nil_values[:p3_result] = p3_result if p3_result
non_nil_values[:p4_result] = p4_result if p4_result

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
