matrix = [
  [1, 2],
  [4, 5],
  [7, 8]
]

# 各サブ配列の要素を合計
total = matrix.reduce(0) do |sum, sub_array|
  sub_array_total = sub_array.reduce(0) { |sub_sum, element| sub_sum + element }
  sum + sub_array_total
end

puts total
# 出力: 15


