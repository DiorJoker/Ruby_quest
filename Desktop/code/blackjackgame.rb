
# これは、本気用

# frozen_string_literal: true

# クラスとメソッドの定義
# Playerクラスは、ゲームのユーザー
# このクラスは、カードを引くメソッドを持つ
class Player
  def initialize
    @player = []
    @cost = 0
  end

  def player_draw(data)
    random_suit = data.keys.sample
    random_card = data[random_suit].sample

    data[random_suit].delete(random_card)

    @player << [random_suit, random_card]
    puts "あなたの引いたカードは#{random_suit}の#{random_card}です。"
  end

  def cost=(new_cost)
    @cost = new_cost
  end

  def cost
    @cost
  end

  def player_split_draw(data, count)
    random_suit = data.keys.sample
    random_card = data[random_suit].sample

    data[random_suit].delete(random_card)

    @player[count] << [random_suit, random_card]
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

  # スプリット時の合計を計算する関数
  def split_sum(count)
    sum = @player[count].map { |sub_array| sub_array[1] }
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

  attr_accessor :player
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

puts 'プレイスユアベット'

puts 'プレーヤー１は、何円賭けますか？'
p1.cost = gets.chomp.to_i
puts 'プレーヤー２は、何円賭けますか？'
p2.cost = gets.chomp.to_i
puts 'プレーヤー３は、何円賭けますか？'
p3.cost = gets.chomp.to_i
puts 'プレーヤー４は、何円賭けますか？'
p4.cost = gets.chomp.to_i

puts 'ノーモアベット'

# 2枚ずつ配られる
2.times do |counts|
  p1.player_draw(deck)
  puts "#{counts + 1}枚目のカードが配られました。"
end
puts 'プレーヤー１さんのカードが配られました。'
puts 'プレーヤー１さんは、サレンダーしますか？　（Y/N）'
p1_surrender = gets.chomp
if p1_surrender == 'Y'
  p1.cost = p1.cost / 2
  p1_0 = 'end'
  puts '降参しました。'
end

2.times do |counts|
  p2.player_draw(deck)
  puts "#{counts + 1}枚目のカードが配られました。"
end
puts 'プレーヤー２さんのカードが配られました。'
puts 'プレーヤー２さんは、サレンダーしますか？'
p2_surrender = gets.chomp
if p2_surrender == 'Y'
  p2.cost = p2.cost / 2
  p2_0 = 'end'
  puts '降参しました。'
end

2.times do |counts|
  p3.player_draw(deck)
  puts "#{counts + 1}枚目のカードが配られました。"
end
puts 'プレーヤー３さんのカードが配られました。'
puts 'プレーヤー３さんは、サレンダーしますか？'
p3_surrender = gets.chomp
if p3_surrender == 'Y'
  p3.cost = p3.cost / 2
  p3_0 = 'end'
  puts '降参しました。'
end

2.times do |counts|
  p4.player_draw(deck)
  puts "#{counts + 1}枚目のカードが配られました。"
end
puts 'プレーヤー４さんのカードが配られました。'
puts 'プレーヤー４さんは、サレンダーしますか？'
p4_surrender = gets.chomp
if p4_surrender == 'Y'
  p4.cost = p4_0.cost / 2
  p4_0 = 'end'
  puts '降参しました。'
end

2.times do
  d.dealer_draw(deck)
end
puts 'ディーラーのカードが配られました。'

puts "ディーラーの引いたカードは#{d.dealer[0][0]}の#{d.dealer[0][1]}です。"

puts 'ディーラーの引いた2枚目のカードはわかりません。'

# プレーヤー1のターン
if p1.player[0][1] == p1.player[1][1]
  puts 'スプリットしますか？（Y/N）'
  p1_split_hantei = gets.chomp
end

