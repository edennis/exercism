defmodule Words do
  @doc """
  Count the number of words in the sentence.

  Words are compared case-insensitively.
  """
  @spec count(String.t) :: map
  def count(sentence) do
    sentence
      |> to_words
      |> Enum.map(&String.downcase/1)
      |> Enum.reduce(%{}, &increment_count/2)
  end

  defp to_words(sentence) do
    sentence |> String.split(~r/[^[:alnum:]\-]+/u, trim: true)
  end

  defp increment_count(word, map) do
    {_, results} = Map.get_and_update(map, word, fn(current_value) ->
      {current_value, (current_value || 0)+1}
    end)
    results
  end
end
