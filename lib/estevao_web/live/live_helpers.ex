defmodule EstevaoWeb.LiveHelpers do
  @moduledoc false
  use Phoenix.Component

  def assign_form(socket, %Ecto.Changeset{} = changeset) do
    assign(socket, :form, to_form(changeset))
  end
end