# もし、スプリットの場合
if p1_split_hantei == 'Y'
  p1.cost = p1.cost * 2
  p1.player = [[p1.player[0]],[p1.player[1]]]
  p1_1_total = p1.split_sum(0)
  p1_2_total = p1.split_sum(1)

  puts "プレーヤー１の手札１の現在の得点は#{p1_1_total}です。カードを引きますか？"
  puts 'STAND/HIT/DOUBLEから選んでください'
  p1_1_hantei = gets.chomp

  # ヒットの場合
  while p1_1_hantei == 'HIT'
    p1.player_split_draw(deck,0)
    total = p1.split_sum(0)
    # もし、プレーヤーの合計点数が21点を超えたら、
    if total > 21
      puts "プレーヤー１の得点は#{total}です"
      puts 'プレーヤー１の負けです！'
      p1_1 = 'end'
      break
    else
      puts "プレーヤー１の手札１の現在の得点は#{total}です。カードを引きますか？"
      puts 'STAND/HIT/DOUBLEから選んでください'
      p1_1_hantei = gets.chomp
      if p1_1_hantei == 'DOUBLE'
        puts 'いくら増額しますか？'
        p1_cost_hantei = gets.chomp.to_i
        while p1_cost_hantei >= p1.cost * 2 || p1_cost_hantei < 0
          puts '２倍までしか賭けれません。'
          p1_cost_hantei = gets.chomp.to_i
        end
        p1.cost += p1_cost_hantei
        p1.player_split_draw(deck,0)
        total = p1.split_sum(0)
        # もし、プレーヤーの合計点数が21点を超えたら、
        if total > 21
          puts "プレーヤー１の手札１の得点は#{total}です"
          puts 'プレーヤー１の手札１は脱落しました！'
          p1_1 = 'end'
        else
          puts "プレーヤー１の得点は#{total}です"
        end
        p1_1_hantei = 'STAND'
        break
      end
    end
  end

  # ダブルダウンの場合
  if p1_1_hantei == 'DOUBLE'
    puts 'いくら増額しますか？'
    p1_cost_hantei = gets.chomp.to_i
    while p1_cost_hantei >= p1.cost * 2 || p1_cost_hantei < 0
      puts '２倍までしか賭けれません。'
      p1_cost_hantei = gets.chomp.to_i
    end
    p1.cost += p1_cost_hantei
    p1.player_split_draw(deck,0)
    total = p1.split_sum(0)
    # もし、プレーヤーの合計点数が21点を超えたら、
    if total > 21
      puts "プレーヤー１の手札１の得点は#{total}です"
      puts 'プレーヤー１の手札１は脱落しました！'
      p1_1 = 'end'
    else
      puts "プレーヤー１の手札１の得点は#{total}です"
    end
  end

  puts "プレーヤー１の手札２の現在の得点は#{p1_2_total}です。カードを引きますか？"
  puts 'STAND/HIT/DOUBLEから選んでください'
  p1_2_hantei = gets.chomp

  # ヒットの場合
  while p1_2_hantei == 'HIT'
    p1.player_split_draw(deck,1)
    total = p1.split_sum(1)
    # もし、プレーヤーの合計点数が21点を超えたら、
    if total > 21
      puts "プレーヤー１の得点は#{total}です"
      puts 'プレーヤー１の負けです！'
      p1_2 = 'end'
      break
    else
      puts "プレーヤー１の手札２の現在の得点は#{total}です。カードを引きますか？"
      puts 'STAND/HIT/DOUBLEから選んでください'
      p1_2_hantei = gets.chomp
      if p1_2_hantei == 'DOUBLE'
        puts 'いくら増額しますか？'
        p1_cost_hantei = gets.chomp.to_i
        while p1_cost_hantei >= p1.cost * 2 || p1_cost_hantei < 0
          puts '２倍までしか賭けれません。'
          p1_cost_hantei = gets.chomp.to_i
        end
        p1.cost += p1_cost_hantei
        p1.player_split_draw(deck,1)
        total = p1.split_sum(1)
        # もし、プレーヤーの合計点数が21点を超えたら、
        if total > 21
          puts "プレーヤー１の手札２の得点は#{total}です"
          puts 'プレーヤー１の手札２は脱落しました！'
          p1_2 = 'end'
        else
          puts "プレーヤー１の手札２の得点は#{total}です"
        end
        break
      end
    end
  end

  # ダブルダウンの場合
  if p1_2_hantei == 'DOUBLE'
    puts 'いくら増額しますか？'
    p1_cost_hantei = gets.chomp.to_i
    while p1_cost_hantei >= p1.cost * 2 || p1_cost_hantei < 0
      puts '２倍までしか賭けれません。'
      p1_cost_hantei = gets.chomp.to_i
    end
    p1.cost += p1_cost_hantei
    p1.player_split_draw(deck,1)
    total = p1.split_sum(1)
    # もし、プレーヤーの合計点数が21点を超えたら、
    if total > 21
      puts "プレーヤー１の手札２の得点は#{total}です"
      puts 'プレーヤー１の手札２は脱落しました！'
      p1_2 = 'end'
    else
      puts "プレーヤー１の手札２の得点は#{total}です"
    end
  end
  if p1_1 == 'end' && p1_2 == 'end'
    p1_0 = 'end'
  end
