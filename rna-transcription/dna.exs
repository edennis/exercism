defmodule DNA do
  @doc """
  Transcribes a character list representing DNA nucleotides to RNA

  ## Examples

  iex> DNA.to_rna('ACTG')
  'UGAC'
  """
  @spec to_rna([char]) :: [char]
  def to_rna([]), do: []
  def to_rna([h|t]) do
    [complement(h) | to_rna(t)]
  end

  defp complement(?A), do: ?U
  defp complement(?C), do: ?G
  defp complement(?T), do: ?A
  defp complement(?G), do: ?C
end
