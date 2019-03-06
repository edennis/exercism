defmodule ListOps do
  # Please don't use any external modules (especially List) in your
  # implementation. The point of this exercise is to create these basic functions
  # yourself.
  #
  # Note that `++` is a function from an external module (Kernel, which is
  # automatically imported) and so shouldn't be used either.

  @spec count(list) :: non_neg_integer
  def count(l), do: reduce(l, 0, fn _, acc -> acc + 1 end)

  @spec reverse(list) :: list
  def reverse(l), do: reduce(l, [], fn x, acc -> [x | acc] end)

  @spec map(list, (any -> any)) :: list
  def map(l, f) do
    l
    |> reduce([], fn x, acc -> [f.(x) | acc] end)
    |> reverse
  end

  @spec filter(list, (any -> as_boolean(term))) :: list
  def filter(l, f) do
    l
    |> reduce([], fn x, acc ->
                    cond do
                      f.(x) -> [x | acc]
                      true  -> acc
                    end
                  end)
    |> reverse
  end

  @type acc :: any
  @spec reduce(list, acc, ((any, acc) -> acc)) :: acc
  def reduce([], acc, _), do: acc
  def reduce([h | t], acc, f), do: reduce(t, f.(h, acc), f)

  @spec append(list, list) :: list
  def append(a, b) do
    r = reduce(a, [], fn x, acc -> [x | acc] end)
    r = reduce(b, r, fn x, acc -> [x | acc] end)
    r |> reverse
  end

  @spec concat([[any]]) :: [any]
  def concat(ll) do
    ll
    |> reduce([], fn x, acc -> reduce(x, acc, &[&1 | &2]) end)
    |> reverse
  end
end