else
  p1_total = p1.card_sum
  puts "プレーヤー１の現在の得点は#{p1_total}です。カードを引きますか？"
  puts 'STAND/HIT/DOUBLEから選んでください'
  p1_hantei = gets.chomp

  # ヒットの場合
  while p1_hantei == 'HIT'
    p1.player_draw(deck)
    total = p1.card_sum
    # もし、プレーヤーの合計点数が21点を超えたら、
    if total > 21
      puts "プレーヤー１の得点は#{total}です"
      puts 'プレーヤー１の負けです！'
      p1_0 = 'end'
      break
    else
      puts "プレーヤー１の現在の得点は#{total}です。カードを引きますか？（Y/N）"
      p1_hantei = gets.chomp
    end
  end

  # ダブルダウンの場合
  if p1_hantei == 'DOUBLE'
    puts 'いくら増額しますか？'
    p1_cost_hantei = gets.chomp.to_i
    while p1_cost_hantei >= p1.cost * 2 || p1_cost_hantei < 0
      puts '２倍までしか賭けれません。'
      p1_cost_hantei = gets.chomp
    end
    p1.cost += p1_cost_hantei
    p1.player_draw(deck)
    total = p1.card_sum
    # もし、プレーヤーの合計点数が21点を超えたら、
    if total > 21
      puts "プレーヤー１の得点は#{total}です"
      puts 'プレーヤー１の負けです！'
      p1_0 = 'end'
    else
      puts "プレーヤー１の得点は#{total}です"
    end
  end
end


# プレーヤー2のターン
if p2.player[0][1] == p2.player[1][1]
  puts 'スプリットしますか？（Y/N）'
  p2_split_hantei = gets.chomp
end

