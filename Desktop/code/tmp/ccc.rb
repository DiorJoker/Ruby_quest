# frozen_string_literal: true

# クラスとメソッドの定義
# Playerクラスは、ゲームのユーザー
# このクラスは、カードを引くメソッドを持つ
class Player
  def initialize
    @hand = []
  end

  def player_draw(data)
    random_suit = data.keys.sample
    random_card = data[random_suit].sample

    data[random_suit].delete(random_card)

    @hand << [random_suit, random_card]

    puts "あなたの引いたカードは#{random_suit}の#{random_card}です。"
  end

  attr_reader :hand
end

# Dealerクラスは、コンピュータが自動実行
# このクラスも、カードを引く機能を持つ
class Dealer
  def initialize
    @hand = []
  end

  def dealer_draw(data)
    random_suit = data.keys.sample
    random_card = data[random_suit].sample

    data[random_suit].delete(random_card)

    @hand << [random_suit, random_card]
  end

  attr_reader :hand
end

# ブラックジャックゲームが、開始される
players = []
dealer = Dealer.new

puts 'ブラックジャックゲームを開始します。'

# プレイヤー数を設定
player_count = 3

# プレイヤーの追加
player_count.times do
  players << Player.new
end

deck = {
  'クラブ' => ['A', 2, 3, 4, 5, 6, 7, 8, 9, 10, 'J', 'Q', 'K'],
  'ダイヤ' => ['A', 2, 3, 4, 5, 6, 7, 8, 9, 10, 'J', 'Q', 'K'],
  'ハート' => ['A', 2, 3, 4, 5, 6, 7, 8, 9, 10, 'J', 'Q', 'K'],
  'スペード' => ['A', 2, 3, 4, 5, 6, 7, 8, 9, 10, 'J', 'Q', 'K']
}

# 2枚ずつ配られる
2.times do
  players.each { |player| player.player_draw(deck) }
end

2.times do
  dealer.dealer_draw(deck)
end

# プレーヤーの手札と合計ポイントを計算するメソッド
def calculate_hand_total(hand)
  total = 0
  aces = 0

  hand.each do |suit, card|
    if card == 'A'
      total += 11
      aces += 1
    elsif %w[J Q K].include?(card)
      total += 10
    else
      total += card.to_i
    end
  end

  # Acesの処理 (Aを11としてカウントした場合、合計が21を超えていたらAを1に変える)
  while total > 21 && aces.positive?
    total -= 10
    aces -= 1
  end

  total
end

# ディーラーの2枚目のカードを表示
puts "ディーラーの引いた2枚目のカードは#{dealer.hand[1][0]}のカードです。"

# プレイヤーのターン
players.each do |player|
  player_total = calculate_hand_total(player.hand)
  while player_total < 21
    puts "あなたの現在の得点は#{player_total}です。#{player}、カードを引きますか？（Y/N）"
    hantei = gets.chomp
    if hantei.upcase == 'Y'
      player.player_draw(deck)
      player_total = calculate_hand_total(player.hand)
    else
      break
    end
  end
end

# ディーラーのターン
dealer_total = calculate_hand_total(dealer.hand)
while dealer_total < 17
  dealer.dealer_draw(deck)
  dealer_total = calculate_hand_total(dealer.hand)
end

# 勝敗判定
players.each do |player|
  puts "#{player}の得点は#{calculate_hand_total(player.hand)}です。"
end
puts "ディーラーの得点は#{dealer_total}です。"

players.each do |player|
  if calculate_hand_total(player.hand) > 21
    puts "#{player}の負けです。"
  elsif dealer_total > 21
    puts "#{player}の勝ちです。"
  elsif calculate_hand_total(player.hand) > dealer_total
    puts "#{player}の勝ちです。"
  elsif dealer_total > calculate_hand_total(player.hand)
    puts "#{player}の負けです。"
  else
    puts "#{player}とディーラーの引き分けです。"
  end
end
