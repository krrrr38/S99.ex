defmodule S99.ArithTest do
  use ExUnit.Case, async: true
  doctest S99.Arith

  test "isPrime: P31" do
    assert  S99.Arith.is_prime(2)
    assert  S99.Arith.is_prime(3)
    assert !S99.Arith.is_prime(4)
    assert  S99.Arith.is_prime(5)
    assert !S99.Arith.is_prime(6)
    assert  S99.Arith.is_prime(7)
    assert !S99.Arith.is_prime(8)
    assert !S99.Arith.is_prime(9)
    assert !S99.Arith.is_prime(10)
    assert  S99.Arith.is_prime(11)
    assert !S99.Arith.is_prime(12)
    assert  S99.Arith.is_prime(13)
  end

  test "gcd: P32" do
    assert S99.Arith.gcd(36, 63) == 9
  end

  # ...

end
