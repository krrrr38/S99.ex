defmodule S99.ListTest do
  use ExUnit.Case, async: true
  doctest S99.List

  test "last: P01" do
    assert S99.List.last([]) == nil
    assert S99.List.last([1]) == 1
    assert S99.List.last([1, 2]) == 2
    assert S99.List.last([1, 1, 2, 3, 5, 8]) == 8
  end

  test "penultimate: P02" do
    assert S99.List.penultimate([]) == nil
    assert S99.List.penultimate([1]) == nil
    assert S99.List.penultimate([1, 1, 2, 3, 5, 8]) == 5
  end

  test "nth: P03" do
    assert S99.List.nth(-1, [1, 1, 2, 3, 5, 8]) == nil
    assert S99.List.nth(0, [1, 1, 2, 3, 5, 8]) == 1
    assert S99.List.nth(2, [1, 1, 2, 3, 5, 8]) == 2
    assert S99.List.nth(20, [1, 1, 2, 3, 5, 8]) == nil
  end

  test "length: P04" do
    # my_length
    assert S99.List.my_length([]) == 0
    assert S99.List.my_length([1, 1, 2, 3, 5, 8]) == 6
    # my_length_rec
    assert S99.List.my_length_rec([]) == 0
    assert S99.List.my_length_rec([1, 1, 2, 3, 5, 8]) == 6
    # my_length_fold
    assert S99.List.my_length_fold([]) == 0
    assert S99.List.my_length_fold([1, 1, 2, 3, 5, 8]) == 6
  end

  test "reverse: P05" do
    # reverse
    assert S99.List.reverse([]) == []
    assert S99.List.reverse([1, 1, 2, 3, 5, 8]) == [8, 5, 3, 2, 1, 1]
    # reverse_fold
    assert S99.List.reverse_fold([]) == []
    assert S99.List.reverse_fold([1, 1, 2, 3, 5, 8]) == [8, 5, 3, 2, 1, 1]
  end

  test "is_palindrome: P06" do
    assert S99.List.is_palindrome([]) == true
    assert S99.List.is_palindrome([1, 2, 3, 2, 1]) == true
    assert S99.List.is_palindrome([1, 2, 3, 3, 2, 1]) == true
    assert S99.List.is_palindrome([1, 2, 3, 3, 2, 3]) == false
    assert S99.List.is_palindrome([1, 2, 3, 2, 3]) == false
  end

  test "flatten: P07" do
    # flatten
    assert S99.List.flatten([]) == []
    assert S99.List.flatten([1, 2, 3]) == [1, 2, 3]
    assert S99.List.flatten([[1, 1], 2, [3, [5, [8]]]]) == [1, 1, 2, 3, [5, [8]]]
    # flatten_all
    assert S99.List.flatten_all([]) == []
    assert S99.List.flatten_all([1, 2, 3]) == [1, 2, 3]
    assert S99.List.flatten_all([[[[[1]]]]]) == [1]
    assert S99.List.flatten_all([[1, 1], 2, [3, [5, [8]]]]) == [1, 1, 2, 3, 5, 8]
  end

  test "compress: P08" do
    assert S99.List.compress([]) == []
    assert S99.List.compress([1, 1, 1]) == [1]
    assert S99.List.compress(["a", "a", "a", "a", "b", "c", "c", "a", "a", "d", "e", "e", "e", "e"]) == ["a", "b", "c", "a", "d", "e"]
  end

  test "pack: P09" do
    assert S99.List.pack([]) == []
    assert S99.List.pack(["a"]) == [["a"]]
    assert S99.List.pack(["a", "a", "a", "a", "b", "c", "c", "a", "a", "d", "e", "e", "e", "e"]) == [["a", "a", "a", "a"], ["b"], ["c", "c"], ["a", "a"], ["d"], ["e", "e", "e", "e"]]
  end

  test "encode: P10" do
    assert S99.List.encode([]) == []
    assert S99.List.encode([:a]) == [{:a, 1}]
    assert S99.List.encode([:a, :a, :a, :a, :b, :c, :c, :a, :a, :d, :e, :e, :e, :e]) == [{:a, 4}, {:b, 1}, {:c, 2}, {:a, 2}, {:d, 1}, {:e, 4}]
  end

  test "encodeModified: P11" do
    assert S99.List.encode_modified([]) == []
    assert S99.List.encode_modified([:a, :a, :a, :a, :b, :c, :c, :a, :a, :d, :e, :e, :e, :e]) == [{:a, 4}, :b, {:c, 2}, {:a, 2}, :d, {:e, 4}]
  end

  test "decode: P12" do
    assert S99.List.decode([]) == []
    assert S99.List.decode([{:a, 1}]) == [:a]
    assert S99.List.decode([{:a, 4}, {:b, 1}, {:c, 2}, {:a, 2}, {:d, 1}, {:e, 4}]) == [:a, :a, :a, :a, :b, :c, :c, :a, :a, :d, :e, :e, :e, :e]
  end

  # ...

end
