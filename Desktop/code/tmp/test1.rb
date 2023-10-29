# 2次元配列の例
two_dimensional_array = [
  [1, 'A'],
  [2, 'B'],
  [3, 'C'],
  [4, 'D']
]

# 2番目の値を取得
second_values = two_dimensional_array.map { |sub_array| sub_array[1] }

# 結果を表示
puts second_values
