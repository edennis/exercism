defmodule Roman do
  @doc """
  Convert the number to a roman number.
  """
  @spec numerals(pos_integer) :: String.t
  def numerals(number) do
    do_numerals(number, divisors_lt_or_eq(number))
  end

  defp do_numerals(0, _), do: ""
  defp do_numerals(number, [divisor|remaining_divisors]) do
    quotient = div(number, divisor)
    remainder = rem(number, divisor)
    cond do
      quotient > 0 ->
        String.duplicate(roman(divisor), quotient) <> do_numerals(remainder, remaining_divisors)
      remainder > 0 ->
        do_numerals(remainder, remaining_divisors)
      true ->
        roman(number)
    end
  end

  defp divisors_lt_or_eq(number) do
    divisors |> Enum.filter(&(&1 <= number))
  end

  defp divisors, do: [1000, 900, 500, 400, 100, 90, 50, 40, 10, 9, 5, 4, 1]

  defp roman(1000), do: "M"
  defp roman(900),  do: "CM"
  defp roman(500),  do: "D"
  defp roman(400),  do: "CD"
  defp roman(100),  do: "C"
  defp roman(90),   do: "XC"
  defp roman(50),   do: "L"
  defp roman(40),   do: "XL"
  defp roman(10),   do: "X"
  defp roman(9),    do: "IX"
  defp roman(5),    do: "V"
  defp roman(4),    do: "IV"
  defp roman(1),    do: "I"
end
