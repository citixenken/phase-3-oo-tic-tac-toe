class TicTacToe
    attr_accessor :board, :winning_player, :winning_combo

    def initialize
        @board = [" "," "," "," "," "," "," "," "," "]
        @winning_player = ""
        @winning_combo = []
    end

    WIN_COMBINATIONS = [
        [0,1,2],
        [3,4,5],
        [6,7,8],
        [0,3,6],
        [1,4,7],
        [2,5,8],
        [0,4,8],
        [2,4,6]
    ]
 
    def display_board
        puts " #{self.board[0]} | #{self.board[1]} | #{self.board[2]} "
        puts "-----------" 
        puts " #{self.board[3]} | #{self.board[4]} | #{self.board[5]} "
        puts "-----------" 
        puts " #{self.board[6]} | #{self.board[7]} | #{self.board[8]} "
    end

    def input_to_index(user_input)
        user_input.to_i - 1
    end

    def move(index, token="X")
        self.board[index] = token
    end

    #not empty
    def position_taken?(index)
        self.board[index] != " "
    end

    #empty
    def valid_move?(index)
        index.between?(0,8) && !position_taken?(index)
    end

    def turn_count
        self.board.grep(/[O,X]/).length #regex
    end

    def current_player
        turn_count.odd? ? "O" : "X"
    end

    #pseudocode => turn method
    #===========
    # ask for input
    # get input
    # translate input into index
    # if index is valid
    #     make the move for index
    #     show the board
    # else
    #     restart turn
    # end
    def turn
        puts "Enter number between 1 and 9: "
        user_input = gets.chomp #removes new line
        selected_index = input_to_index(user_input)
        token = current_player
        
        if valid_move?(selected_index)
            move(selected_index, token)
            display_board
        else
            puts "Invalid move. Try again."
            turn #recursion
        end
        # display_board
    end

    def won?
        WIN_COMBINATIONS.each do |combo|
            if self.board[combo[0]] == "X" && self.board[combo[1]] == "X" && self.board[combo[2]] == "X"
                self.winning_player = "X"
                winning_combo = combo
                return combo
            elsif
                self.board[combo[0]] == "O" && self.board[combo[1]] == "O" && self.board[combo[2]] == "O"
                self.winning_player = "O"
                winning_combo = combo
                return combo
            end
        end
        return false
    end

    def full?
        self.board.all? { |tile|  tile != " "}   
    end

    def draw?
        full? && !won?
    end

    def over?
        draw? || won?
    end

    def winner
        if won?
            return self.winning_player
        end
    end

    # main method => pseudocode
    #==========================
    #   until the game is over
    #     take turns
    #   end
      
    #   if the game was won
    #     congratulate the winner
    #   else if the game was a draw
    #     tell the players it ended in a draw
    #   end
    def play
        turn until over? 
        puts winner ? "Congratulations #{winner}!" : "Cat's Game!"
    end
end