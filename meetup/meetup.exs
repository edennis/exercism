defmodule Meetup do
  @moduledoc """
  Calculate meetup dates.
  """

  @type weekday ::
      :monday | :tuesday | :wednesday
    | :thursday | :friday | :saturday | :sunday

  @type schedule :: :first | :second | :third | :fourth | :last | :teenth

  @doc """
  Calculate a meetup date.

  The schedule is in which week (1..4, last or "teenth") the meetup date should
  fall.
  """
  @spec meetup(pos_integer, pos_integer, weekday, schedule) :: :calendar.date
  def meetup(year, month, weekday, schedule) do
    days = search_week(schedule, :calendar.last_day_of_the_month(year, month))

    day =
      days
      |> Enum.find(&:calendar.day_of_the_week(year, month, &1) == daynum(weekday))

    {year, month, day}
  end

  defp search_week(:first,  _), do: week_range(1)
  defp search_week(:second, _), do: week_range(8)
  defp search_week(:third,  _), do: week_range(15)
  defp search_week(:fourth, _), do: week_range(22)
  defp search_week(:teenth, _), do: week_range(13)
  defp search_week(:last, day), do: week_range(day)

  defp week_range(day) when day >= 28, do: (day - 6)..day
  defp week_range(day), do: day..(day + 6)

  defp daynum(:monday),     do: 1
  defp daynum(:tuesday),    do: 2
  defp daynum(:wednesday),  do: 3
  defp daynum(:thursday),   do: 4
  defp daynum(:friday),     do: 5
  defp daynum(:saturday),   do: 6
  defp daynum(:sunday),     do: 7
end
