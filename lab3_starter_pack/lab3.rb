require_relative "element"   # uncomment to load element.rb
require_relative "player"    # uncomment to load player.rb 
require_relative "history"   # uncomment to load history.rb

######################################### 	
#     CS 381 - Programming Lab #3		#
#										#
#  < Lin Tsu Ching >					#
#  < lintsuc@oregonstate.edu >	        #
#										#
#########################################



# your code here



def game(rounds)

	# init things
	i = 0
	flag = true
	player_dic = {1 => "StupidBot", 2 => "RandomBot", 3 => "IterativeBot", 4 => "LastPlayBot", 5 => "Human"}

	# ensure player enter right number
	puts "Welcome to Rock, Paper, Scissors, Lizard, Spock!\n\n"
	puts "Please choose two players:\n(1) StupidBot\n(2) RandomBot\n(3) IterativeBot\n(4) LastPlayBot\n(5) Human\n"
	while flag
		#puts "Select player 1: "
		@player_1 = gets.chomp
		#puts "Select player 2: "
		@player_2 = gets.chomp
		if @player_1.to_i > 5 || @player_1.to_i < 1 || @player_2.to_i > 5 || @player_2.to_i < 1
			print "Select player 1:Select player 2:Invalid choice(s) - start over\n\n"
		else
			flag = false
			puts "Select player 1:Select player 2:#{player_dic[@player_1.to_i]} vs. #{player_dic[@player_2.to_i]}\n\n"
		end
	end
	#puts "Select player 1:Select player 2:#{player_dic[@player_1.to_i]} vs. #{player_dic[@player_2.to_i]}\n\n"

	# create player1
	case player_dic[@player_1.to_i]
	when "StupidBot"
		p1 = StupidBot.new(player_dic[@player_1.to_i], History.new)
	when "RandomBot"
		p1 = RandomBot.new(player_dic[@player_1.to_i], History.new)
	when "IterativeBot"
		p1 = IterativeBot.new(player_dic[@player_1.to_i], History.new)
	when "LastPlayBot"
		p1 = LastPlayBot.new(player_dic[@player_1.to_i], History.new)
	else
		p1 = HumanPlayer.new(player_dic[@player_1.to_i], History.new)
	end

	# create player2
	case player_dic[@player_2.to_i]
	when "StupidBot"
		p2 = StupidBot.new(player_dic[@player_2.to_i], History.new)
	when "RandomBot"
		p2 = RandomBot.new(player_dic[@player_2.to_i], History.new)
	when "IterativeBot"
		p2 = IterativeBot.new(player_dic[@player_2.to_i], History.new)
	when "LastPlayBot"
		p2 = LastPlayBot.new(player_dic[@player_2.to_i], History.new)
	else
		p2 = HumanPlayer.new(player_dic[@player_2.to_i], History.new)
	end

	tmp_p1_move = Rock.new('Rock')
	tmp_p2_move = Rock.new('Rock')
	while (i < rounds)
		puts "Round #{i+1}:"
		
		p1_move = p1.play(tmp_p2_move, i)
		p2_move = p2.play(tmp_p1_move, i)
		tmp_p1_move = p1_move
		tmp_p2_move = p2_move
		puts "Player 1 chose #{p1_move.name}"
		puts "Player 2 chose #{p2_move.name}"

		p1.history.log_play(p1_move.name)
		p1.history.log_opponent_play(p2_move.name)
		p2.history.log_play(p2_move.name)
		p2.history.log_opponent_play(p1_move.name)

		if p1_move.compare_to(p2_move)[1] == "Win"
			puts p1_move.compare_to(p2_move)[0]
			puts "Player 1 won the round\n\n"
			p1.history.add_score
		elsif p1_move.compare_to(p2_move)[1] == "Lose"
			puts p1_move.compare_to(p2_move)[0]
			puts "Player 2 won the round\n\n"
			p2.history.add_score
		else
			puts p1_move.compare_to(p2_move)[0]
			puts "Round was a tie\n\n"
		end
		i += 1
	end
	puts "Final score is #{p1.history.score} to #{p2.history.score}"
	if p1.history.score == p2.history.score
		puts "Game was a draw"
	elsif p1.history.score > p2.history.score
		puts "Player 1 wins"
	else
		puts "Player 2 wins"
	end
end


# Main Program (should be last)
n_rounds = 5
# call to kick off the game
game(n_rounds)