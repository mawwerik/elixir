defmodule DiscussionWeb.TopicController do
  use DiscussionWeb, :controller

  alias Discussion.Repo
  alias Discussion.Topic, as: Topic

  def index(conn, _params) do
    topics = Repo.all(Topic)
    render conn, "index.html", topics: topics
  end

  def new(conn, _params) do
    changeset = Topic.changeset(%Topic{})
    render conn, "new.html", changeset: changeset
  end

  def create(conn, %{"topic" => topic}) do
    changeset = Topic.changeset %Topic{}, topic
    case Repo.insert(changeset) do
      {:ok, post} ->
        conn = put_flash conn, :info, "Topic successfully created"
        redirect conn, to: Routes.topic_path(conn, :index)
      {:error, changeset} ->
        render conn,"new.html", changeset: changeset
    end
  end

  def edit(conn, %{"id" => id}) do
    topic = Repo.get(Topic, id)
    changeset = Topic.changeset(topic)
    render conn, "edit.html", changeset: changeset, topic: topic
  end

  def update(conn, %{"id" =>id, "topic" => topic}) do
    old_topic = Repo.get(Topic, id)
    changeset = Topic.changeset(old_topic, topic)
    case Repo.update(changeset) do
      {:ok, _topic} ->
        conn = put_flash conn, :info, "Topic successfully updated"
        redirect conn, to: Routes.topic_path(conn, :index)
      {:error, changeset} ->
        render conn, "edit.html", changeset: changeset, topic: old_topic
    end
  end

  def delete(conn, %{"id" => id}) do
    topic = Repo.get!(Topic, id)
    case Repo.delete(topic) do
      {:ok, _topic} ->
        conn = put_flash conn, :info, "Topic successfully deleted"
        redirect conn, to: Routes.topic_path(conn, :index)
      {:error, _changeset} ->
        conn = put_flash conn, :error, "Topic could not be deleted"
        redirect conn, to: Routes.topic_path(conn, :index)
    end
  end
end