# もし、スプリットの場合
if p2_split_hantei == 'Y'
  p2.cost = p2.cost * 2
  p2.player = [[p2.player[0]],[p2.player[1]]]
  p2_1_total = p2.split_sum(0)
  p2_2_total = p2.split_sum(1)

  puts "プレーヤー２の手札１の現在の得点は#{p2_1_total}です。カードを引きますか？"
  puts 'STAND/HIT/DOUBLEから選んでください'
  p2_1_hantei = gets.chomp

  # ヒットの場合
  while p2_1_hantei == 'HIT'
    p2.player_split_draw(deck,0)
    total = p2.split_sum(0)
    # もし、プレーヤーの合計点数が21点を超えたら、
    if total > 21
      puts "プレーヤー２の得点は#{total}です"
      puts 'プレーヤー２の負けです！'
      p2_1 = 'end'
      break
    else
      puts "プレーヤー２の手札１の現在の得点は#{total}です。カードを引きますか？"
      puts 'STAND/HIT/DOUBLEから選んでください'
      p2_1_hantei = gets.chomp
      if p2_1_hantei == 'DOUBLE'
        puts 'いくら増額しますか？'
        p2_cost_hantei = gets.chomp.to_i
        while p2_cost_hantei >= p2.cost * 2 || p2_cost_hantei < 0
          puts '２倍までしか賭けれません。'
          p2_cost_hantei = gets.chomp.to_i
        end
        p2.cost += p2_cost_hantei
        p2.player_split_draw(deck,0)
        total = p2.split_sum(0)
        # もし、プレーヤーの合計点数が21点を超えたら、
        if total > 21
          puts "プレーヤー２の手札１の得点は#{total}です"
          puts 'プレーヤー２の手札１は脱落しました！'
          p2_1 = 'end'
        else
          puts "プレーヤー２の得点は#{total}です"
        end
        p2_1_hantei = 'STAND'
        break
      end
    end
  end

  # ダブルダウンの場合
  if p2_1_hantei == 'DOUBLE'
    puts 'いくら増額しますか？'
    p2_cost_hantei = gets.chomp.to_i
    while p2_cost_hantei >= p2.cost * 2 || p2_cost_hantei < 0
      puts '２倍までしか賭けれません。'
      p2_cost_hantei = gets.chomp.to_i
    end
    p2.cost += p2_cost_hantei
    p2.player_split_draw(deck,0)
    total = p2.split_sum(0)
    # もし、プレーヤーの合計点数が21点を超えたら、
    if total > 21
      puts "プレーヤー２の手札１の得点は#{total}です"
      puts 'プレーヤー２の手札１は脱落しました！'
      p2_1 = 'end'
    else
      puts "プレーヤー２の手札１の得点は#{total}です"
    end
  end

  puts "プレーヤー２の手札２の現在の得点は#{p2_2_total}です。カードを引きますか？"
  puts 'STAND/HIT/DOUBLEから選んでください'
  p2_2_hantei = gets.chomp

  # ヒットの場合
  while p2_2_hantei == 'HIT'
    p2.player_split_draw(deck,1)
    total = p2.split_sum(1)
    # もし、プレーヤーの合計点数が21点を超えたら、
    if total > 21
      puts "プレーヤー２の得点は#{total}です"
      puts 'プレーヤー２の負けです！'
      p2_2 = 'end'
      break
    else
      puts "プレーヤー２の手札２の現在の得点は#{total}です。カードを引きますか？"
      puts 'STAND/HIT/DOUBLEから選んでください'
      p2_2_hantei = gets.chomp
      if p2_2_hantei == 'DOUBLE'
        puts 'いくら増額しますか？'
        p2_cost_hantei = gets.chomp.to_i
        while p2_cost_hantei >= p2.cost * 2 || p2_cost_hantei < 0
          puts '２倍までしか賭けれません。'
          p2_cost_hantei = gets.chomp.to_i
        end
        p2.cost += p2_cost_hantei
        p2.player_split_draw(deck,1)
        total = p2.split_sum(1)
        # もし、プレーヤーの合計点数が21点を超えたら、
        if total > 21
          puts "プレーヤー２の手札２の得点は#{total}です"
          puts 'プレーヤー２の手札２は脱落しました！'
          p2_2 = 'end'
        else
          puts "プレーヤー２の手札２の得点は#{total}です"
        end
        break
      end
    end
  end

  # ダブルダウンの場合
  if p2_2_hantei == 'DOUBLE'
    puts 'いくら増額しますか？'
    p2_cost_hantei = gets.chomp.to_i
    while p2_cost_hantei >= p2.cost * 2 || p2_cost_hantei < 0
      puts '２倍までしか賭けれません。'
      p2_cost_hantei = gets.chomp.to_i
    end
    p2.cost += p2_cost_hantei
    p2.player_split_draw(deck,1)
    total = p2.split_sum(1)
    # もし、プレーヤーの合計点数が21点を超えたら、
    if total > 21
      puts "プレーヤー２の手札２の得点は#{total}です"
      puts 'プレーヤー２の手札２は脱落しました！'
      p2_2 = 'end'
    else
      puts "プレーヤー２の手札２の得点は#{total}です"
    end
  end
  if p2_1 == 'end' && p2_2 == 'end'
    p2_0 = 'end'
  end
else
  p2_total = p2.card_sum
  puts "プレーヤー２の現在の得点は#{p2_total}です。カードを引きますか？"
  puts 'STAND/HIT/DOUBLEから選んでください'
  p2_hantei = gets.chomp

  # ヒットの場合
  while p2_hantei == 'HIT'
    p2.player_draw(deck)
    total = p2.card_sum
    # もし、プレーヤーの合計点数が21点を超えたら、
    if total > 21
      puts "プレーヤー２の得点は#{total}です"
      puts 'プレーヤー２の負けです！'
      p2_0 = 'end'
      break
    else
      puts "プレーヤー２の現在の得点は#{total}です。カードを引きますか？（Y/N）"
      p2_hantei = gets.chomp
    end
  end

  # ダブルダウンの場合
  if p2_hantei == 'DOUBLE'
    puts 'いくら増額しますか？'
    p2_cost_hantei = gets.chomp.to_i
    while p2_cost_hantei >= p2.cost * 2 || p2_cost_hantei < 0
      puts '２倍までしか賭けれません。'
      p2_cost_hantei = gets.chomp
    end
    p2.cost += p2_cost_hantei
    p2.player_draw(deck)
    total = p2.card_sum
    # もし、プレーヤーの合計点数が21点を超えたら、
    if total > 21
      puts "プレーヤー２の得点は#{total}です"
      puts 'プレーヤー２の負けです！'
      p2_0 = 'end'
    else
      puts "プレーヤー２の得点は#{total}です"
    end
  end
