defmodule LiveviewAppWeb.UserLive.Index do
  use LiveviewAppWeb, :live_view

  alias LiveviewApp.Accounts
  alias LiveviewApp.Accounts.User
  alias LiveviewAppWeb.Router.Helpers, as: Routes
  alias LiveviewAppWeb.UserLive.Index

  @impl true
  def mount(_params, _session, socket) do
    %{entries: entries, page_number: page_number, page_size: page_size, total_entries: total_entries, total_pages: total_pages} =
      if connected?(socket)  do
        Accounts.paginate_users
      else
        %Scrivener.Page{}
      end

    assigns = [
      conn: socket,
      users: entries,
      page_number: page_number || 0,
      page_size: page_size || 0,
      total_entries: total_entries || 0,
      total_pages: total_pages || 0
    ]

    {:ok, assign(socket, assigns)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit User")
    |> assign(:user, Accounts.get_user!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New User")
    |> assign(:user, %User{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Users")
    |> assign(:user, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    user = Accounts.get_user!(id)
    {:ok, _} = Accounts.delete_user(user)

    {:noreply, assign(socket, :users, list_users())}
  end
  def handle_event("nav", %{"page" => page}, socket) do
    {:noreply, live_redirect(socket, to: Routes.live_path(socket, UserLive.Index, page: page))}
  end

  @impl true
  def handle_params(%{"page" => page}, _, socket) do
    assigns = get_and_assign_page(page)
    {:noreply, assign(socket, assigns)}
  end
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end
  def handle_params(_, _, socket) do
    assigns = get_and_assign_page(nil)
    {:noreply, assign(socket, assigns)}
  end

  def get_and_assign_page(page_number) do
    %{
      entries: entries,
      page_number: page_number,
      page_size: page_size,
      total_entries: total_entries,
      total_pages: total_pages
    } = Accounts.paginate_users(page: page_number)

    [
      users: entries,
      page_number: page_number,
      page_size: page_size,
      total_entries: total_entries,
      total_pages: total_pages
    ]
  end

  defp list_users do
    Accounts.list_users()
  end
end
