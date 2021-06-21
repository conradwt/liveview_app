# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     LiveviewApp.Repo.insert!(%LiveviewApp.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias LiveviewApp.Repo
alias LiveviewApp.Accounts
alias LiveviewApp.Accounts.User

for _ <- 1..100 do
  user =
    %{
      name: Faker.Person.name(),
      age: Enum.random(1..100)
    }

  Accounts.create_user(user)
end