end


# プレーヤー3のターン
if p3.player[0][1] == p3.player[1][1]
  puts 'スプリットしますか？（Y/N）'
  p3_split_hantei = gets.chomp
end

# もし、スプリットの場合
if p3_split_hantei == 'Y'
  p3.cost = p3.cost * 2
  p3.player = [[p3.player[0]],[p3.player[1]]]
  p3_1_total = p3.split_sum(0)
  p3_2_total = p3.split_sum(1)

  puts "プレーヤー３の手札１の現在の得点は#{p3_1_total}です。カードを引きますか？"
  puts 'STAND/HIT/DOUBLEから選んでください'
  p3_1_hantei = gets.chomp

  # ヒットの場合
  while p3_1_hantei == 'HIT'
    p3.player_split_draw(deck,0)
    total = p3.split_sum(0)
    # もし、プレーヤーの合計点数が21点を超えたら、
    if total > 21
      puts "プレーヤー３の得点は#{total}です"
      puts 'プレーヤー３の負けです！'
      p3_1 = 'end'
      break
    else
      puts "プレーヤー３の手札１の現在の得点は#{total}です。カードを引きますか？"
      puts 'STAND/HIT/DOUBLEから選んでください'
      p3_1_hantei = gets.chomp
      if p3_1_hantei == 'DOUBLE'
        puts 'いくら増額しますか？'
        p3_cost_hantei = gets.chomp.to_i
        while p3_cost_hantei >= p3.cost * 2 || p3_cost_hantei < 0
          puts '２倍までしか賭けれません。'
          p3_cost_hantei = gets.chomp.to_i
        end
        p3.cost += p3_cost_hantei
        p3.player_split_draw(deck,0)
        total = p3.split_sum(0)
        # もし、プレーヤーの合計点数が21点を超えたら、
        if total > 21
          puts "プレーヤー３の手札１の得点は#{total}です"
          puts 'プレーヤー３の手札１は脱落しました！'
          p3_1 = 'end'
        else
          puts "プレーヤー３の得点は#{total}です"
        end
        p3_1_hantei = 'STAND'
        break
      end
    end
  end

  # ダブルダウンの場合
  if p3_1_hantei == 'DOUBLE'
    puts 'いくら増額しますか？'
    p3_cost_hantei = gets.chomp.to_i
    while p3_cost_hantei >= p3.cost * 2 || p3_cost_hantei < 0
      puts '２倍までしか賭けれません。'
      p3_cost_hantei = gets.chomp.to_i
    end
    p3.cost += p3_cost_hantei
    p3.player_split_draw(deck,0)
    total = p3.split_sum(0)
    # もし、プレーヤーの合計点数が21点を超えたら、
    if total > 21
      puts "プレーヤー３の手札１の得点は#{total}です"
      puts 'プレーヤー３の手札１は脱落しました！'
      p3_1 = 'end'
    else
      puts "プレーヤー３の手札１の得点は#{total}です"
    end
  end

  puts "プレーヤー３の手札２の現在の得点は#{p3_2_total}です。カードを引きますか？"
  puts 'STAND/HIT/DOUBLEから選んでください'
  p3_2_hantei = gets.chomp

  # ヒットの場合
  while p3_2_hantei == 'HIT'
    p3.player_split_draw(deck,1)
    total = p3.split_sum(1)
    # もし、プレーヤーの合計点数が21点を超えたら、
    if total > 21
      puts "プレーヤー３の得点は#{total}です"
      puts 'プレーヤー３の負けです！'
      p3_2 = 'end'
      break
    else
      puts "プレーヤー３の手札２の現在の得点は#{total}です。カードを引きますか？"
      puts 'STAND/HIT/DOUBLEから選んでください'
      p3_2_hantei = gets.chomp
      if p3_2_hantei == 'DOUBLE'
        puts 'いくら増額しますか？'
        p3_cost_hantei = gets.chomp.to_i
        while p3_cost_hantei >= p3.cost * 2 || p3_cost_hantei < 0
          puts '２倍までしか賭けれません。'
          p3_cost_hantei = gets.chomp.to_i
        end
        p3.cost += p3_cost_hantei
        p3.player_split_draw(deck,1)
        total = p3.split_sum(1)
        # もし、プレーヤーの合計点数が21点を超えたら、
        if total > 21
          puts "プレーヤー３の手札２の得点は#{total}です"
          puts 'プレーヤー３の手札２は脱落しました！'
          p3_2 = 'end'
        else
          puts "プレーヤー３の手札２の得点は#{total}です"
        end
        break
      end
    end
  end

  # ダブルダウンの場合
  if p3_2_hantei == 'DOUBLE'
    puts 'いくら増額しますか？'
    p3_cost_hantei = gets.chomp.to_i
    while p3_cost_hantei >= p3.cost * 2 || p3_cost_hantei < 0
      puts '２倍までしか賭けれません。'
      p3_cost_hantei = gets.chomp.to_i
    end
    p3.cost += p3_cost_hantei
    p3.player_split_draw(deck,1)
    total = p3.split_sum(1)
    # もし、プレーヤーの合計点数が21点を超えたら、
    if total > 21
      puts "プレーヤー３の手札２の得点は#{total}です"
      puts 'プレーヤー３の手札２は脱落しました！'
      p3_2 = 'end'
    else
      puts "プレーヤー３の手札２の得点は#{total}です"
    end
  end
  if p3_1 == 'end' && p3_2 == 'end'
    p3_0 = 'end'
  end
