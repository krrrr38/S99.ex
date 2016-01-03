defmodule S99.List do
  @doc ~S"""
  P01: Find the last element of a list. `List.last/1`

  ## Examples

      iex> S99.List.last [1, 2, 3, 4]
      4
      iex> S99.List.last []
      nil

  """
  def last([]), do: nil
  def last([x]), do: x
  def last([_|t]), do: last(t)

  @doc """
  P02: Find the last but one element of a list.
  """
  def penultimate([]), do: nil
  def penultimate([_]), do: nil
  def penultimate([x|[_]]), do: x
  def penultimate([_|t]), do: penultimate(t)

  @doc """
  P03: Find the `n`th element of a list.
  """
  def nth(n, _) when n < 0, do: nil
  def nth(n, []) when n > 0, do: nil
  def nth(0, [h|_]), do: h
  def nth(n, [_|t]), do: nth(n - 1, t)

  @doc """
  P04: Find the number of elements of a list. `length/1`
  """
  def my_length([]), do: 0
  def my_length([_|t]), do: 1 + my_length(t)

  @doc """
  P04: Find the number of elements of a list. `length/1`
  """
  def my_length_rec(list) do
    my_length_rec_loop(0, list)
  end
  defp my_length_rec_loop(len, []), do: len
  defp my_length_rec_loop(len, [_|t]), do: my_length_rec_loop(1 + len, t)

  @doc """
  P04: Find the number of elements of a list. `length/1`
  """
  def my_length_fold(list) when is_list(list) do
    List.foldl(list, 0, fn (_, acc) -> 1 + acc end)
  end

  @doc """
  P05: Reverse a list.
  """
  def reverse([]), do: []
  def reverse([t|h]), do: reverse(h) ++ [t]

  @doc """
  P05: Reverse a list.
  """
  def reverse_fold(list) when is_list(list) do
    List.foldl(list, [], fn (x, acc) -> [x] ++ acc end)
  end

  @doc """
  P06: Find out whether a list is a palindrome.
  """
  def isPalindrome([]), do: true
  def isPalindrome(list) when is_list(list), do: reverse(list) == list

  @doc """
  P07: Flatten a nested list structure.
  """
  def flatten([]), do: []
  def flatten([h|t]) when is_list(h), do: h ++ flatten(t)
  def flatten([h|t]), do: [h] ++ flatten(t)

  @doc """
  P07: Flatten a nested list structure. `List.flatten/1`
  """
  def flatten_all([]), do: []
  def flatten_all([h|t]) when is_list(h), do: flatten_all(h) ++ flatten_all(t)
  def flatten_all([h|t]), do: [h] ++ flatten_all(t)

  @doc """
  P08: Eliminate consecutive duplicates of list elements.
  """
  def compress([]), do: []
  def compress([h|t]), do: compress_loop(h, t)
  defp compress_loop(x, []), do: [x]
  defp compress_loop(x, [h|t]) when x == h, do: compress_loop(h, t)
  defp compress_loop(x, [h|t]) when x != h, do: [x] ++ compress_loop(h, t)

  @doc """
  P09: Pack consecutive duplicates of list elements into sublists.
  """
  def pack([]), do: []
  def pack([h|t]), do: pack_loop(h, [h], t)
  defp pack_loop(_, acc, []), do: [acc]
  defp pack_loop(x, acc, [y|t]) when x == y, do: pack_loop(x, [y] ++ acc, t)
  defp pack_loop(x, acc, [y|t]) when x != y, do: [acc] ++ pack_loop(y, [y], t)

  @doc """
  P10: Run-length encoding of a list.
  """
  def encode(list) when is_list(list) do
    Enum.map(pack(list), fn xs -> {hd(xs), length xs} end)
  end

  @doc """
  P11: Modified run-length encoding.
  """
  def encodeModified(list) do
    Enum.map(pack(list), fn xs ->
      if length(xs) == 1 do
        hd(xs)
      else
        {hd(xs), length xs}
      end
    end)
  end

  @doc """
  P12: Decode a run-length encoded list.
  """
  def decode(list) when is_list(list) do
    Enum.flat_map(list, fn {v, cnt} -> List.foldl(Enum.to_list(1..cnt), [], fn (_, acc) -> [v] ++ acc end) end)
  end

  # ...

end
