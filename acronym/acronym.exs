defmodule Acronym do
  @doc """
  Generate an acronym from a string.
  "This is a string" => "TIAS"
  """
  @spec abbreviate(String.t()) :: String.t()
  def abbreviate(string) do
    string
    |> tokenize
    |> abbreviate_tokens
  end

  defp tokenize(string) do
    String.split(string, ~r/[^\w]+/)
  end

  defp abbreviate_tokens([]), do: ""
  defp abbreviate_tokens([h | t]) do
    abbreviate_str(h) <> abbreviate_tokens(t)
  end

  defp abbreviate_str(string) do
    [h | t] = String.graphemes(string)
    String.upcase(h) <> capital_letters(t)
  end

  defp capital_letters(letters) do
    letters
    |> Enum.filter(fn(g) -> g =~ ~r/[A-Z]/ end)
    |> Enum.join
  end
end
