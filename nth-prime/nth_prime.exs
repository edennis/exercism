defmodule Prime do

  @doc """
  Generates the nth prime.
  """
  @spec nth(non_neg_integer) :: non_neg_integer
  def nth(count) do
    do_nth(count, [])
  end

  defp do_nth(count, primes) when count > 0 do
    if length(primes) == count do
      hd(primes)
    else
      do_nth(count, [next_prime(primes)|primes])
    end
  end

  defp next_prime([]), do: 2
  defp next_prime([2]), do: 3
  defp next_prime(primes), do: next_prime(primes, hd(primes) + 2)
  defp next_prime(primes, n) do
    if is_prime(n, primes) do
      n
    else
      next_prime(primes, n + 2)
    end
  end

  defp is_prime(n, primes) do
    sqrt = :math.sqrt(n)
    primes
    |> Enum.filter(&(&1 <= sqrt && &1 != 2 && rem(n, &1) == 0))
    |> Enum.empty?
  end

end
