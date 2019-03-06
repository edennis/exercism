defmodule DNA do
  @nucleotides [?A, ?C, ?G, ?T]

  @doc """
  Counts individual nucleotides in a DNA strand.

  ## Examples

  iex> DNA.count('AATAA', ?A)
  4

  iex> DNA.count('AATAA', ?T)
  1
  """
  @spec count([char], char) :: non_neg_integer
  def count(strand, nucleotide) do
    count(strand, nucleotide, 0)
  end

  defp count('',      nucleotide, acc) when nucleotide in @nucleotides, do: acc
  defp count([h | t], nucleotide, acc) when nucleotide in @nucleotides and h in @nucleotides do
    cond do
      h == nucleotide -> count(t, nucleotide, acc+1)
      true            -> count(t, nucleotide, acc)
    end
  end

  defp count(_, _, _), do: raise ArgumentError

  @doc """
  Returns a summary of counts by nucleotide.

  ## Examples

  iex> DNA.histogram('AATAA')
  %{?A => 4, ?T => 1, ?C => 0, ?G => 0}
  """
  @spec histogram([char]) :: map
  def histogram(strand) do
    Enum.reduce(@nucleotides, %{}, fn(nucleotide, map) ->
      Map.put(map, nucleotide, count(strand, nucleotide))
    end)
  end
end
