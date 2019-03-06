defmodule BracketPush do
  @brackets %{"(": :")", "[": :"]", "{": :"}"}
  @doc """
  Checks that all the brackets and braces in the string are matched correctly, and nested correctly
  """
  @spec check_brackets(String.t) :: boolean
  def check_brackets(str) do
    case do_check_brackets(str) do
      :ok    -> true
      :error -> false
    end
  end

  defp do_check_brackets(str) do
    str
    |> String.graphemes
    |> Enum.map(&String.to_atom/1)
    |> parse
  end

  defp parse(_, stack \\ [])
  defp parse([], []), do: :ok
  defp parse([], _), do: :error
  defp parse([h|t], [] = stack) do
    cond do
      h |> opening? -> parse(t, [matching(h)])
      h |> closing? -> :error
      true          -> parse(t, stack)
    end
  end
  defp parse([h|t], [h_stack|t_stack] = stack) do
    cond do
      h |> opening?                 -> parse(t, [matching(h) | stack])
      h |> closing? && h == h_stack -> parse(t, t_stack)
      h |> closing? && h != h_stack -> :error
      true                          -> parse(t, stack)
    end
  end

  defp opening?(symbol), do: symbol in Map.keys(@brackets)
  defp closing?(symbol), do: symbol in Map.values(@brackets)

  defp matching(symbol), do: @brackets[symbol]
end