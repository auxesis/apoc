defmodule Apoc.Adapter.MAC do
  @moduledoc """
  Defines a Message Authenticated Code adapter.

      defmodule MyMac do
        use Apoc.Adapter.MAC

        @impl Apoc.Adapter.MAC
        def sign(message, key, opts \\ []) do
          tag = signing_algo(message, key)
          {:ok, tag}
        end

        # ...
      end

  """

  @type key :: binary()
  @type tag :: binary()

  @doc """
  Signs a message by generating a tag with the given key.
  Will return a type of the form `{:ok, tag}` if successful
  or `:error` otherwise.
  """
  @callback sign(
    message :: iodata(),
    key :: key(),
    opts :: Keyword.t()
  ) :: {:ok, tag()} | :error

  @doc """
  Similar to `c:sign/3` except that is returns the tag directly
  and raises `Apoc.Error` in the case of an error.
  """
  @callback sign!(
    message :: iodata(),
    key :: key(),
    opts :: Keyword.t()
  ) :: tag()

  @doc """
  Verifies a message based on a tag generated by `c:sign/3`
  (or `c:sign!/3`). Returns true or false.

  ## Example

      if MyMac.verify(tag, message, key) do
        do_something(message)
      end

  """
  @callback verify(
    tag :: tag(),
    message :: iodata(),
    key :: key(),
    opts :: list()
  ) :: true | false

  defmacro __using__(_) do
    quote do
      @behaviour unquote(__MODULE__)
    end
  end
end