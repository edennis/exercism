defmodule Phone do
  @spec number(String.t) :: String.t
  def number(raw) do
    case clean(raw) do
      {:ok, number} -> extract_number(number)
      {:error, _}   -> invalid_number
    end
  end

  defp clean(raw) do
    cleaned = String.replace(raw, ~r{[\(\)\-\.\s]}, "")
    if cleaned =~ ~r{^\d+$} do
      {:ok, cleaned}
    else
      {:error, nil}
    end
  end

  defp extract_number("1" <> number) when byte_size(number) == 10, do: number
  defp extract_number(number) when byte_size(number) == 10, do: number
  defp extract_number(_), do: invalid_number

  defp invalid_number(), do: "0000000000"

  @spec area_code(String.t) :: String.t
  def area_code(raw) do
    num = extract_number(raw)
    hd(Regex.run(~r/\d{3}/, num, capture: :first))
  end

  @spec pretty(String.t) :: String.t
  def pretty(raw) do
    num = extract_number(raw)
    cap = Regex.named_captures(~r/^(?<area_code>\d{3})(?<first>\d{3})(?<second>\d{4})$/, num)
    "(#{cap["area_code"]}) #{cap["first"]}-#{cap["second"]}"
  end
end
