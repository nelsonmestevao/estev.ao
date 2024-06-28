defmodule EstevaoWeb.Layouts do
  @moduledoc """
  This module is invoked by your endpoint in case of errors on HTML requests.

  See config/config.exs.
  """
  use EstevaoWeb, :html

  embed_templates "layouts/*"
end
