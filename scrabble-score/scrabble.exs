defmodule Scrabble do
  @doc """
  Calculate the scrabble score for the word.
  """
  @spec score(String.t) :: non_neg_integer
  def score(word) do
    word
    |> String.downcase
    |> to_charlist
    |> Enum.map(&points/1)
    |> Enum.sum
  end

  defp points(char) do
    cond do
      char in [?a, ?e, ?i, ?o, ?u, ?l, ?n, ?r, ?s, ?t] -> 1
      char in [?d, ?g]                                 -> 2
      char in [?b, ?c, ?m, ?p]                         -> 3
      char in [?f, ?h, ?v, ?w, ?y]                     -> 4
      char == ?k                                       -> 5
      char in [?j, ?x]                                 -> 8
      char in [?q, ?z]                                 -> 10
      true                                             -> 0
    end
  end
end
