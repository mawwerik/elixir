defmodule Cards do
  @moduledoc """
    Provides methods for creating and handling a deck of cards
  """

  def hello do
    # last value, implicit return value
    # double quote should be used around strings
    "hi there!"
  end

  @doc """
    Returns a list of strings representing a deck of playing cards
  """
  def create_deck() do
    values = ["Ace","Two","Three","Four","Five","Six","Seven","Eight","Nine","Ten","Jack","Queen","King"]
    suites = ["Spades", "Clubs", "Hearts", "Diamonds"]

    # a possible solution
    # cards = for value <- values do
    #   for suit <- suites do
    #     "#{value} of #{suit}"
    #   end
    # end
    # List.flatten(cards)

    # a better solution
    for suit <- suites, value <- values do
      "#{value} of #{suit}"
    end
  end

  def shuffle(deck) do
    Enum.shuffle(deck)
  end

  @doc """
    Determines whether a deck contains a given card

  ## Examples

      iex> deck = Cards.create_deck
      iex> Cards.contains?(deck, "Ace of Spades")
      true
  """
  def contains?(deck, hand) do
    Enum.member?(deck, hand)
  end

  @doc """
    Divides a deck into a hand and the remainder of the deck.
    The `hand_size` argument indicates how many cards should be in the hand.

  ## Examples

      iex> deck = Cards.create_deck
      iex> {hand, _deck} = Cards.deal(deck, 1)
      iex> hand
      ["Ace of Spades"]
  """
  def deal(deck, hand_size) do
    Enum.split(deck, hand_size)
  end

  def save(deck, filename) do
     binary = :erlang.term_to_binary(deck)
     File.write(filename, binary)
  end

  def load(filename) do
    # {status, binary} = File.read(filename)
    case File.read(filename) do
      {:ok, binary} -> :erlang.binary_to_term(binary)
      {:error, _reason} -> "File does not exists"
    end
  end

  def create_hand(hand_size) do
    # use pipe instead of this
    #
    # deck = create_deck
    # deck = shuffle deck
    # deal deck, hand_size

    create_deck()
    |> shuffle()
    |> deal(hand_size)
  end
end

deck = Cards.create_deck
deck = Cards.shuffle(deck)
{hand, _deck} = Cards.deal(deck, 5)
IO.puts hand
