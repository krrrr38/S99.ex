defmodule S99.Logic do
  @doc """
  P46: Truth tables for logical expressions.
  """
  @spec my_and(boolean, boolean) :: boolean
  def my_and(b1, b2) when is_boolean(b1) and is_boolean(b2), do: b1 and b2
  @spec my_or(boolean, boolean) :: boolean
  def my_or(b1, b2) when is_boolean(b1) and is_boolean(b2), do: b1 or b2
  @spec my_not(boolean) :: boolean
  def my_not(b) when is_boolean(b), do: not b
  @spec my_nand(boolean, boolean) :: boolean
  def my_nand(b1, b2) when is_boolean(b1) and is_boolean(b2), do: my_not(my_and(b1, b2))
  @spec my_nor(boolean, boolean) :: boolean
  def my_nor(b1, b2) when is_boolean(b1) and is_boolean(b2), do: my_not(my_or(b1, b2))
  @spec my_xor(boolean, boolean) :: boolean
  def my_xor(b1, b2) when is_boolean(b1) and is_boolean(b2), do: my_not(my_equ(b1, b2))
  @spec my_impl(boolean, boolean) :: boolean
  def my_impl(b1, b2) when is_boolean(b1) and is_boolean(b2), do: my_or(my_not(b1), b2)
  @spec my_equ(boolean, boolean) :: boolean
  def my_equ(b1, b2) when is_boolean(b1) and is_boolean(b2) do
    my_or(my_and(b1, b2), my_and(my_not(b1), my_not(b2)))
  end

  # ...

  @doc """
  P50: Huffman code.
  """
  @spec huffman(map) :: map
  def huffman(map) when is_map(map) do
    alias S99.Logic.Huffman
    Enum.into(Huffman.encode(map), %{})
  end

  defmodule Huffman do

    defmodule HuffmanNode do
      defstruct score: nil, left: nil, right: nil
      @type t :: %__MODULE__{score: non_neg_integer, left: HuffmanLeaf.t | HuffmanNode.t, right: HuffmanNode | HuffmanNode.t}
    end

    defmodule HuffmanLeaf do
      defstruct score: nil, value: nil
      @type t :: %__MODULE__{score: non_neg_integer, value: any}
    end

    defprotocol HuffmanCode do
      @fallback_to_any false
      def code(tree, prefix)
    end

    defimpl HuffmanCode, for: HuffmanNode do
      @spec code(HuffmanNode.t, String.t) :: [{any, String.t}]
      def code(%HuffmanNode{score: _, left: left, right: right}, prefix) do
        HuffmanCode.code(left, prefix <> "1") ++ HuffmanCode.code(right, prefix <> "0")
      end
    end

    defimpl HuffmanCode, for: HuffmanLeaf do
      @spec code(HuffmanLeaf.t, String.t) :: [{any, String.t}]
      def code(%HuffmanLeaf{score: _, value: value}, prefix), do: [{value, prefix}]
    end

    @spec encode(map) :: list
    def encode(map) do
      cond do
        Map.size(map) == 0 -> []
        Map.size(map) == 1 -> Enum.map(map, fn {key, _} -> {key, "0"} end)
        true ->
          encode_loop(Enum.map(map, fn {key, cnt} -> %HuffmanLeaf{score: cnt, value: key} end), [])
      end
    end

    @spec encode_loop([HuffmanNode.t | HuffmanLeaf.t], [HuffmanNode.t | HuffmanLeaf.t]) :: list
    defp encode_loop([], []), do: %{}
    defp encode_loop([x|[]], []), do: HuffmanCode.code(x, "")
    defp encode_loop([], [x|[]]), do: HuffmanCode.code(x, "")
    defp encode_loop(xs, ys) do
      %{xs: xs, ys: ys, smallest: s1} = deque_smallest(xs, ys)
      %{xs: xs, ys: ys, smallest: s2} = deque_smallest(xs, ys)
      new_node = %HuffmanNode{score: s1.score + s2.score, left: s2, right: s1}
      encode_loop(xs, [new_node|ys])
    end

    @spec deque_smallest([HuffmanNode.t | HuffmanLeaf.t], [HuffmanNode.t | HuffmanLeaf.t]) :: map
    defp deque_smallest(xs, []) do
      smallest_x = find_smallest(xs)
      %{xs: xs -- [smallest_x], ys: [], smallest: smallest_x}
    end
    defp deque_smallest([], ys) do
      smallest_y = find_smallest(ys)
      %{xs: [], ys: ys -- [smallest_y], smallest: smallest_y}
    end
    defp deque_smallest(xs, ys) do
      smallest_x = find_smallest(xs)
      smallest_y = find_smallest(ys)
      if smallest_x.score < smallest_y.score do
        %{xs: xs -- [smallest_x], ys: ys, smallest: smallest_x}
      else
        %{xs: xs, ys: ys -- [smallest_y], smallest: smallest_y}
      end
    end

    @spec find_smallest([HuffmanNode.t | HuffmanLeaf.t]) :: HuffmanNode.t | HuffmanLeaf.t
    defp find_smallest(trees) do
      hd Enum.sort(trees, &(&1.score < &2.score))
    end
  end
end
