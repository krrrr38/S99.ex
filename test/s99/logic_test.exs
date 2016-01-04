defmodule S99.LogicTest do
  use ExUnit.Case, async: true
  doctest S99.Logic

  test "my_logic: P46" do
    # my_and
    assert  S99.Logic.my_and(true, true)
    assert !S99.Logic.my_and(true, false)
    assert !S99.Logic.my_and(false, true)
    assert !S99.Logic.my_and(false, false)
    # my_or
    assert  S99.Logic.my_or(true, true)
    assert  S99.Logic.my_or(true, false)
    assert  S99.Logic.my_or(false, true)
    assert !S99.Logic.my_or(false, false)
    # my_not
    assert !S99.Logic.my_not(true)
    assert  S99.Logic.my_not(false)
    # my_nand
    assert !S99.Logic.my_nand(true, true)
    assert  S99.Logic.my_nand(true, false)
    assert  S99.Logic.my_nand(false, true)
    assert  S99.Logic.my_nand(false, false)
    # my_nor
    assert !S99.Logic.my_nor(true, true)
    assert !S99.Logic.my_nor(true, false)
    assert !S99.Logic.my_nor(false, true)
    assert  S99.Logic.my_nor(false, false)
    # my_xor
    assert !S99.Logic.my_xor(true, true)
    assert  S99.Logic.my_xor(true, false)
    assert  S99.Logic.my_xor(false, true)
    assert !S99.Logic.my_xor(false, false)
    # my_impl
    assert  S99.Logic.my_impl(true, true)
    assert !S99.Logic.my_impl(true, false)
    assert  S99.Logic.my_impl(false, true)
    assert  S99.Logic.my_impl(false, false)
    # my_equ
    assert  S99.Logic.my_equ(true, true)
    assert !S99.Logic.my_equ(true, false)
    assert !S99.Logic.my_equ(false, true)
    assert  S99.Logic.my_equ(false, false)
  end

  test "huffman: P50" do
    assert S99.Logic.huffman(%{}) == %{}
    assert S99.Logic.huffman(%{:a => 1}) == %{:a => "0"}
    assert S99.Logic.huffman(%{:a => 2, :b => 1}) == %{:a => "1", :b => "0"}
    assert S99.Logic.huffman(%{:a => 2, :b => 1, :c => 4}) == %{:a => "01", :b => "00", :c => "1"}

    assert S99.Logic.huffman(%{:a => 45, :b => 13, :c => 12, :d => 16, :e => 9, :f => 5}) == %{:a => "0", :b => "101", :c => "100", :d => "111", :e => "1101", :f => "1100"}
    assert S99.Logic.huffman(%{:f => 5, :a => 45, :b => 13, :c => 12, :d => 16, :e => 9}) == %{:a => "0", :b => "101", :c => "100", :d => "111", :e => "1101", :f => "1100"}
  end
end
