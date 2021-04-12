defmodule Broth.Message.Room.GetInviteList do
  use Broth.Message.Call

  @primary_key false
  embedded_schema do
    field(:cursor, :integer, default: 0)
    field(:limit, :integer, default: 100)
  end

  import Ecto.Changeset

  def changeset(initializer \\ %__MODULE__{}, data) do
    initializer
    |> cast(data, [:cursor, :limit])
    |> validate_number(:limit, greater_than: 0, message: "too low")
  end

  defmodule Reply do
    use Broth.Message.Push, operation: "room:get_invite_list:reply"

    @primary_key false

    embedded_schema do
      embeds_many(:invites, Beef.Schemas.User)
      field(:next_cursor, :integer)
      field(:initial, :boolean)
    end
  end
end