else
  p3_total = p3.card_sum
  puts "プレーヤー３の現在の得点は#{p3_total}です。カードを引きますか？"
  puts 'STAND/HIT/DOUBLEから選んでください'
  p3_hantei = gets.chomp

  # ヒットの場合
  while p3_hantei == 'HIT'
    p3.player_draw(deck)
    total = p3.card_sum
    # もし、プレーヤーの合計点数が21点を超えたら、
    if total > 21
      puts "プレーヤー３の得点は#{total}です"
      puts 'プレーヤー３の負けです！'
      p3_0 = 'end'
      break
    else
      puts "プレーヤー３の現在の得点は#{total}です。カードを引きますか？（Y/N）"
      p3_hantei = gets.chomp
    end
  end

  # ダブルダウンの場合
  if p3_hantei == 'DOUBLE'
    puts 'いくら増額しますか？'
    p3_cost_hantei = gets.chomp.to_i
    while p3_cost_hantei >= p3.cost * 2 || p3_cost_hantei < 0
      puts '２倍までしか賭けれません。'
      p3_cost_hantei = gets.chomp
    end
    p3.cost += p3_cost_hantei
    p3.player_draw(deck)
    total = p3.card_sum
    # もし、プレーヤーの合計点数が21点を超えたら、
    if total > 21
      puts "プレーヤー３の得点は#{total}です"
      puts 'プレーヤー３の負けです！'
      p3_0 = 'end'
    else
      puts "プレーヤー３の得点は#{total}です"
    end
  end
end



# プレーヤー4のターン
if p4.player[0][1] == p4.player[1][1]
  puts 'スプリットしますか？（Y/N）'
  p4_split_hantei = gets.chomp
end

