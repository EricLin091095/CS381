class Element
    attr_accessor :name

    def initialize(name)
        @name = name
    end

    def compare_to(compare)
        return "fail \"This method should be overridden\""
    end
end

class Rock < Element
    def compare_to(compare)
        if compare.class == Rock
            return "Rock equals Rock", "Tie"
        elsif compare.class == Paper
            return "Paper covers Rock", "Lose"
        elsif compare.class == Scissors
            return "Rock crushes Scissors", "Win"
        elsif compare.class == Lizard
            return "Rock crushes Lizard", "Win"
        else
            return "Spock vaporizes Rock", "Lose"
        end
    end
end

class Paper < Element
    def compare_to(compare)
        if compare.class == Paper
            return "Paper equals Paper", "Tie"
        elsif compare.class == Rock
            return "Paper covers Rock", "Win"
        elsif compare.class == Scissors
            return "Scissors cut Paper", "Lose"
        elsif compare.class == Lizard
            return "Lizard eats Paper", "Lose"
        else
            return "Paper disproves Spock", "Win"
        end
    end
end

class Scissors < Element
    def compare_to(compare)
        if compare.class == Scissors
            return "Scissors equals Scissors" , "Tie"
        elsif compare.class == Paper
            return "Scissors cut Paper", "Win"
        elsif compare.class == Rock
            return "Rock crushes Scissors", "Lose"
        elsif compare.class == Lizard
            return "Scissors decapitate Lizard", "Win"
        else
            return "Spock smashes Scissors", "Lose"
        end
    end
end

class Lizard < Element
    def compare_to(compare)
        if compare.class == Lizard
            return "Lizard equals Lizard", "Tie"
        elsif compare.class == Paper
            return "Lizard eats Paper", "Win"
        elsif compare.class == Scissors
            return "Scissors decapitate Lizard", "Lose"
        elsif compare.class == Rock
            return "Rock crushes Lizard", "Lose"
        else
            return "Lizard poisons Spock", "Win"
        end
    end
end

class Spock < Element
    def compare_to(compare)
        if compare.class == Spock
            return "Spock equals Spock", "Tie"
        elsif compare.class == Paper
            return "Paper disproves Spock", "Lose"
        elsif compare.class == Scissors
            return "Spock smashes Scissors", "Win"
        elsif compare.class == Lizard
            return "Lizard poisons Spock", "Lose"
        else
            return "Spock vaporizes Rock", "Win"
        end
    end
end

#ele = Element.new('Rock')
#puts ele.compare_to(ele)
#rock  = Rock.new('Rock')
#paper = Paper.new('Paper')
#puts rock.compare_to(paper)
#puts paper.compare_to(rock)
#puts rock.compare_to(rock)