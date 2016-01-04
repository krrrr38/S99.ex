defmodule S99.Arith do
  @doc """
  P31: Determine whether a given integer number is prime.
  """
  @spec is_prime(non_neg_integer) :: boolean
  def is_prime(n) when is_number(n), do: S99.Arith.Prime.is_prime(n)

  @doc """
  P32: Determine the greatest common divisor of two positive integer numbers.
  """
  @spec gcd(non_neg_integer, non_neg_integer) :: non_neg_integer
  def gcd(x, y) when is_number(x) and is_number(y) do
    if y == 0 do
      x
    else
      gcd(y, rem(x, y))
    end
  end

  # ...

  defmodule Prime do
    @spec is_prime(non_neg_integer) :: boolean
    def is_prime(n) do
      List.last(Enum.to_list Stream.take_while(primes, &(&1 <= n))) == n
    end

    def primes do
      Stream.concat(
        [2],
        Stream.filter(
          Stream.iterate(3, &(&1 + 1)),
          fn x ->
             Enum.all?(
               Stream.take_while(primes, &(&1*&1 <= x)),
               fn v -> rem(x, v) != 0 end
             )
          end
        )
      )
    end
  end
end