# もし、スプリットの場合
if p4_split_hantei == 'Y'
  p4.cost = p4.cost * 2
  p4.player = [[p4.player[0]],[p4.player[1]]]
  p4_1_total = p4.split_sum(0)
  p4_2_total = p4.split_sum(1)

  puts "プレーヤー４の手札１の現在の得点は#{p4_1_total}です。カードを引きますか？"
  puts 'STAND/HIT/DOUBLEから選んでください'
  p4_1_hantei = gets.chomp

  # ヒットの場合
  while p4_1_hantei == 'HIT'
    p4.player_split_draw(deck,0)
    total = p4.split_sum(0)
    # もし、プレーヤーの合計点数が21点を超えたら、
    if total > 21
      puts "プレーヤー４の得点は#{total}です"
      puts 'プレーヤー４の負けです！'
      p4_1 = 'end'
      break
    else
      puts "プレーヤー４の手札１の現在の得点は#{total}です。カードを引きますか？"
      puts 'STAND/HIT/DOUBLEから選んでください'
      p4_1_hantei = gets.chomp
      if p4_1_hantei == 'DOUBLE'
        puts 'いくら増額しますか？'
        p4_cost_hantei = gets.chomp.to_i
        while p4_cost_hantei >= p4.cost * 2 || p4_cost_hantei < 0
          puts '２倍までしか賭けれません。'
          p4_cost_hantei = gets.chomp.to_i
        end
        p4.cost += p4_cost_hantei
        p4.player_split_draw(deck,0)
        total = p4.split_sum(0)
        # もし、プレーヤーの合計点数が21点を超えたら、
        if total > 21
          puts "プレーヤー４の手札１の得点は#{total}です"
          puts 'プレーヤー４の手札１は脱落しました！'
          p4_1 = 'end'
        else
          puts "プレーヤー４の得点は#{total}です"
        end
        p4_1_hantei = 'STAND'
        break
      end
    end
  end

  # ダブルダウンの場合
  if p4_1_hantei == 'DOUBLE'
    puts 'いくら増額しますか？'
    p4_cost_hantei = gets.chomp.to_i
    while p4_cost_hantei >= p4.cost * 2 || p4_cost_hantei < 0
      puts '２倍までしか賭けれません。'
      p4_cost_hantei = gets.chomp.to_i
    end
    p4.cost += p4_cost_hantei
    p4.player_split_draw(deck,0)
    total = p4.split_sum(0)
    # もし、プレーヤーの合計点数が21点を超えたら、
    if total > 21
      puts "プレーヤー４の手札１の得点は#{total}です"
      puts 'プレーヤー４の手札１は脱落しました！'
      p4_1 = 'end'
    else
      puts "プレーヤー４の手札１の得点は#{total}です"
    end
  end

  puts "プレーヤー４の手札２の現在の得点は#{p4_2_total}です。カードを引きますか？"
  puts 'STAND/HIT/DOUBLEから選んでください'
  p4_2_hantei = gets.chomp

  # ヒットの場合
  while p4_2_hantei == 'HIT'
    p4.player_split_draw(deck,1)
    total = p4.split_sum(1)
    # もし、プレーヤーの合計点数が21点を超えたら、
    if total > 21
      puts "プレーヤー４の得点は#{total}です"
      puts 'プレーヤー４の負けです！'
      p4_2 = 'end'
      break
    else
      puts "プレーヤー４の手札２の現在の得点は#{total}です。カードを引きますか？"
      puts 'STAND/HIT/DOUBLEから選んでください'
      p4_2_hantei = gets.chomp
      if p4_2_hantei == 'DOUBLE'
        puts 'いくら増額しますか？'
        p4_cost_hantei = gets.chomp.to_i
        while p4_cost_hantei >= p4.cost * 2 || p4_cost_hantei < 0
          puts '２倍までしか賭けれません。'
          p4_cost_hantei = gets.chomp.to_i
        end
        p4.cost += p4_cost_hantei
        p4.player_split_draw(deck,1)
        total = p4.split_sum(1)
        # もし、プレーヤーの合計点数が21点を超えたら、
        if total > 21
          puts "プレーヤー４の手札２の得点は#{total}です"
          puts 'プレーヤー４の手札２は脱落しました！'
          p4_2 = 'end'
        else
          puts "プレーヤー４の手札２の得点は#{total}です"
        end
        break
      end
    end
  end

  # ダブルダウンの場合
  if p4_2_hantei == 'DOUBLE'
    puts 'いくら増額しますか？'
    p4_cost_hantei = gets.chomp.to_i
    while p4_cost_hantei >= p4.cost * 2 || p4_cost_hantei < 0
      puts '２倍までしか賭けれません。'
      p4_cost_hantei = gets.chomp.to_i
    end
    p4.cost += p4_cost_hantei
    p4.player_split_draw(deck,1)
    total = p4.split_sum(1)
    # もし、プレーヤーの合計点数が21点を超えたら、
    if total > 21
      puts "プレーヤー４の手札２の得点は#{total}です"
      puts 'プレーヤー４の手札２は脱落しました！'
      p4_2 = 'end'
    else
      puts "プレーヤー４の手札２の得点は#{total}です"
    end
  end
  if p4_1 == 'end' && p4_2 == 'end'
    p4_0 = 'end'
  end
