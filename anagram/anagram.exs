defmodule Anagram do
  @doc """
  Returns all candidates that are anagrams of, but not equal to, 'base'.
  """
  @spec match(String.t, [String.t]) :: [String.t]
  def match(base, candidates) do
    candidates
    |> Enum.filter(&is_anagram?(base, &1))
  end

  defp is_anagram?(base, candidate) do
    cond do
      downcased(base) == downcased(candidate)   -> false
      normalized(base) == normalized(candidate) -> true
      true                                      -> false
    end
  end

  defp downcased(word), do: String.downcase(word)

  defp normalized(word) do
    word
    |> String.downcase
    |> String.graphemes
    |> Enum.sort
  end
end
