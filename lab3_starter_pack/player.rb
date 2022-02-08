require_relative "element"
require_relative "history"

class Player
    attr_reader :name, :history

    def initialize(name, history)
        @name = name
        @history = history
    end

    def play
        return "fail \"This method should be overridden\""
    end
end

class StupidBot < Player
    def play(opponent_move, n)
        return Rock.new('Rock')
    end
end

class RandomBot < Player
    def play(opponent_move, n)
        prng = Random.new
        move = prng.rand(1..5)
        case move
        when 1
            return Rock.new('Rock')
        when 2
            return Paper.new('Paper')
        when 3
            return Scissors.new('Scissors')
        when 4
            return Lizard.new('Lizard')
        else
            return Spock.new('Spock')
        end
    end
end

class IterativeBot < Player
    def play(opponent_move, n)
        case (n+1)%5
        when 1
            return Rock.new('Rock')
        when 2
            return Paper.new('Paper')
        when 3
            return Scissors.new('Scissors')
        when 4
            return Lizard.new('Lizard')
        else
            return Spock.new('Spock')
        end
    end
end

class LastPlayBot < Player
    def play(opponent_move, n)
        return opponent_move
    end
end

class HumanPlayer < Player
    def play(opponent_move, n)
        flag = true
        while flag
            puts "(1) Rock\n(2) Paper\n(3) Scissors\n(4) Lizard\n(5) Spock\n"
            print "Enter your move: "
            play_move = gets.chomp
            if play_move.to_i < 1 || play_move.to_i > 5
                puts "Invalid move - try again"
            else
                flag = false
            end
        end
        case play_move.to_i
        when 1
            return Rock.new('Rock')
        when 2
            return Paper.new('Paper')
        when 3
            return Scissors.new('Scissors')
        when 4
            return Lizard.new('Lizard')
        else
            return Spock.new('Spock')
        end
    end
end

#p1 = StupidBot.new('StupidBot', History.new)
#p2 = StupidBot.new('StupidBot', History.new)
#p3 = Player.new('StupidBot', History.new)
#p2 = RandomBot.new('RandomBot', History.new)
#p1move = p1.play()
#p2move = p2.play()
#p3move = p3.play()
#puts p3.name
#puts p1move.compare_to(p2move)[0]
#puts p1move.compare_to(p2move)[1]