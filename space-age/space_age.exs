defmodule SpaceAge do
  @type planet :: :mercury | :venus | :earth | :mars | :jupiter
                | :saturn | :neptune | :uranus

  @doc """
  Return the number of years a person that has lived for 'seconds' seconds is
  aged on 'planet'.
  """
  @spec age_on(planet, pos_integer) :: float
  def age_on(planet, seconds) do
    seconds / solar_year_in_seconds(planet)
  end

  defp solar_year_in_seconds(:earth) do
    60*60*24*365.25
  end

  defp solar_year_in_seconds(planet) do
    solar_year_in_seconds(:earth) * orbital_period(planet)
  end

  defp orbital_period(planet) do
    [
      mercury: 0.2408467,
      venus: 0.61519726,
      mars: 1.8808158,
      jupiter: 11.862615,
      saturn: 29.447498,
      uranus: 84.016846,
      neptune: 164.79132
    ][planet]
  end
end
