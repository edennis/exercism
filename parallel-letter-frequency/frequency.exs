defmodule Frequency do
  @worker_timeout_ms 10_000

  @doc """
  Count letter frequency in parallel.

  Returns a map of characters to frequencies.

  The number of worker processes to use can be set with 'workers'.
  """
  @spec frequency([String.t], pos_integer) :: map
  def frequency(texts, workers) do
    texts
    |> create_chunks(workers)
    |> process_chunks(&process_text(&1))
    |> Enum.reduce(%{}, fn results, acc ->
        Map.merge(results, acc, fn _, a, b -> a + b end)
      end)
  end

  defp create_chunks(texts, number) do
    text = Enum.join(texts)
    length = String.length(text)
    chunk_size = div(length, number) + 1

    for n <- 1..number do
      Range.new((n - 1) * chunk_size, (n * chunk_size) - 1)
    end
    |> Enum.map(&String.slice(text, &1))
  end

  defp process_chunks(chunks, processor) do
    results = chunks
              |> Enum.map(&Task.async(fn -> processor.(&1) end))
              |> Task.yield_many(@worker_timeout_ms)
              |> Enum.map(fn {task, res} ->
                            res || Task.shutdown(task, :brutal_kill)
                          end)
    for {:ok, res} <- results do
      res
    end
  end

  defp process_text(text) do
    text
    |> String.downcase
    |> String.replace(~r/[^[:alpha:]]/u, "")
    |> String.graphemes
    |> Enum.reduce(%{}, fn g, acc -> Map.update(acc, g, 1, &(&1 + 1)) end)
  end
end