else
  p4_total = p4.card_sum
  puts "プレーヤー４の現在の得点は#{p4_total}です。カードを引きますか？"
  puts 'STAND/HIT/DOUBLEから選んでください'
  p4_hantei = gets.chomp

  # ヒットの場合
  while p4_hantei == 'HIT'
    p4.player_draw(deck)
    total = p4.card_sum
    # もし、プレーヤーの合計点数が21点を超えたら、
    if total > 21
      puts "プレーヤー４の得点は#{total}です"
      puts 'プレーヤー４の負けです！'
      p4_0 = 'end'
      break
    else
      puts "プレーヤー４の現在の得点は#{total}です。カードを引きますか？（Y/N）"
      p4_hantei = gets.chomp
    end
  end

  # ダブルダウンの場合
  if p4_hantei == 'DOUBLE'
    puts 'いくら増額しますか？'
    p4_cost_hantei = gets.chomp.to_i
    while p4_cost_hantei >= p4.cost * 2 || p4_cost_hantei < 0
      puts '２倍までしか賭けれません。'
      p4_cost_hantei = gets.chomp
    end
    p4.cost += p4_cost_hantei
    p4.player_draw(deck)
    total = p4.card_sum
    # もし、プレーヤーの合計点数が21点を超えたら、
    if total > 21
      puts "プレーヤー４の得点は#{total}です"
      puts 'プレーヤー４の負けです！'
      p4_0 = 'end'
    else
      puts "プレーヤー４の得点は#{total}です"
    end
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
    d_hantei = 'end'
    break
  end
end

puts "ディーラーの得点は#{d_total}です."

# もし、ディーラーのターンが終わったら、勝負

if p1_0 == 'end'
  puts 'プレーヤー１は脱落しています。'
else
  if p1_split_hantei == 'Y'
    if p1_1 != 'end' && p1_2 != 'end'
      p1_1_total = p1.split_sum(0)
      p1_2_total = p1.split_sum(1)
      p1_max = [p1_1_total, p1_2_total].max
    end
  else
    p1_max = p1.card_sum
  end
end

if p2_0 == 'end'
  puts 'プレーヤー２は脱落しています。'
else
  if p2_split_hantei == 'Y'
    if p2_1 != 'end' && p2_2 != 'end'
      p2_1_total = p2.split_sum(0)
      p2_2_total = p2.split_sum(1)
      p2_max = [p2_1_total, p2_2_total].max
    end
  else
    p2_max = p2.card_sum
  end
end

if p3_0 == 'end'
  puts 'プレーヤー３は脱落しています。'
else
  if p3_split_hantei == 'Y'
    if p3_1 != 'end' && p3_2 != 'end'
      p3_1_total = p3.split_sum(0)
      p3_2_total = p3.split_sum(1)
      p3_max = [p3_1_total, p3_2_total].max
    end
  else
    p3_max = p3.card_sum
  end
end

if p4_0 == 'end'
  puts 'プレーヤー４は脱落しています。'
else
  if p4_split_hantei == 'Y'
    if p4_1 != 'end' && p4_2 != 'end'
      p4_1_total = p4.split_sum(0)
      p4_2_total = p4.split_sum(1)
      p4_max = [p4_1_total, p4_2_total].max
    end
  else
    p4_max = p4.card_sum
  end
end

if d_hantei == 'end'
  puts 'ディーラーは脱落しています。'
else
  d_max = d.card_sum
end


non_nil_values = {}
non_nil_values[:p1_max] = p1_max if p1_max
non_nil_values[:p2_max] = p2_max if p2_max
non_nil_values[:p3_max] = p3_max if p3_max
non_nil_values[:p4_max] = p4_max if p4_max
non_nil_values[:d_max] = d_max if d_max

max_variable = non_nil_values.key(non_nil_values.values.max)
max_value = non_nil_values.values.max

case max_variable
when p1_max
  'プレーヤー１の勝ちです！'
  puts "p1.costが手に入ります！！"
when p2_max
  'プレーヤー２の勝ちです！'
  puts "p2.costが手に入ります！！"
when p3_max
  'プレーヤー３の勝ちです！'
  puts "p3.costが手に入ります！！"
when p4_max
  'プレーヤー４の勝ちです！'
  puts "p4.costが手に入ります！！"
when d_max
  'ディーラーの勝ちです！'
else
  puts '引き分けです。'
end
