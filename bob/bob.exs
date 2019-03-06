defmodule Bob do
  def hey(input) do
    cond do
      input |> question? -> "Sure."
      input |> nothing?  -> "Fine. Be that way!"
      input |> shouting? -> "Whoa, chill out!"
      true               -> "Whatever."
    end
  end

  defp question?(input), do: input =~ ~r/\?$/
  defp shouting?(input), do: input =~ ~r/[[:upper:]]/ && !(input =~ ~r/[[:lower:]]/)
  defp nothing?(input),  do: input =~ ~r/^\s*$/
end
