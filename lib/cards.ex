#  iex -S mix
defmodule Cards do

    @moduledoc """
        Provides deck of cards
    """
    @doc """
        Returns list of strings as deck of cards
    """

    def create_deck do
        values = ["Ace", "Two", "Three", "Four", "Five"]
        suits = ["Spades","Clubs","Hearts","Diamonds"]

        for suit <- suits , value <- values do
          "#{value} of #{suit}"  
        end    
    end

    @doc """
        Returns shuffled `deck` list of strings 
    """
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
    def contains?(deck,card) do
        Enum.member?(deck,card)
    end

   @doc """
   ## Examples

   iex> deck = Cards.create_deck
   iex> {hand, deck} = Cards.deal(deck, 1)
   iex> hand
   ["Ace of Spades"]

   """
    def deal(deck, hand_size) do
        # returns tuple { hand, deck} both arrays
        Enum.split(deck, hand_size)
    end   

    def save(deck,filename) do
        binary = :erlang.term_to_binary(deck)
        File.write(filename,binary)
    end  

    def load(filename) do
        # File.read(filename)   return tuple  {:ok or :error, binary file or reason for error}
        case File.read(filename) do
            {:ok, binary} -> :erlang.binary_to_term binary
            # _reason tells compiler we dont care using reason
            {:error, _reason} -> "That file does not exist"
        end           
    end 

    def create_hand(hand_size) do
        Cards.create_deck # returns created array to Cards.shuffle as first argument
        |> Cards.shuffle
        |> Cards.deal(hand_size)
    end          
end
