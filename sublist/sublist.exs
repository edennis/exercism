defmodule Sublist do
  @doc """
  Returns whether the first list is a sublist or a superlist of the second list
  and if not whether it is equal or unequal to the second list.
  """
  def compare(a, b) when is_list(a) and is_list(b) do
    cond do
      a === b             -> :equal
      a |> sublist_of?(b) -> :sublist
      b |> sublist_of?(a) -> :superlist
      true                -> :unequal
    end
  end

  defp sublist_of?([], _), do: true
  defp sublist_of?(_, []), do: false
  defp sublist_of?(a, b) when length(a) > length(b), do: false
  defp sublist_of?(a, [_|tail] = b) do
    cond do
      a |> starts_with?(b) -> true
      true                 -> a |> sublist_of?(tail)
    end
  end

  defp starts_with?([], _), do: true
  defp starts_with?([ha|ta], [hb|tb]) do
    cond do
      ha === hb -> starts_with?(ta, tb)
      true      -> false
    end
  end
end
